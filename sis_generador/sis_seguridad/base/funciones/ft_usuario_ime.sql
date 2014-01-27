CREATE OR REPLACE FUNCTION segu.ft_usuario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
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
            
             --05-04-2012:
             IF  v_sincronizar='true' THEN
                 v_respuesta_sinc:= segu.f_sincroniza_usuario_entre_bd(v_id_usuario,v_sincronizar_ip,v_sincronizar_puerto,v_sincronizar_user,v_sincronizar_password,v_sincronizar_base,'INSERT');
    	         if(v_respuesta_sinc!='si') then   
                     raise exception 'Sincronizacion de usuario en BD externa no realizada';
                 end if;  
             
             END IF;
             --fin 05-04-2012
             
             
             
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
            
              --05-04-2012:
                IF  v_sincronizar= 'true' THEN
                
                
                 v_respuesta_sinc:= segu.f_sincroniza_usuario_entre_bd(v_id_usuario,v_sincronizar_ip,v_sincronizar_puerto,v_sincronizar_user,v_sincronizar_password,v_sincronizar_base,'UPDATE');
    	         if(v_respuesta_sinc!='si') then   
                      raise exception 'Sincronizacion de actualizacion de usuario en BD externa no realizada';
                 end if;  
             
                END IF;
             
             --fin 05-04-2012
             
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Contraseña de usuario modificada con exito id_usuario='||v_parametros.id_usuario); 
                  
          ELSE
               
               
               UPDATE segu.tusuario SET
                      id_clasificador=v_parametros.id_clasificador,
                      cuenta=v_parametros.cuenta,                     
                      fecha_caducidad=v_parametros.fecha_caducidad,                      
                      estilo=v_parametros.estilo,                   
                      id_persona=v_parametros.id_persona,
                      autentificacion=v_parametros.autentificacion
                     
               WHERE id_usuario=v_parametros.id_usuario;
               
               --05-04-2012:
               
               
               IF  v_sincronizar= 'true' THEN
                
                 v_respuesta_sinc:= segu.f_sincroniza_usuario_entre_bd(v_id_usuario,v_sincronizar_ip,v_sincronizar_puerto,v_sincronizar_user,v_sincronizar_password,v_sincronizar_base,'UPDATE');
    	         if(v_respuesta_sinc!='si') then   
                      raise exception 'Sincronizacion de actualizacion de usuario en BD externa no realizada';
                 end if;  
             
                END IF;
               
                
               --fin 05-04-2012
                
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta de usuario modificada con exito id_usuario= '||v_parametros.id_usuario); 
           
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
               
               --05-04-2012:
             
               
                IF  v_sincronizar= 'true' THEN
                 v_respuesta_sinc:= segu.f_sincroniza_usuario_entre_bd(v_id_usuario,v_sincronizar_ip,v_sincronizar_puerto,v_sincronizar_user,v_sincronizar_password,v_sincronizar_base,'DELETE');
    	         if(v_respuesta_sinc!='si') then   
                      raise exception 'Sincronizacion de actualizacion de usuario en BD externa no realizada';
                 end if;  
             
                END IF;
               
                
               --fin 05-04-2012
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario inactivado con exito '||v_parametros.id_usuario); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',v_parametros.id_usuario::varchar);
               
         END;

     else

         raise exception 'No existe la transaccion: %',par_transaccion;
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_usuario_proyecto_ime (OID = 305102) : 
--
