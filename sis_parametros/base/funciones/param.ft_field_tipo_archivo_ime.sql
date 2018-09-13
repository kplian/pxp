CREATE OR REPLACE FUNCTION "param"."ft_field_tipo_archivo_ime" (
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_field_tipo_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfield_tipo_archivo'
 AUTOR: 		 (FAVIO FIGUEROA)
 FECHA:	        18-10-2017 14:28:34
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR								DESCRIPCION
 #0					18-10-2017 		FAVIO.FIGUEROA			Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfield_tipo_archivo'
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_field_tipo_archivo	integer;

BEGIN

    v_nombre_funcion = 'param.ft_field_tipo_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_FITIAR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	if(p_transaccion='PM_FITIAR_INS')then

        begin
        	--Sentencia de la insercion
        	insert into param.tfield_tipo_archivo(
			id_tipo_archivo,
			estado_reg,
			nombre,
			descripcion,
			tipo,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_tipo_archivo,
			'activo',
			v_parametros.nombre,
			v_parametros.descripcion,
			v_parametros.tipo,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null



			)RETURNING id_field_tipo_archivo into v_id_field_tipo_archivo;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Tipo Archivo almacenado(a) con exito (id_field_tipo_archivo'||v_id_field_tipo_archivo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_tipo_archivo',v_id_field_tipo_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FITIAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	elsif(p_transaccion='PM_FITIAR_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tfield_tipo_archivo set
			id_tipo_archivo = v_parametros.id_tipo_archivo,
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			tipo = v_parametros.tipo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_field_tipo_archivo=v_parametros.id_field_tipo_archivo;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Tipo Archivo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_tipo_archivo',v_parametros.id_field_tipo_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FITIAR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	elsif(p_transaccion='PM_FITIAR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tfield_tipo_archivo
            where id_field_tipo_archivo=v_parametros.id_field_tipo_archivo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Field Tipo Archivo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_field_tipo_archivo',v_parametros.id_field_tipo_archivo::varchar);

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
ALTER FUNCTION "param"."ft_field_tipo_archivo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
