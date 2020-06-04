--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_usuario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************

 FUNCION: 		segu.ft_usuario_ime
 DESCRIPCIÓN: 	Permite registrar de de usuarios
 AUTOR: 		KPLIAN(rac)
 FECHA:			19/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
 
 
  ISSUE            FECHA:              AUTOR                 DESCRIPCION 
  #0             19/07/2010        RAC                 creacion
  #97            17/06/2019        RAC                 adcionar funcionalidad para copia de roles y eps
  #179 KPL       03/06/2020        RAC                 creacion de usuario para autentificacion google facebook
***************************************************************************/

DECLARE


v_parametros           record;
v_respuesta            varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id_usuario integer;
v_resp varchar;
v_id_roles varchar[];
v_i integer;
v_tamano integer;
--05-04-2012
v_respuesta_sinc       varchar;


v_sincronizar varchar;
v_sincronizar_user varchar;
v_sincronizar_password varchar;
v_sincronizar_base varchar;
v_sincronizar_ip varchar;
v_sincronizar_puerto varchar;
v_reg_roles    record; --#97
v_reg_eps      record; --#97
v_count_rol    integer; --#97
v_count_ep     integer; --#97
v_id_clasificador       integer; --#179
v_id_persona            integer; --#179
v_tmp_ci                varchar; --#179
v_rol_def               varchar; --#179
v_id_rol                integer; --#179






BEGIN

     v_nombre_funcion:='segu.ft_usuario_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
     
     /*
     Obtener variables globales para definir la sincronizacion
     
     */
     
    v_sincronizar = pxp.f_get_variable_global('sincronizar');
	v_sincronizar_user= pxp.f_get_variable_global('sincronizar_user');
	v_sincronizar_password = pxp.f_get_variable_global('sincronizar_password');
	v_sincronizar_base= pxp.f_get_variable_global('sincronizar_base');
	v_sincronizar_ip= pxp.f_get_variable_global('sincronizar_ip');
	v_sincronizar_puerto=pxp.f_get_variable_global('sincronizar_puerto');
    
   
     
    
     
     
 /*******************************    
 #TRANSACCION: SEG_USUARI_INS
 #DESCRIPCION:	Inserta usuarios
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
 ***************************************************************************
 HISTORIA DE MODIFICACIONES:
 #DESCRIPCION_MOD:	Aumenta campo de tipo de autentificacion
 #AUTOR_MOD: RAC	
 #FECHA_MOD: 01/03/2012		
***********************************/

     if(par_transaccion='SEG_USUARI_INS')then

        
          BEGIN
            
             INSERT  INTO segu.tusuario(
               				 id_clasificador,
                              cuenta,
                              contrasena,
                              fecha_caducidad,
                              estilo,
                              contrasena_anterior,
                              id_persona,
                              autentificacion)
                              
                       VALUES( 
                       
                        v_parametros.id_clasificador,
                        v_parametros.cuenta,
                        v_parametros.contrasena,
                        v_parametros.fecha_caducidad,
                        v_parametros.estilo,
                        NULL,
                        v_parametros.id_persona,
                        v_parametros.autentificacion)
                       RETURNING id_usuario into v_id_usuario;
            
           
             
             
             --insertamos los roles del usuario
             v_id_roles= string_to_array(v_parametros.id_roles,',');
             v_tamano = coalesce(array_length(v_id_roles, 1),0);
             

            
             FOR v_i IN 1..v_tamano LOOP
         
              --insertamos  registro si no esta presente como activo
                  insert into segu.tusuario_rol 
                     (id_usuario, 
                     id_rol, 
                     estado_reg) 
                  values(
                  v_id_usuario,
                  v_id_roles[v_i]::integer,
                  'activo'); 
             
             END LOOP;
                      
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario insertada con exito '||v_id_usuario); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);

                            

         END;
         
 /*******************************    
 #TRANSACCION:  SEG_USUARI_MOD
 #DESCRIPCION:	Modifica datos de  usuario
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
***********************************/

     elsif(par_transaccion='SEG_USUARI_MOD')then

          
          BEGIN
          
         -- raise exception '%',v_parametros.id_roles;
          
          IF v_parametros.contrasena_old != v_parametros.contrasena THEN
                         
             UPDATE segu.tusuario SET
                      id_clasificador=v_parametros.id_clasificador,
                      cuenta=v_parametros.cuenta,
                      contrasena=v_parametros.contrasena,
                      fecha_caducidad=v_parametros.fecha_caducidad,                      
                      estilo=v_parametros.estilo,
                      contrasena_anterior=v_parametros.contrasena_old,
                      id_persona=v_parametros.id_persona,
                      autentificacion=v_parametros.autentificacion
             WHERE id_usuario=v_parametros.id_usuario;
            
    
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje', pxp._t('success_change_user')||' id_usuario='||v_parametros.id_usuario); 
                  
          ELSE
               
               
               UPDATE segu.tusuario SET
                      id_clasificador=v_parametros.id_clasificador,
                      cuenta=v_parametros.cuenta,                     
                      fecha_caducidad=v_parametros.fecha_caducidad,                      
                      estilo=v_parametros.estilo,                   
                      id_persona=v_parametros.id_persona,
                      autentificacion=v_parametros.autentificacion
                     
               WHERE id_usuario=v_parametros.id_usuario;
               
            
                
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje', pxp._t('success_change_user')||' id_usuario= '||v_parametros.id_usuario); 
           
            END IF;

             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_parametros.id_usuario::varchar); 
             
             
             --modificamos lor roles relacionados al usuario
             --partimos los datos de id_roles en un vector
             
           
             v_id_roles= string_to_array(v_parametros.id_roles,',');
             v_tamano = coalesce(array_length(v_id_roles, 1),0);
             
             
             
             -- inactivamos todos los roles que no estan hay
             
             update segu.tusuario_rol 
             set estado_reg='inactivo'
             where 
             id_usuario = v_parametros.id_usuario
             and 
             (id_rol::varchar != ANY(v_id_roles) or v_tamano=0);
            --insertamos los que faltan
  
            
            FOR v_i IN 1..v_tamano LOOP
                         
              --preguntamos si el id_rol ya se encuentra asignado si no insertamos
            IF  (NOT EXISTS (select 1 from segu.tusuario_rol 
                        where id_usuario = v_parametros.id_usuario
                        and id_rol = v_id_roles[v_i]::integer 
                        and estado_reg='activo')) THEN
              --insertamos  registro si no esta presente como activo
                  insert into segu.tusuario_rol 
                     (id_usuario, 
                     id_rol, 
                     estado_reg) 
                  values(
                  v_parametros.id_usuario,
                  v_id_roles[v_i]::integer,
                  'activo'); 
              END IF;
            END LOOP;
             
          
          END;
          
/*******************************    
 #TRANSACCION: SEG_USUARI_ELI
 #DESCRIPCION:	Eliminar Usuarios
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
***********************************/
 elsif(par_transaccion='SEG_USUARI_ELI')THEN
    

         
          BEGIN
               update segu.tusuario set estado_reg='inactivo'
               where id_usuario=v_parametros.id_usuario;
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje', pxp._t('success_inactive_user')||' id_usuario '||v_parametros.id_usuario); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_parametros.id_usuario::varchar);
               
         END;
         
 /*******************************    
 #TRANSACCION: SEG_COPYROL_IME
 #DESCRIPCION:	Issue 97 Copiar usuarios y roles
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/12/2019
***********************************/
 elsif(par_transaccion='SEG_COPYROL_IME')THEN
    

         
          BEGIN
               
              --copiar roles
              v_count_rol = 0;
              v_count_ep = 0;
              IF v_parametros.copy_rol = 'si' THEN
              
                    FOR v_reg_roles in (SELECT ur.id_rol
                                        FROM segu.tusuario_rol ur
                                        WHERE ur.id_usuario = v_parametros.id_usuario_origen
                                        AND ur.estado_reg = 'activo') LOOP
                                        
                           --revisar si el usario destino no tiene el mismo rol asignado
                           IF( NOT EXISTS(SELECT 1 
                                          FROM segu.tusuario_rol ur
                                          WHERE    ur.id_usuario = v_parametros.id_usuario_destino
                                               AND ur.id_rol = v_reg_roles.id_rol
                                               AND ur.estado_reg = 'activo' )) THEN
                           
                                     INSERT INTO segu.tusuario_rol
                                                (
                                                  id_rol,
                                                  id_usuario,
                                                  fecha_reg,
                                                  estado_reg
                                                )
                                                VALUES (                                     
                                                  v_reg_roles.id_rol,
                                                  v_parametros.id_usuario_destino,
                                                  now(),
                                                  'activo'
                                               ); 
                                 v_count_rol = v_count_rol + 1; 
                            END IF;
                    END LOOP;
          
                
              
              END IF;
              
              
              --copiar eps
               IF v_parametros.copy_ep = 'si' THEN
                 
                 FOR v_reg_eps in ( SELECT ur.id_grupo
                                        FROM segu.tusuario_grupo_ep ur
                                        WHERE ur.id_usuario = v_parametros.id_usuario_origen
                                        AND ur.estado_reg = 'activo') LOOP
                                        
                           --revisar si el usario destino no tiene el mismo rol asignado
                           IF( NOT EXISTS(SELECT 1 
                                          FROM segu.tusuario_grupo_ep ur
                                          WHERE    ur.id_usuario = v_parametros.id_usuario_destino
                                               AND ur.id_grupo = v_reg_eps.id_grupo
                                               AND ur.estado_reg = 'activo' )) THEN
                                    
                                    INSERT INTO 
                                              segu.tusuario_grupo_ep
                                            (
                                              id_usuario_reg,                                             
                                              fecha_reg,
                                              estado_reg,
                                              id_usuario,
                                              id_grupo
                                            )
                                            VALUES (
                                              par_id_usuario,
                                              now(),
                                              'activo',
                                              v_parametros.id_usuario_destino,
                                              v_reg_eps.id_grupo
                                            );
                                            
                                    
                                 v_count_ep = v_count_ep + 1; 
                            END IF;
                    END LOOP;
              
              END IF;
              
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','roles copiados: '||v_count_rol||', eps copiadas: '|| v_count_ep); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_parametros.id_usuario_destino::varchar);
               
         END;  
         
     
     /*******************************    
     #TRANSACCION:  SEG_CRTUSR_TK
     #DESCRIPCION:	Crea usuario para logueo con facebook o google
     #AUTOR:		KPLIAN(rac)	
     #FECHA:		03/06/2020
    ***********************************/
     ELSEIF(par_transaccion='SEG_CRTUSR_TK')then

        BEGIN
        
              --------------------------
              -- recibimos nombre  
              --  (1) Nombre, (2) apellido, (3) Correo, (4) Url de la imagen de perfil Y el (5) token
              -------------------------
              
              --generamos un numero de indetificacion unico a partir de la fecha
              v_tmp_ci = RIGHT(  extract(epoch from now())::varchar, 20);
            
               --crear persona
              insert into segu.tpersona (
                               nombre,
                               apellido_paterno,                              
                               ci,
                               correo
                      )
               values(
                      upper(v_parametros.name),
                      upper(v_parametros.surname),                     
                      v_tmp_ci, 
                      v_parametros.email
                    )

              RETURNING id_persona INTO v_id_persona;
             
             --obtener el clasificador
             SELECT c.id_clasificador 
             INTO v_id_clasificador
             FROM segu.tclasificador c
             WHERE c.codigo = 'PUB';     
        
             --crear usuario
             
             INSERT  
             INTO segu.tusuario(
                  id_clasificador,
                  cuenta,
                  contrasena,
                  fecha_caducidad,
                  estilo,
                  contrasena_anterior,
                  id_persona,
                  autentificacion,
                  token,
                  url_foto,
                  alias)
                              
             VALUES(                        
                v_id_clasificador,
                v_parametros.email,
                v_tmp_ci,
                '3000-01-01'::Date,
                'xtheme-gray.css',
                NULL,
                v_id_persona,
                v_parametros.login_type, --tpo de autentificacion facebook , google,  local, ldap
                v_parametros.token,
                v_parametros.url_photo,
                v_parametros.email
             ) RETURNING id_usuario into v_id_usuario;
            
           
             
             -- buscamos el rol inicial para el usaurio
             v_rol_def = pxp.f_get_variable_global('segu_def_rol_google_face');
             
             SELECT r.id_rol 
             INTO v_id_rol
             FROM segu.trol r
             WHERE upper(r.descripcion) = upper(v_rol_def);
             
                        
             -- insertamos  registro si no esta presente como activo
              insert into segu.tusuario_rol 
                 (id_usuario, 
                  id_rol, 
                  estado_reg) 
              values(
              v_id_usuario,
              v_id_rol,
              'activo'); 
                      
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario Facebook/Google creado con exito '||v_id_usuario); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_id_usuario::varchar);

                            

         END;  
         

     else

         raise exception '%: %', pxp._t('no_existe_transaccion'), par_transaccion;
     end if;
     
   return v_resp;   

EXCEPTION

       WHEN OTHERS THEN

       	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;