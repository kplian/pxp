--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_columna_concepto_ingas_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_columna_concepto_ingas_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcolumna_concepto_ingas_det'
 AUTOR: 		 (egutierrez)
 FECHA:	        06-09-2019 13:01:53
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				06-09-2019 13:01:53								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcolumna_concepto_ingas_det'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'param.ft_columna_concepto_ingas_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_COLCIGD_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		egutierrez
 	#FECHA:		06-09-2019 13:01:53
	***********************************/

	if(p_transaccion='PM_COLCIGD_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						colcigd.id_columna_concepto_ingas_det,
						colcigd.id_columna,
						colcigd.id_concepto_ingas_det,
						colcigd.valor,
						colcigd.estado_reg,
						colcigd.id_usuario_reg,
						colcigd.fecha_reg,
						colcigd.usuario_ai,
						colcigd.id_usuario_ai,
						colcigd.fecha_mod,
						colcigd.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from param.tcolumna_concepto_ingas_det colcigd
						inner join segu.tusuario usu1 on usu1.id_usuario = colcigd.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colcigd.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_COLCIGD_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		egutierrez
 	#FECHA:		06-09-2019 13:01:53
	***********************************/

	elsif(p_transaccion='PM_COLCIGD_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_columna_concepto_ingas_det)
					    from param.tcolumna_concepto_ingas_det colcigd
					    inner join segu.tusuario usu1 on usu1.id_usuario = colcigd.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = colcigd.id_usuario_mod
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
    	/*********************************
 	#TRANSACCION:  'PM_COLCIGDCB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		egutierrez
 	#FECHA:		06-09-2019 13:01:53
	***********************************/
    	elsif(p_transaccion='PM_COLCIGDCB_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='
                       WITH valor (valor)as(
                              select DISTINCT colcigd.valor
                              from param.tcolumna_concepto_ingas_det colcigd
                              WHERE '||v_parametros.filtro||'
                          )
                      select
                      ROW_NUMBER () OVER (ORDER BY  v.valor )::integer as id,
                      v.valor
                      from valor v	';

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_COLCIGDCB_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		egutierrez
 	#FECHA:		06-09-2019 13:01:53
	***********************************/

	elsif(p_transaccion='PM_COLCIGDCB_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='
                       WITH valor (valor)as(
                              select DISTINCT colcigd.valor
                              from param.tcolumna_concepto_ingas_det colcigd
                              WHERE '||v_parametros.filtro||'
                          )
                      select
                      count(v.valor)
                      from valor v	';


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