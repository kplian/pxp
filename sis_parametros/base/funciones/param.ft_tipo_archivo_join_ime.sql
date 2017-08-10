CREATE OR REPLACE FUNCTION "param"."ft_tipo_archivo_join_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_archivo_join_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_archivo_join'
 AUTOR: 		 (favio.figueroa)
 FECHA:	        09-08-2017 20:03:38
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
	v_id_tipo_archivo_join	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_tipo_archivo_join_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TAJOIN_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 20:03:38
	***********************************/

	if(p_transaccion='PM_TAJOIN_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.ttipo_archivo_join(
			tipo,
			condicion,
			tabla,
			id_tipo_archivo,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod,
			alias
          	) values(
			v_parametros.tipo,
			v_parametros.condicion,
			v_parametros.tabla,
			v_parametros.id_tipo_archivo,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null,
						v_parametros.alias
							
			
			
			)RETURNING id_tipo_archivo_join into v_id_tipo_archivo_join;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Join almacenado(a) con exito (id_tipo_archivo_join'||v_id_tipo_archivo_join||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_join',v_id_tipo_archivo_join::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TAJOIN_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 20:03:38
	***********************************/

	elsif(p_transaccion='PM_TAJOIN_MOD')then

		begin
			--Sentencia de la modificacion
			update param.ttipo_archivo_join set
			tipo = v_parametros.tipo,
			condicion = v_parametros.condicion,
			tabla = v_parametros.tabla,
			id_tipo_archivo = v_parametros.id_tipo_archivo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
			alias = v_parametros.alias
			where id_tipo_archivo_join=v_parametros.id_tipo_archivo_join;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Join modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_join',v_parametros.id_tipo_archivo_join::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TAJOIN_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 20:03:38
	***********************************/

	elsif(p_transaccion='PM_TAJOIN_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.ttipo_archivo_join
            where id_tipo_archivo_join=v_parametros.id_tipo_archivo_join;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Join eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_join',v_parametros.id_tipo_archivo_join::varchar);
              
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
ALTER FUNCTION "param"."ft_tipo_archivo_join_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
