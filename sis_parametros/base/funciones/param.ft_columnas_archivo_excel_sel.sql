--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_columnas_archivo_excel_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_columnas_archivo_excel_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcolumnas_archivo_excel'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'param.ft_columnas_archivo_excel_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_COLXLS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:43
	***********************************/

	if(p_transaccion='PM_COLXLS_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						colxls.id_columna_archivo_excel,
						colxls.id_plantilla_archivo_excel,
						colxls.sw_legible,
                        colxls.formato_fecha,
                        colxls.anio_fecha,
						colxls.numero_columna,
						colxls.nombre_columna,
                        colxls.nombre_columna_tabla,
						colxls.tipo_valor,
                        colxls.punto_decimal,
						colxls.estado_reg,
						colxls.id_usuario_ai,
						colxls.id_usuario_reg,
						colxls.fecha_reg,
						colxls.usuario_ai,
						colxls.fecha_mod,
						colxls.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from param.tcolumnas_archivo_excel colxls
						inner join segu.tusuario usu1 on usu1.id_usuario = colxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colxls.id_usuario_mod
				        where  colxls.id_plantilla_archivo_excel='||v_parametros.id_plantilla_archivo_excel||' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_COLXLS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:43
	***********************************/

	elsif(p_transaccion='PM_COLXLS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_columna_archivo_excel)
					    from param.tcolumnas_archivo_excel colxls
					    inner join segu.tusuario usu1 on usu1.id_usuario = colxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colxls.id_usuario_mod
					    where colxls.id_plantilla_archivo_excel='||v_parametros.id_plantilla_archivo_excel||' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'PM_COLXLSCOD_SEL'
 	#DESCRIPCION:	Consulta de datos por codigo de archivo
 	#AUTOR:		gsarmiento
 	#FECHA:		19-12-2016
	***********************************/
    elsif(p_transaccion='PM_COLXLSCOD_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						colxls.id_columna_archivo_excel,
						colxls.id_plantilla_archivo_excel,
						colxls.sw_legible,
                        colxls.formato_fecha,
                        colxls.anio_fecha,
						colxls.numero_columna,
						colxls.nombre_columna,
                        colxls.nombre_columna_tabla,
						colxls.tipo_valor,
                        colxls.punto_decimal
						from param.tcolumnas_archivo_excel colxls
                        inner join param.tplantilla_archivo_excel plaxls on plaxls.id_plantilla_archivo_excel=colxls.id_plantilla_archivo_excel
						inner join segu.tusuario usu1 on usu1.id_usuario = colxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colxls.id_usuario_mod
				        where  plaxls.codigo='''||v_parametros.codigo||'''
                        order by colxls.numero_columna';

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'PM_COLXLSCOD_CONT'
 	#DESCRIPCION:	Conteo de registros por codigo de archivo
 	#AUTOR:		gsarmiento
 	#FECHA:		19-12-2016
	***********************************/
    elsif(p_transaccion='PM_COLXLSCOD_CONT')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						count(colxls.id_columna_archivo_excel)
						from param.tcolumnas_archivo_excel colxls
                        inner join param.tplantilla_archivo_excel plaxls on plaxls.id_plantilla_archivo_excel=colxls.id_plantilla_archivo_excel
						inner join segu.tusuario usu1 on usu1.id_usuario = colxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colxls.id_usuario_mod
				        where  plaxls.codigo='''||v_parametros.codigo||'''';

			--Devuelve la respuesta
			return v_consulta;

		end;

	else

		raise exception 'Transaccion inexistente';

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