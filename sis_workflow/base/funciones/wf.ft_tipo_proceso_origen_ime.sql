--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_proceso_origen_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_proceso_origen_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_proceso_origen'
 AUTOR: 		 (admin)
 FECHA:	        09-06-2014 17:03:47
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
	v_id_tipo_proceso_origin	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_proceso_origen_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TPO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	if(p_transaccion='WF_TPO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_proceso_origen(
			id_tipo_proceso,
			id_tipo_estado,
			id_proceso_macro,
			funcion_validacion_wf,
			tipo_disparo,
			estado_reg,
			id_usuario_reg,
			id_usuario_ai,
			usuario_ai,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_tipo_proceso,
			v_parametros.id_tipo_estado,
			v_parametros.id_proceso_macro,
			v_parametros.funcion_validacion_wf,
			v_parametros.tipo_disparo,
			'activo',
			p_id_usuario,
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			now(),
			null,
			null
							
			
			
			)RETURNING id_tipo_proceso_origin into v_id_tipo_proceso_origin;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Origenes almacenado(a) con exito (id_tipo_proceso_origin'||v_id_tipo_proceso_origin||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso_origin',v_id_tipo_proceso_origin::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TPO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	elsif(p_transaccion='WF_TPO_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_proceso_origen set
			id_tipo_proceso = v_parametros.id_tipo_proceso,
			id_tipo_estado = v_parametros.id_tipo_estado,
			id_proceso_macro = v_parametros.id_proceso_macro,
			funcion_validacion_wf = v_parametros.funcion_validacion_wf,
			tipo_disparo = v_parametros.tipo_disparo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_proceso_origin=v_parametros.id_tipo_proceso_origin;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Origenes modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso_origin',v_parametros.id_tipo_proceso_origin::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TPO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	elsif(p_transaccion='WF_TPO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_proceso_origen
            where id_tipo_proceso_origin=v_parametros.id_tipo_proceso_origin;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Origenes eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso_origin',v_parametros.id_tipo_proceso_origin::varchar);
              
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