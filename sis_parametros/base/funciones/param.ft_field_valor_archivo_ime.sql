CREATE OR REPLACE FUNCTION "param"."ft_field_valor_archivo_ime" (
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_field_valor_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfield_valor_archivo'
 AUTOR: 		 (admin)
 FECHA:	        19-10-2017 15:00:59
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				19-10-2017 15:00:59								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfield_valor_archivo'
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_field_valor_archivo	integer;

	v_record		RECORD;

	v_nombre varchar;
	v_valor varchar;
	v_id_tipo_archivo INTEGER;

BEGIN

    v_nombre_funcion = 'param.ft_field_valor_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_FVALA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		19-10-2017 15:00:59
	***********************************/

	if(p_transaccion='PM_FVALA_INS')then

        begin
        	--Sentencia de la insercion
        	insert into param.tfield_valor_archivo(
			estado_reg,
			valor,
			id_archivo,
			id_field_tipo_archivo,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.valor,
			v_parametros.id_archivo,
			v_parametros.id_field_tipo_archivo,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			v_parametros._id_usuario_ai,
			null,
			null



			)RETURNING id_field_valor_archivo into v_id_field_valor_archivo;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Valor Archivo almacenado(a) con exito (id_field_valor_archivo'||v_id_field_valor_archivo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_valor_archivo',v_id_field_valor_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FVALA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin
 	#FECHA:		19-10-2017 15:00:59
	***********************************/

	elsif(p_transaccion='PM_FVALA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tfield_valor_archivo set
			valor = v_parametros.valor,
			id_archivo = v_parametros.id_archivo,
			id_field_tipo_archivo = v_parametros.id_field_tipo_archivo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_field_valor_archivo=v_parametros.id_field_valor_archivo;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Valor Archivo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_valor_archivo',v_parametros.id_field_valor_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FVALA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin
 	#FECHA:		19-10-2017 15:00:59
	***********************************/

	elsif(p_transaccion='PM_FVALA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tfield_valor_archivo
            where id_field_valor_archivo=v_parametros.id_field_valor_archivo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Valor Archivo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_valor_archivo',v_parametros.id_field_valor_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FVJSON_INS'
 	#DESCRIPCION:	registro de valores mediante un json
 	#AUTOR:		admin
 	#FECHA:		19-10-2017 15:00:59
	***********************************/

	elsif(p_transaccion='PM_FVJSON_INS')then

		begin
			--Sentencia de la eliminacion

			--validamos
			--RAISE EXCEPTION '%',v_parametros.id_archivo;

			select tipo.id_tipo_archivo INTO v_id_tipo_archivo from param.tarchivo ar
				INNER JOIN param.ttipo_archivo tipo on tipo.id_tipo_archivo = ar.id_tipo_archivo
				where ar.id_archivo = v_parametros.id_archivo;

			IF v_id_tipo_archivo is NULL THEN
				RAISE EXCEPTION '%','NO EXISTE EL ARCHIVO COMO TIPO DE ARCHIVO';
			END IF;

			FOR v_record IN (SELECT json_array_elements(v_parametros.json :: JSON)
			) LOOP

				--v_id_field_valor_archivo = v_record.json_array_elements::json->'id_field_valor_archivo';
				v_nombre = v_record.json_array_elements::json->>'nombre';
				v_valor = v_record.json_array_elements::json->>'valor';


				--RAISE EXCEPTION '%',v_record.json_array_elements::json->>'id_field_tipo_archivo';

				IF v_record.json_array_elements::json->>'id_field_valor_archivo' is NULL THEN


					insert into param.tfield_valor_archivo(
						estado_reg,
						valor,
						id_archivo,
						id_field_tipo_archivo,
						id_usuario_reg,
						fecha_reg,
						usuario_ai,
						id_usuario_ai,
						id_usuario_mod,
						fecha_mod
					) values(
						'activo',
						v_valor,
						v_parametros.id_archivo,
						(v_record.json_array_elements::json->>'id_field_tipo_archivo')::INTEGER ,
						p_id_usuario,
						now(),
						v_parametros._nombre_usuario_ai,
						v_parametros._id_usuario_ai,
						null,
						null
					);


					ELSE


						update param.tfield_valor_archivo set
							valor = v_valor,
							id_usuario_mod = p_id_usuario,
							fecha_mod = now(),
							id_usuario_ai = v_parametros._id_usuario_ai,
							usuario_ai = v_parametros._nombre_usuario_ai
						where id_field_valor_archivo= (v_record.json_array_elements::json->>'id_field_valor_archivo')::INTEGER;



				END IF;


			END LOOP;

				--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Valor Archivo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_valor_archivo',1::varchar);

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
ALTER FUNCTION "param"."ft_field_valor_archivo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
