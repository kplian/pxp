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
            pedir_obs
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
        	v_parametros.pedir_obs
							
			)RETURNING id_tipo_estado into v_id_tipo_estado;
			
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
        	pedir_obs=v_parametros.pedir_obs
			where id_tipo_estado=v_parametros.id_tipo_estado;
            
            --Validacion de la no existencia de mas de un estado 'inicio' por tipo_proceso '
        	SELECT count(id_tipo_estado)
            INTO v_cont_estados_ini
            FROM wf.ttipo_estado te
            WHERE (te.inicio ilike 'si' and te.id_tipo_proceso = v_parametros.id_tipo_proceso and v_parametros.inicio ilike 'si') and estado_reg ilike 'activo';   
                             
            IF v_cont_estados_ini > 1 THEN
                RAISE EXCEPTION 'Ya esta resgistrado un Tipo Estado ''inicio''.Solo puede haber un estado (nodo) inicio.';
            END IF;
               
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
			--Sentencia de la eliminacion
			delete from wf.ttipo_estado
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