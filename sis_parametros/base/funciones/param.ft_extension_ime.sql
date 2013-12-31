CREATE OR REPLACE FUNCTION "param"."ft_extension_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_extension_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.textension'
 AUTOR: 		 (admin)
 FECHA:	        23-12-2013 20:12:46
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
	v_id_extension	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_extension_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_EXT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:12:46
	***********************************/

	if(p_transaccion='PM_EXT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.textension(
			estado_reg,
			peso_max_upload_mb,
			extension,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.peso_max_upload_mb,
			v_parametros.extension,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_extension into v_id_extension;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extension almacenado(a) con exito (id_extension'||v_id_extension||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension',v_id_extension::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_EXT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:12:46
	***********************************/

	elsif(p_transaccion='PM_EXT_MOD')then

		begin
			--Sentencia de la modificacion
			update param.textension set
			peso_max_upload_mb = v_parametros.peso_max_upload_mb,
			extension = v_parametros.extension,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_extension=v_parametros.id_extension;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extension modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension',v_parametros.id_extension::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_EXT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:12:46
	***********************************/

	elsif(p_transaccion='PM_EXT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.textension
            where id_extension=v_parametros.id_extension;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extension eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension',v_parametros.id_extension::varchar);
              
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
ALTER FUNCTION "param"."ft_extension_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
