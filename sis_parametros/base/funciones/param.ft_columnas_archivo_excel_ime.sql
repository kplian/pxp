--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_columnas_archivo_excel_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_columnas_archivo_excel_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcolumnas_archivo_excel'
 AUTOR: 		 (gsarmiento)
 FECHA:	        15-12-2016 20:46:43
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
	v_id_columna_archivo_excel	integer;

BEGIN

    v_nombre_funcion = 'param.ft_columnas_archivo_excel_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_COLXLS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:43
	***********************************/

	if(p_transaccion='PM_COLXLS_INS')then

        begin

        	select id_columna_archivo_excel into v_id_columna_archivo_excel
            from param.tcolumnas_archivo_excel
            where id_plantilla_archivo_excel=v_parametros.id_plantilla_archivo_excel
            and numero_columna=v_parametros.numero_columna;

            IF v_id_columna_archivo_excel IS NOT NULL THEN
            	raise exception 'Ya existe una columna asignada con el numero %', v_parametros.numero_columna;
            END IF;

        	--Sentencia de la insercion
        	insert into param.tcolumnas_archivo_excel(
			id_plantilla_archivo_excel,
			sw_legible,
            formato_fecha,
            anio_fecha,
			numero_columna,
			nombre_columna,
            nombre_columna_tabla,
			tipo_valor,
            punto_decimal,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_plantilla_archivo_excel,
			v_parametros.sw_legible,
            v_parametros.formato_fecha,
            v_parametros.anio_fecha,
			v_parametros.numero_columna,
			v_parametros.nombre_columna,
            v_parametros.nombre_columna_tabla,
			v_parametros.tipo_valor,
            v_parametros.punto_decimal,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null



			)RETURNING id_columna_archivo_excel into v_id_columna_archivo_excel;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columnas Excel almacenado(a) con exito (id_columna_archivo_excel'||v_id_columna_archivo_excel||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_archivo_excel',v_id_columna_archivo_excel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_COLXLS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:43
	***********************************/

	elsif(p_transaccion='PM_COLXLS_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcolumnas_archivo_excel set
			id_plantilla_archivo_excel = v_parametros.id_plantilla_archivo_excel,
			sw_legible = v_parametros.sw_legible,
            formato_fecha = v_parametros.formato_fecha,
            anio_fecha = v_parametros.anio_fecha,
			numero_columna = v_parametros.numero_columna,
			nombre_columna = v_parametros.nombre_columna,
            nombre_columna_tabla = v_parametros.nombre_columna_tabla,
			tipo_valor = v_parametros.tipo_valor,
            punto_decimal = v_parametros.punto_decimal,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_columna_archivo_excel=v_parametros.id_columna_archivo_excel;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columnas Excel modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_archivo_excel',v_parametros.id_columna_archivo_excel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_COLXLS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:43
	***********************************/

	elsif(p_transaccion='PM_COLXLS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcolumnas_archivo_excel
            where id_columna_archivo_excel=v_parametros.id_columna_archivo_excel;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columnas Excel eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_archivo_excel',v_parametros.id_columna_archivo_excel::varchar);

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