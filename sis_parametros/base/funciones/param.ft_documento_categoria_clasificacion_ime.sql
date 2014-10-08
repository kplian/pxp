CREATE OR REPLACE FUNCTION "param"."ft_documento_categoria_clasificacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_documento_categoria_clasificacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdocumento_categoria_clasificacion'
 AUTOR: 		 (gsarmiento)
 FECHA:	        06-10-2014 16:00:33
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
	v_id_documento_categoria_clasificacion	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_documento_categoria_clasificacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DOCATCLA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 16:00:33
	***********************************/

	if(p_transaccion='PM_DOCATCLA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdocumento_categoria_clasificacion(
			id_categoria,
			id_clasificacion,
			estado_reg,
			documento,
			presentar_legal,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_categoria,
			v_parametros.id_clasificacion,
			'activo',
			v_parametros.documento,
			v_parametros.presentar_legal,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_documento_categoria_clasificacion into v_id_documento_categoria_clasificacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos almacenado(a) con exito (id_documento_categoria_clasificacion'||v_id_documento_categoria_clasificacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_categoria_clasificacion',v_id_documento_categoria_clasificacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DOCATCLA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 16:00:33
	***********************************/

	elsif(p_transaccion='PM_DOCATCLA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdocumento_categoria_clasificacion set
			id_categoria = v_parametros.id_categoria,
			id_clasificacion = v_parametros.id_clasificacion,
			documento = v_parametros.documento,
			presentar_legal = v_parametros.presentar_legal,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_documento_categoria_clasificacion=v_parametros.id_documento_categoria_clasificacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_categoria_clasificacion',v_parametros.id_documento_categoria_clasificacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DOCATCLA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 16:00:33
	***********************************/

	elsif(p_transaccion='PM_DOCATCLA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdocumento_categoria_clasificacion
            where id_documento_categoria_clasificacion=v_parametros.id_documento_categoria_clasificacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_categoria_clasificacion',v_parametros.id_documento_categoria_clasificacion::varchar);
              
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
ALTER FUNCTION "param"."ft_documento_categoria_clasificacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
