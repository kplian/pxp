--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_plantilla_archivo_excel_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_plantilla_archivo_excel_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tplantilla_archivo_excel'
 AUTOR: 		 (gsarmiento)
 FECHA:	        15-12-2016 20:46:39
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
	v_id_plantilla_archivo_excel	integer;

BEGIN

    v_nombre_funcion = 'param.ft_plantilla_archivo_excel_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_ARXLS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:39
	***********************************/

	if(p_transaccion='PM_ARXLS_INS')then

        begin
        	--Sentencia de la insercion
        	insert into param.tplantilla_archivo_excel(
			nombre,
			estado_reg,
			codigo,
            hoja_excel,
            fila_inicio,
            fila_fin,
            filas_excluidas,
            tipo_archivo,
            delimitador,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			'activo',
			v_parametros.codigo,
            v_parametros.hoja_excel,
            v_parametros.fila_inicio,
            v_parametros.fila_fin,
            v_parametros.filas_excluidas,
            v_parametros.tipo_archivo,
            v_parametros.delimitador,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			v_parametros._id_usuario_ai,
			null,
			null



			)RETURNING id_plantilla_archivo_excel into v_id_plantilla_archivo_excel;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Excel almacenado(a) con exito (id_plantilla_archivo_excel'||v_id_plantilla_archivo_excel||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_archivo_excel',v_id_plantilla_archivo_excel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_ARXLS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:39
	***********************************/

	elsif(p_transaccion='PM_ARXLS_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tplantilla_archivo_excel set
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
            hoja_excel = v_parametros.hoja_excel,
            fila_inicio = v_parametros.fila_inicio,
            fila_fin = v_parametros.fila_fin,
            filas_excluidas = v_parametros.filas_excluidas,
            tipo_archivo = v_parametros.tipo_archivo,
            delimitador = v_parametros.delimitador,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_plantilla_archivo_excel=v_parametros.id_plantilla_archivo_excel;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Excel modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_archivo_excel',v_parametros.id_plantilla_archivo_excel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_ARXLS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:39
	***********************************/

	elsif(p_transaccion='PM_ARXLS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tplantilla_archivo_excel
            where id_plantilla_archivo_excel=v_parametros.id_plantilla_archivo_excel;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo Excel eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_archivo_excel',v_parametros.id_plantilla_archivo_excel::varchar);

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