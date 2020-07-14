--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_validar_usuario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.fvalidar_usuario
 DESCRIPCIÓN: 	verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion
 AUTOR: 		KPLIAN(rac)
 FECHA:			26/07/2010
 COMENTARIOS:
***************************************************************************

 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA       AUTOR           DESCRIPCION
#133               29-05-2020     RAC           mensaje traducido
#179 KPLIAN        13.06.2020     RAC           autentificacion con google o facebook
#179 KPLIAN        13.06.2020     JRR           User signup with default role
#179 KPL           10.07.2020     RAC           Al validar usuario si no existe y viene por facebook o google creamos el usuario
***************************************************************************/
DECLARE

v_count integer;
v_consulta    varchar;
v_parametros  record;
v_registros		record;
v_resp          varchar;
v_nombre_funcion   text;
v_mensaje_error    text;

v_id_usuario integer;
v_cuenta varchar;
v_nombre varchar;
v_correo varchar;
v_apellido_paterno varchar;
v_apellido_materno varchar;
v_estilo varchar;
v_num_fallidos integer;
v_cont_alertas integer;
v_autentificacion varchar;
v_id_persona integer;
v_id_funcionario integer;
v_contrasena varchar;
v_id_cargo integer;
v_cont_interino  integer;
v_token          varchar; --#179
v_login          varchar; --#179

/*

'login'
'password'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN
     v_nombre_funcion:='segu.ft_validar_usuario_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************
 #TRANSACCION: SEG_VALUSU_SEG
 #DESCRIPCION:	verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion
 #AUTOR:		KPLIAN(rac)
 #FECHA:		16-11-2010
 *******************************

 #DESCRIPCION_MOD:	(1) se introduce el campo de tipo de autentificacion para
  					autentificar con tra LDAP,
                    (2) se verifica si la contrasena es ldap
                    (3) se aumenta un contador que devuelve la cantidad de alarmas para mostrar al usuario


 #AUTOR_MOD:		KPLIAN(rac)
 #FECHA_MOD:		22-11-2011
  *******************************

 #DESCRIPCION_MOD:	(1) se aumenta la verificacion de interinos


 #AUTOR_MOD:		KPLIAN(rac)
 #FECHA_MOD:		20-05-2014

***********************************/

     if(par_transaccion='SEG_VALUSU_SEG')then
          --consulta:=';
          BEGIN

            IF pxp.f_existe_parametro(par_tabla, 'login') THEN
                v_login = v_parametros.login;
            ELSE
                v_login = v_parametros.email;
            END IF;
            
            -- verifica si el usuario y contrasena introducidos estan habilitados
            v_id_usuario=null;
            SELECT
                  u.id_usuario,
                  u.cuenta,
                  p.nombre,
                  p.apellido_paterno,
                  p.apellido_materno,
                  u.estilo,
                  u.autentificacion,
                  p.id_persona,
                  u.contrasena,
                  u.token
            INTO
                  v_id_usuario,
                  v_cuenta,
                  v_nombre,
                  v_apellido_paterno,
                  v_apellido_materno,
                  v_estilo,
                  v_autentificacion,
                  v_id_persona,
                  v_contrasena,
                  v_token
            FROM segu.tusuario u
            INNER JOIN segu.tpersona p
                	ON  p.id_persona = u.id_persona
            WHERE u.cuenta = v_login
            AND u.fecha_caducidad >= now()::date
            AND u.estado_reg='activo';


             -- VERIFICA si LA autentificacion es local o por LDAP
            IF(v_autentificacion='local') THEN
              --SI ES LOCAL VERIFICAMOS SI LA CONTRAENIA ES CORRECTA
               IF(v_contrasena!=v_parametros.password)THEN
                       v_id_usuario=null;
               END IF;

            END IF;

           
          
            IF(v_id_usuario is null) THEN
            
                IF pxp.f_existe_parametro(par_tabla, 'type') THEN
                  IF v_parametros.type in ('facebook','google') THEN
                    
                    v_id_usuario = segu.f_create_user_oauth(par_administrador, par_id_usuario, v_parametros);
                    
                    SELECT
                          u.id_usuario,
                          u.cuenta,
                          p.nombre,
                          p.apellido_paterno,
                          p.apellido_materno,
                          u.estilo,
                          u.autentificacion,
                          p.id_persona,
                          u.contrasena,
                          u.token
                    INTO
                          v_id_usuario,
                          v_cuenta,
                          v_nombre,
                          v_apellido_paterno,
                          v_apellido_materno,
                          v_estilo,
                          v_autentificacion,
                          v_id_persona,
                          v_contrasena,
                          v_token
                    FROM segu.tusuario u
                    INNER JOIN segu.tpersona p  ON  p.id_persona = u.id_persona
                    WHERE u.id_usuario = v_id_usuario;
                    
                  END IF;
                ELSE
                  raise exception 'No existe el usuario o esta inactivo';
                END IF;
                
            END IF;

              --verificamos si el usuario tiene alertas
              v_cont_alertas = 0;

              SELECT
                   count(id_alarma) ,
                   ala.id_funcionario
              into
                  v_cont_alertas,
                  v_id_funcionario
              FROM  param.talarma ala
              LEFT JOIN orga.tfuncionario fun
                on fun.id_funcionario = ala.id_funcionario
              and ala.estado_reg = 'activo' and fun.estado_reg = 'activo'
              WHERE (    fun.id_persona = v_id_persona
                      or ala.id_usuario = v_id_usuario)
              GROUP BY ala.id_funcionario, id_alarma;




              --obtenemos el funcionario para el usuario
              --asumimos que una persona solo puede tener un funcionario
              --este este inactivo o activo

              IF(v_id_funcionario is null) THEN
                    SELECT
                       id_funcionario
                     into
                       v_id_funcionario
                    FROM orga.tfuncionario fun
                    WHERE
                         fun.id_persona = v_id_persona
                    and  fun.estado_reg = 'activo';
              END IF;

              --obtenermos el cargo
              IF(v_id_funcionario is not null) THEN

                    SELECT
                        uof.id_cargo
                      into
                        v_id_cargo
                    FROM orga.tuo_funcionario  uof
                    WHERE uof.id_funcionario =  v_id_funcionario
                          and uof.tipo = 'oficial'
                          and uof.estado_reg = 'activo'
                          and uof.fecha_asignacion <= now()
                          and (uof.fecha_finalizacion >=now() or   uof.fecha_finalizacion is NULL);



            END IF;


              -- obtenermos el numero de suplentes

               IF(v_id_cargo is not null) THEN

                  select
                    count(int.id_interinato) into v_cont_interino
                  from orga.tinterinato int
                  where
                          now()::Date BETWEEN  int.fecha_ini  and int.fecha_fin
                     and  int.id_cargo_suplente =  v_id_cargo
                     and int.estado_reg='activo';

               END IF;

               v_cont_alertas=COALESCE(v_cont_alertas,0);
               v_cont_interino=COALESCE(v_cont_interino,0);

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario autorizado');
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'cuenta',v_cuenta);
               v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_nombre);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_paterno',v_apellido_paterno);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_materno',v_apellido_materno);
               v_resp = pxp.f_agrega_clave(v_resp,'estilo',v_estilo);
               v_resp = pxp.f_agrega_clave(v_resp,'cont_alertas',v_cont_alertas::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'cont_interino',v_cont_interino::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_id_funcionario::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_id_cargo::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'autentificacion',v_autentificacion::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'contrasena',v_contrasena::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'token',v_token::varchar); -- #179 verificar de usuarios de googe o facebook

               return v_resp;

          END;

     elsif(par_transaccion='SEG_LISTUSU_SEG')then
		BEGIN
     		SELECT
                  u.id_usuario,u.cuenta,p.nombre,p.apellido_paterno,
                  p.apellido_materno,u.estilo,u.autentificacion,p.id_persona,u.contrasena
            INTO
                  v_id_usuario,v_cuenta,v_nombre,v_apellido_paterno,
                  v_apellido_materno,v_estilo,v_autentificacion,v_id_persona,v_contrasena
            FROM segu.tusuario u
            INNER JOIN segu.tpersona p
                	ON  p.id_persona = u.id_persona
            WHERE u.cuenta=v_parametros.login and u.estado_reg = 'activo';

            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario encontrado');
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'cuenta',v_cuenta);
               v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_nombre);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_paterno',v_apellido_paterno);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_materno',v_apellido_materno);
               v_resp = pxp.f_agrega_clave(v_resp,'estilo',v_estilo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'autentificacion',v_autentificacion::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'contrasena',v_contrasena::varchar);
               return v_resp;
     	END;

     /*******************************
     #TRANSACCION:  SEG_GETKEY_SEG
     #DESCRIPCION:	recupera las llaves de encriptacion de la ultima sesion vlaida del usuario
     #AUTOR:		KPLIAN(rac)
     #FECHA:		12/03/2015
    ***********************************/
     elseif (par_transaccion='SEG_GETKEY_SEG')then
          BEGIN

               SELECT
                ses.m,
                ses.e,
                ses.k,
                ses.p,
                ses.x,
                ses.z
               into
                 v_registros

              FROM segu.tusuario u
              INNER JOIN segu.tsesion ses on ses.id_usuario = u.id_usuario
              WHERE u.cuenta=v_parametros.login AND u.estado_reg='activo';



              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','llaves actualizadas');
              v_resp = pxp.f_agrega_clave(v_resp,'m',v_registros.m::varchar);
              v_resp = pxp.f_agrega_clave(v_resp,'e',v_registros.e::varchar);
              v_resp = pxp.f_agrega_clave(v_resp,'k',v_registros.k::varchar);
              v_resp = pxp.f_agrega_clave(v_resp,'p',v_registros.p::varchar);
              v_resp = pxp.f_agrega_clave(v_resp,'x',v_registros.x::varchar);
              v_resp = pxp.f_agrega_clave(v_resp,'z',v_registros.z::varchar);


            return v_resp;

         END;
     /*******************************
      #TRANSACCION:  SEG_RESPASS_SEG
      #DESCRIPCION:	funcion para generar un token para el usuario con validez de x horas parametrizadas en
      la variable global segu_token_expiration
      #AUTOR:		KPLIAN(jrr)
      #FECHA:		11-06-2020
      ***********************************/

     elsif(par_transaccion='SEG_RESPASS_SEG')then

        BEGIN
         --verificar si el usuario existe y esta activo
            select id_usuario, p.correo, p.nombre into v_id_usuario, v_correo, v_nombre
            from segu.tusuario u
            inner join segu.tpersona p on p.id_persona = u.id_persona
            where u.cuenta=v_parametros.login or p.correo =  v_parametros.login
              and u.estado_reg='activo';
            if(v_id_usuario is null) then
               raise exception 'No existe el usuario o correo ingresado';
            end if;
            v_token = pxp.f_generate_token(15);
            update segu.tusuario
            set reset_token = v_token,
            token_expiration = now() + (pxp.f_get_variable_global('segu_token_expiration') || ' hour')::interval
            where id_usuario = v_id_usuario;


            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Reset token generado correctamente para el usuario '||v_id_usuario);
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'mail_template',pxp.f_get_variable_global('pxp_mail_templates')::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'token', v_token);
            v_resp = pxp.f_agrega_clave(v_resp,'name', v_nombre);
            v_resp = pxp.f_agrega_clave(v_resp,'email', v_correo);
            return v_resp;
         END;
      /*******************************
      #TRANSACCION:  SEG_SIGNUP_SEG
      #DESCRIPCION:	user signup with default role
      #AUTOR:		KPLIAN(jrr)
      #FECHA:		11-06-2020
      ***********************************/

     elsif(par_transaccion='SEG_SIGNUP_SEG')then

        BEGIN
          --call to signup function
          v_id_usuario := segu.f_signup(
              v_parametros.email,
              v_parametros.name,
              v_parametros.surname,
              v_parametros.login,
              v_parametros.password
          );

          select reset_token into v_token
          from segu.tusuario
          where id_usuario = v_id_usuario;

          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario creado correctamente '||v_id_usuario);
          v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
          v_resp = pxp.f_agrega_clave(v_resp,'mail_template',pxp.f_get_variable_global('pxp_mail_templates')::varchar);
          v_resp = pxp.f_agrega_clave(v_resp,'token', v_token);
          return v_resp;
        END;

       /*******************************
      #TRANSACCION:  SEG_UPDPASS_SEG
      #DESCRIPCION:	Actualiza el password si el token es valido
      #AUTOR:		KPLIAN(jrr)
      #FECHA:		11-06-2020
      ***********************************/

     elsif(par_transaccion='SEG_UPDPASS_SEG')then

        BEGIN
         --verificar si el usuario existe y esta activo
            select id_usuario into v_id_usuario
            from segu.tusuario u
            where u.reset_token=v_parametros.token and u.token_expiration > now();
            if(v_id_usuario is null) then
               raise exception 'El token es invalido o ha expirado';
            end if;

            update segu.tusuario
            set reset_token = NULL,
            token_expiration = NULL,
            contrasena_anterior= contrasena,
            contrasena = md5(v_parametros.password)
            where id_usuario = v_id_usuario;


            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Reset token generado correctamente para el usuario '||v_id_usuario);
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_nombre::varchar);
            return v_resp;
         END;

     /*******************************
      #TRANSACCION:  SEG_SGNUPCON_SEG
      #DESCRIPCION:	Activa el usuario despues de validar el token
      #AUTOR:		KPLIAN(jrr)
      #FECHA:		11-06-2020
      ***********************************/

     elsif(par_transaccion='SEG_SGNUPCON_SEG')then

        BEGIN
         --verificar si el usuario existe y esta activo
            select id_usuario into v_id_usuario
            from segu.tusuario u
            where u.reset_token=v_parametros.token and u.token_expiration > now();
            if(v_id_usuario is null) then
               raise exception 'El token es invalido o ha expirado';
            end if;

            update segu.tusuario
            set reset_token = NULL,
            token_expiration = NULL,
            estado_reg = 'activo'
            where id_usuario = v_id_usuario;

            select p.nombre into v_nombre
            from segu.tusuario u
            inner join segu.tpersona p on p.id_persona = u.id_persona
            where u.id_usuario = v_id_usuario;


            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario activado correctamente '||v_id_usuario);
            v_resp = pxp.f_agrega_clave(v_resp,'name',v_nombre::varchar);
            return v_resp;
         END;

     else
         raise exception 'No existe la opcion';

      end if;

EXCEPTION

      WHEN OTHERS THEN
    	v_resp='';
	    v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  	    v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
  	    --v_resp = pxp.f_agrega_clave(v_resp,'usuario',v_parametros.login);
	    raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
PARALLEL UNSAFE
COST 100;