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
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/
DECLARE

v_count integer;
v_consulta    varchar;
v_parametros  record;
v_resp          varchar;
v_nombre_funcion   text;
v_mensaje_error    text;

v_id_usuario integer;
v_cuenta varchar;
v_nombre varchar;
v_apellido_paterno varchar;
v_apellido_materno varchar;
v_estilo varchar;
v_num_fallidos integer;
v_cont_alertas integer;
v_autentificacion varchar;
v_id_persona integer;
v_id_funcionario integer;
v_contrasena varchar;

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
***********************************/

     if(par_transaccion='SEG_VALUSU_SEG')then
          --consulta:=';
          BEGIN

          --verifica si el usuario y contrasena introducidos estan habilitados
          
           --     
            v_id_usuario=null;
            SELECT 
                  u.id_usuario,u.cuenta,p.nombre,p.apellido_paterno,
                  p.apellido_materno,u.estilo,u.autentificacion,p.id_persona,u.contrasena
            INTO
                  v_id_usuario,v_cuenta,v_nombre,v_apellido_paterno,
                  v_apellido_materno,v_estilo,v_autentificacion,v_id_persona,v_contrasena
            FROM segu.tusuario u 
            INNER JOIN segu.tpersona p  
                	ON  p.id_persona = u.id_persona
            WHERE u.cuenta=v_parametros.login
                   -- AND u.contrasena=v_parametros.password
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
                RAISE EXCEPTION 'Credenciales de Usuario Invalidas';
           END IF;
  
              --verificamos si el usuario tiene alertas
              v_cont_alertas = 0;
              
              SELECT count(id_alarma) ,ala.id_funcionario
              into v_cont_alertas,v_id_funcionario
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
                    SELECT id_funcionario into  v_id_funcionario
                    FROM orga.tfuncionario fun 
                    WHERE fun.id_persona = v_id_persona and fun.estado_reg = 'activo';
              END IF;
              
              
              v_cont_alertas=COALESCE(v_cont_alertas,0);
              --raise exception '%',v_id_funcionario;
                    

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario autorizado'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'cuenta',v_cuenta);
               v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_nombre);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_paterno',v_apellido_paterno);
               v_resp = pxp.f_agrega_clave(v_resp,'apellido_materno',v_apellido_materno);
               v_resp = pxp.f_agrega_clave(v_resp,'estilo',v_estilo);
               v_resp = pxp.f_agrega_clave(v_resp,'cont_alertas',v_cont_alertas::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_id_funcionario::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'autentificacion',v_autentificacion::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'contrasena',v_contrasena::varchar);
              
              --raise exception '%',v_resp;
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
  	    v_resp = pxp.f_agrega_clave(v_resp,'usuario',v_parametros.login);
	    raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;