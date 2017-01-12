--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_plantilla_archivo_excel_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_plantilla_archivo_excel_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tplantilla_archivo_excel'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'param.ft_plantilla_archivo_excel_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_ARXLS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:39
	***********************************/

	if(p_transaccion='PM_ARXLS_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						arxls.id_plantilla_archivo_excel,
						arxls.nombre,
						arxls.estado_reg,
						arxls.codigo,
                        arxls.hoja_excel,
                        arxls.fila_inicio,
                        arxls.fila_fin,
                        arxls.filas_excluidas,
                        arxls.tipo_archivo,
                        arxls.delimitador,
						arxls.id_usuario_reg,
						arxls.usuario_ai,
						arxls.fecha_reg,
						arxls.id_usuario_ai,
						arxls.fecha_mod,
						arxls.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from param.tplantilla_archivo_excel arxls
						inner join segu.tusuario usu1 on usu1.id_usuario = arxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arxls.id_usuario_mod
				        where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_ARXLS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gsarmiento
 	#FECHA:		15-12-2016 20:46:39
	***********************************/

	elsif(p_transaccion='PM_ARXLS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plantilla_archivo_excel)
					    from param.tplantilla_archivo_excel arxls
					    inner join segu.tusuario usu1 on usu1.id_usuario = arxls.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arxls.id_usuario_mod
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

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