CREATE OR REPLACE FUNCTION "wf"."ft_tipo_proceso_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_proceso_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_proceso'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:52:52
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
	v_id_tipo_proceso	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_proceso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPPROC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:52:52
	***********************************/

	if(p_transaccion='WF_TIPPROC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_proceso(
			nombre,
			codigo,
			id_proceso_macro,
			tabla,
			columna_llave,
			estado_reg,
			id_tipo_estado,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			v_parametros.codigo,
			v_parametros.id_proceso_macro,
			v_parametros.tabla,
			v_parametros.columna_llave,
			'activo',
			v_parametros.id_tipo_estado,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_proceso into v_id_tipo_proceso;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso almacenado(a) con exito (id_tipo_proceso'||v_id_tipo_proceso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_id_tipo_proceso::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPPROC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:52:52
	***********************************/

	elsif(p_transaccion='WF_TIPPROC_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_proceso set
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			id_proceso_macro = v_parametros.id_proceso_macro,
			tabla = v_parametros.tabla,
			columna_llave = v_parametros.columna_llave,
			id_tipo_estado = v_parametros.id_tipo_estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_proceso=v_parametros.id_tipo_proceso;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_parametros.id_tipo_proceso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPPROC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:52:52
	***********************************/

	elsif(p_transaccion='WF_TIPPROC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_proceso
            where id_tipo_proceso=v_parametros.id_tipo_proceso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_parametros.id_tipo_proceso::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "wf"."ft_tipo_proceso_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
