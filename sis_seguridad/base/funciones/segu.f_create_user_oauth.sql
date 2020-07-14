--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.f_create_user_oauth (
  p_administrador integer,
  p_id_usuario integer,
  v_parametros record
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION:       segu.f_create_user_oauth
 DESCRIPCION:   Recursi function to get menu options 
 AUTOR:         RAC - KPLIAN        
 FECHA:         10/04/2020
 COMENTARIOS:    
***************************************************************************

 ISSUE            FECHA:            AUTOR               DESCRIPCION  
 #128          10/07/2020           RAC            CREACION
***************************************************************************/
DECLARE
    v_registros         RECORD;
    v_resp_json         JSONB;
    v_resp				VARCHAR; 
    v_nombre_funcion    VARCHAR;   
    
    v_id_clasificador       integer; 
    v_id_persona            integer; 
    v_tmp_ci                varchar;
    v_rol_def               varchar; 
    v_id_rol                integer; 
    v_segu_extra_function   varchar; 
    v_extra                 boolean; 
    v_id_usuario            integer;

BEGIN
   
          v_nombre_funcion = 'f_create_user_oauth';
          
          --------------------------
            -- recibimos nombre  
            --  (1) Nombre, (2) apellido, (3) Correo, (4) Url de la imagen de perfil Y el (5) user_id
            -- name
            -- surname
            -- email
            -- login_type
            -- user_id  -> token
            -- url_photo
            -- device
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
            v_parametros.type, --tpo de autentificacion facebook , google,  local, ldap
            v_parametros.user_id,
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
              
        -- recuperar funcion para ejecutar funcionalidad extra
        v_segu_extra_function = pxp.f_get_variable_global('segu_extra_function');
            
        IF v_segu_extra_function != '' THEN
         EXECUTE 'SELECT '||v_segu_extra_function||'($1)' 
         INTO  v_extra
         USING v_id_usuario;


           IF not v_extra THEN
              raise exception 'error al procesar funcionalidad adicional';
           END IF;
        END IF;
                      
                   
 RETURN  v_id_usuario;
 
 EXCEPTION

  	 WHEN OTHERS THEN
    	v_resp := '';
		v_resp := pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp := pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp := pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;