CREATE OR REPLACE FUNCTION "param"."ft_archivo_historico_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_archivo_historico_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tarchivo_historico'
 AUTOR: 		 (admin)
 FECHA:	        07-12-2016 21:54:02
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
	v_id_archivo_historico	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_archivo_historico_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ARHIS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2016 21:54:02
	***********************************/

	if(p_transaccion='PM_ARHIS_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tarchivo_historico(
			estado_reg,
			version,
			id_archivo,
			id_tabla,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.version,
			v_parametros.id_archivo,
			v_parametros.id_tabla,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_archivo_historico into v_id_archivo_historico;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','archivo historico almacenado(a) con exito (id_archivo_historico'||v_id_archivo_historico||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_historico',v_id_archivo_historico::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ARHIS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2016 21:54:02
	***********************************/

	elsif(p_transaccion='PM_ARHIS_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tarchivo_historico set
			version = v_parametros.version,
			id_archivo = v_parametros.id_archivo,
			id_tabla = v_parametros.id_tabla,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_archivo_historico=v_parametros.id_archivo_historico;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','archivo historico modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_historico',v_parametros.id_archivo_historico::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ARHIS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-12-2016 21:54:02
	***********************************/

	elsif(p_transaccion='PM_ARHIS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tarchivo_historico
            where id_archivo_historico=v_parametros.id_archivo_historico;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','archivo historico eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_historico',v_parametros.id_archivo_historico::varchar);
              
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
ALTER FUNCTION "param"."ft_archivo_historico_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
