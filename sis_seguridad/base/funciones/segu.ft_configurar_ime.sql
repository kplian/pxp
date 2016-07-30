--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_configurar_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Esquema de seguridad
 FUNCION: 		segu.ft_configurar_ime
 DESCRIPCION:   Funcion que modifica la configuración de la vista, la autentificación y las contraseñas
 AUTOR: 		 (jrivera)
 FECHA:	        01-12-2011 15:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    		integer;
	v_parametros           		record;
	v_id_requerimiento     		integer;
	v_resp		            	varchar;
	v_nombre_funcion       	 	text;
	v_mensaje_error         	text;
    v_clave_anterior			varchar;
    v_mod_exito 				varchar;
    v_clave_actual				varchar;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_configurar_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_CONF_MOD'
 	#DESCRIPCION:	Configuración de cuenta de usuario
 	#AUTOR:			mflores	
 	#FECHA:			01-12-2011
	***********************************/

	if(p_transaccion='SG_CONF_MOD')then				
        
	--1) IF Si la opcion es modifcar contraseña (mod_contraseña = SI) y autentificacion = local
    --1.1) IF verifico si la contraseña actual es valida
    --1.1.1) IF si la contraseña nueva es igual a la confirmacion
    --1.1.1.1) modifico contraseña
    --1.1.2) ELSE, mensaje de error las ontraseñas no son iguales
    --1.2) ELSE, mensaje de error la contraseñaa actual no es valida
    --2) ELSE, modifico estilo, filtro avanzado y autentificacion (LDAP)
    
		begin
        
                
        select contrasena
        into v_clave_anterior
        from segu.tusuario
        where id_usuario = p_id_usuario;
        
        /*v_parametros.clave_anterior = md5(v_parametros.clave_anterior);
        v_parametros.clave_nueva = md5(v_parametros.clave_nueva);
        v_parametros.clave_confirmacion = md5(v_parametros.clave_confirmacion);*/
        
        --1) IF Si la opcion es modifcar contraseña (mod_contraseña = SI) y autentificacion = local
         IF (v_parametros.modificar_clave = 'SI' AND v_parametros.autentificacion = 'local') THEN         	      	
            
            --1.1) IF verifico si la contraseña actual es valida         
			
          
            
            IF EXISTS(SELECT 1 FROM segu.tusuario usuari 
                      WHERE usuari.contrasena = v_parametros.clave_anterior
                           and usuari.id_usuario = p_id_usuario) THEN
                           
                          
			
               --  guarda nueva contraseña solo si coinciden la nueva y la confirmacion
				 
                --1.1.1) IF si la contraseña nueva es igual a la confirmacion
				IF (v_parametros.clave_nueva = v_parametros.clave_confirmacion) THEN
                
              
		        --1.1.1.1) modifico contraseña
	            -- se actualiza la clave  
                if (pxp.f_get_variable_global('sincronizar') = 'true') then
                	/*UPDATE segu.tusuario SET
                   		 estilo = v_parametros.estilo,                         
                         autentificacion = v_parametros.autentificacion                         
					WHERE segu.tusuario.id_usuario = p_id_usuario;*/
                    
                    select * FROM dblink(migra.f_obtener_cadena_conexion(), 
                        'SELECT * 
                        FROM sss.f_tsg_configurar_contrasena_pxp_iud(' || p_id_usuario || ',''' ||
                        		v_parametros.clave_nueva || ''')',TRUE)AS t1(resp varchar)
                                into v_resp;                  
                         
                         select * FROM dblink(migra.f_obtener_cadena_conexion(),
                         'SELECT * FROM migracion.f_sincronizacion()',FALSE)AS t1(resp varchar)
                         into v_resp;
                                   
                else
                
                 
                   
                    UPDATE segu.tusuario SET
                           contrasena_anterior = v_clave_anterior,
                           contrasena = v_parametros.clave_nueva,
                           estilo = v_parametros.estilo,
                           autentificacion = v_parametros.autentificacion
                           
                      WHERE segu.tusuario.id_usuario = p_id_usuario;
               
                end if;
                    
                    v_mod_exito = 1;
                    
                    select contrasena
                    into v_clave_actual
                    from segu.tusuario
                    where id_usuario = p_id_usuario;
    			
                --1.1.2) ELSE, mensaje de error las ontraseñas no son iguales
                ELSE
       	            raise exception 'LOS DATOS NUEVOS NO COINCIDEN';

                END IF;
			--1.2) ELSE, mensaje de error la contraseña actual no es valida
            ELSE
   	            raise exception 'LA CONTRASEÑA ANTIGUA NO ES CORRECTA';           
            
            END IF;
            
          --2) ELSE, modifico estilo y filtro avanzado
          ELSE  
          -- se actualiza el estilo y el filtro avanzado
                                        
               UPDATE segu.tusuario SET
                    estilo = v_parametros.estilo,
                    autentificacion = v_parametros.autentificacion
                         
                WHERE segu.tusuario.id_usuario = p_id_usuario;
                      
                v_mod_exito = 0;
                
                select contrasena
                into v_clave_actual
                from segu.tusuario
                where id_usuario = p_id_usuario;
                
          END IF;
                         
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preferencias de usuario modificadas)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario',p_id_usuario::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'mod_exito',v_mod_exito::varchar);  
            v_resp = pxp.f_agrega_clave(v_resp,'clave',v_clave_actual::varchar);      
			v_resp = pxp.f_agrega_clave(v_resp,'autentificacion',v_parametros.autentificacion::varchar);  
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
	         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

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
COST 100;