--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_estado_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_estado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_estado'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:36:11
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_estado	integer;
    v_cont_estados_ini integer;
    v_id_roles			varchar[];
    v_tamano			integer;
    v_i					integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_estado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	if(p_transaccion='WF_TIPES_INS')then
					
        begin
        	--Validacion de la no existencia de mas de un estado 'inicio' por tipo_proceso '
        	SELECT count(id_tipo_estado)
            INTO v_cont_estados_ini
            FROM wf.ttipo_estado te
            WHERE (te.inicio ilike 'si' and te.id_tipo_proceso = v_parametros.id_tipo_proceso and v_parametros.inicio ilike 'si') and estado_reg ilike 'activo';   
                             
            IF v_cont_estados_ini >= 1 THEN
                RAISE EXCEPTION 'Ya esta resgistrado un Tipo Estado ''inicio''.Solo puede haber un estado (nodo) inicio.';
            END IF;
            
        	--Sentencia de la insercion
        	insert into wf.ttipo_estado(
			nombre_estado,
			id_tipo_proceso,
			inicio,
			disparador,
			tipo_asignacion,
			nombre_func_list,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            codigo,
            obs,
            depto_asignacion,
            nombre_depto_func_list,
            fin,
            alerta,
            pedir_obs,
            cargo_depto,
            funcion_inicial,
            funcion_regreso,
            mobile,
            acceso_directo_alerta, 
            nombre_clase_alerta, 
            tipo_noti, 
            titulo_alerta, 
            parametros_ad,
            admite_obs,
            etapa,
            grupo_doc,
            id_tipo_estado_anterior,
            icono
            
          	) values(
			v_parametros.nombre_estado,
			v_parametros.id_tipo_proceso,
			v_parametros.inicio,
			v_parametros.disparador,
			v_parametros.tipo_asignacion,
			v_parametros.nombre_func_list,
			'activo',
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.codigo_estado,
            v_parametros.obs,
            v_parametros.depto_asignacion,
            v_parametros.nombre_depto_func_list,
            v_parametros.fin,
            v_parametros.alerta,
        	v_parametros.pedir_obs,
            string_to_array(v_parametros.cargo_depto,','),
            v_parametros.funcion_inicial,
            v_parametros.funcion_regreso,
            v_parametros.mobile,
            v_parametros.acceso_directo_alerta, 
            v_parametros.nombre_clase_alerta, 
            v_parametros.tipo_noti, 
            v_parametros.titulo_alerta, 
            v_parametros.parametros_ad,
            v_parametros.admite_obs,
            v_parametros.etapa,
            v_parametros.grupo_doc,
            v_parametros.id_tipo_estado_anterior,
			v_parametros.icono
			)RETURNING id_tipo_estado into v_id_tipo_estado;
			
            v_id_roles= string_to_array(v_parametros.id_roles,',');
             v_tamano = coalesce(array_length(v_id_roles, 1),0);
             

            
             FOR v_i IN 1..v_tamano LOOP
         
              --insertamos  registro si no esta presente como activo
                  insert into wf.ttipo_estado_rol 
                     (id_tipo_estado, 
                     id_rol, 
                     estado_reg) 
                  values(
                  v_id_tipo_estado,
                  v_id_roles[v_i]::integer,
                  'activo'); 
             
             END LOOP;
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Estado almacenado(a) con exito (id_tipo_estado'||v_id_tipo_estado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_estado',v_id_tipo_estado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_TIPES_MOD')then

		begin
        	            
			--Sentencia de la modificacion
			update wf.ttipo_estado set
			nombre_estado = v_parametros.nombre_estado,
			id_tipo_proceso = v_parametros.id_tipo_proceso,
			inicio = v_parametros.inicio,
			disparador = v_parametros.disparador,
			tipo_asignacion = v_parametros.tipo_asignacion,
			nombre_func_list = v_parametros.nombre_func_list,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            codigo=v_parametros.codigo_estado,
            obs=v_parametros.obs,
            depto_asignacion=v_parametros.depto_asignacion,
            nombre_depto_func_list=v_parametros.nombre_depto_func_list,
            fin=v_parametros.fin,
            alerta=v_parametros.alerta,
        	pedir_obs=v_parametros.pedir_obs,
            cargo_depto=string_to_array(v_parametros.cargo_depto,','),
			funcion_inicial = v_parametros.funcion_inicial,
            funcion_regreso = v_parametros.funcion_regreso,
            mobile = v_parametros.mobile,
            acceso_directo_alerta=v_parametros.acceso_directo_alerta, 
            nombre_clase_alerta=v_parametros.nombre_clase_alerta, 
            tipo_noti=v_parametros.tipo_noti, 
            titulo_alerta=v_parametros.titulo_alerta, 
            parametros_ad=v_parametros.parametros_ad,
            admite_obs = v_parametros.admite_obs,
            etapa = v_parametros.etapa,
            grupo_doc = v_parametros.grupo_doc,
            id_tipo_estado_anterior = v_parametros.id_tipo_estado_anterior,
			icono = v_parametros.icono
            where id_tipo_estado=v_parametros.id_tipo_estado;
            
            --Validacion de la no existencia de mas de un estado 'inicio' por tipo_proceso '
        	SELECT count(id_tipo_estado)
            INTO v_cont_estados_ini
            FROM wf.ttipo_estado te
            WHERE (te.inicio ilike 'si' and te.id_tipo_proceso = v_parametros.id_tipo_proceso and v_parametros.inicio ilike 'si') and estado_reg ilike 'activo';   
                             
            IF v_cont_estados_ini > 1 THEN
                RAISE EXCEPTION 'Ya esta resgistrado un Tipo Estado ''inicio''.Solo puede haber un estado (nodo) inicio.';
            END IF;
            
            v_id_roles= string_to_array(v_parametros.id_roles,',');
             v_tamano = coalesce(array_length(v_id_roles, 1),0);
             
             
             
             -- inactivamos todos los roles que no estan hay
             
             update wf.ttipo_estado_rol 
             set estado_reg='inactivo'
             where 
             id_tipo_estado = v_parametros.id_tipo_estado
             and 
             (id_rol::varchar != ANY(v_id_roles) or v_tamano=0);
            --insertamos los que faltan
  
            
            FOR v_i IN 1..v_tamano LOOP
                         
              --preguntamos si el id_rol ya se encuentra asignado si no insertamos
            IF  (NOT EXISTS (select 1 from wf.ttipo_estado_rol 
                        where id_tipo_estado = v_parametros.id_tipo_estado
                        and id_rol = v_id_roles[v_i]::integer 
                        and estado_reg='activo')) THEN
              --insertamos  registro si no esta presente como activo
                  insert into wf.ttipo_estado_rol 
                     (id_tipo_estado, 
                     id_rol, 
                     estado_reg) 
                  values(
                  v_parametros.id_tipo_estado,
                  v_id_roles[v_i]::integer,
                  'activo'); 
              END IF;
            END LOOP;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Estado modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_estado',v_parametros.id_tipo_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

   /*********************************    
 	#TRANSACCION:  'WF_UPDPLAMEN_MOD'
 	#DESCRIPCION:	Actualizar la plantilla de mensajes de correo
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_UPDPLAMEN_MOD')then

		begin
        	            
			--Sentencia de la modificacion
			update wf.ttipo_estado set
            plantilla_mensaje_asunto = v_parametros.plantilla_mensaje_asunto,
            plantilla_mensaje = v_parametros.plantilla_mensaje,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now()
			
			where id_tipo_estado=v_parametros.id_tipo_estado;
            
            
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se modifico la plantilla de correodel tipo estado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_estado',v_parametros.id_tipo_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;


	/*********************************    
 	#TRANSACCION:  'WF_TIPES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_TIPES_ELI')then

		begin
        
        	if (exists (select 1 
            			from wf.testructura_estado t
                        where (t.id_tipo_estado_hijo = v_parametros.id_tipo_estado or 
                        		t.id_tipo_estado_padre = v_parametros.id_tipo_estado) and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Otros Estados que depende(n) de este tipo estado';
            end if;
            
            if (exists (select 1 
            			from wf.tfuncionario_tipo_estado t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Asignacion a funcionarios que depende(n) de este tipo estado';
            end if;
            
            if (exists (select 1 
            			from wf.ttipo_documento_estado t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Momentos de Documentos que depende(n) de este tipo estado';
            end if;
            
            if (exists (select 1 
            			from wf.tcolumna_estado t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Estados de Columnas que depende(n) de este tipo estado';
            end if;
            
            if (exists (select 1 
            			from wf.ttipo_proceso_origen t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Procesos Origen que depende(n) de este tipo estado';
            end if;   
            
            if (exists (select 1 
            			from wf.tplantilla_correo t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Plantillas de Correo que depende(n) de este tipo estado';
            end if;   
            
            if (exists (select 1 
            			from wf.ttipo_estado_rol t
                        where t.id_tipo_estado = v_parametros.id_tipo_estado and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Roles asociados a este tipo estado';
            end if;           
            
            
			--Sentencia de la eliminacion
			update wf.ttipo_estado
            set estado_reg ='inactivo'
            where id_tipo_estado=v_parametros.id_tipo_estado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Estado eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_estado',v_parametros.id_tipo_estado::varchar);
              
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