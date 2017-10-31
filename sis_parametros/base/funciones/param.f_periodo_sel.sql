--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_periodo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_periodo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla ''param.tperiodo''
 AUTOR: 		 (admin)
 FECHA:	        20-02-2013 04:11:23
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

	v_nombre_funcion = 'param.f_periodo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_PER_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	if(p_transaccion='PM_PER_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						per.id_periodo,
						per.id_gestion,
						per.fecha_ini,
						per.periodo,
						per.estado_reg,
						per.fecha_fin,
						per.fecha_reg,
						per.id_usuario_reg,
						per.fecha_mod,
						per.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        param.f_literal_periodo(per.id_periodo) as literal,
                        per.codigo_siga
						from param.tperiodo per
						inner join segu.tusuario usu1 on usu1.id_usuario = per.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = per.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			raise notice 'filtro %', v_parametros.filtro;
            v_consulta:=v_consulta||v_parametros.filtro;
            raise notice 'consulta %', v_consulta;
            raise notice 'consulta % % % %', v_parametros.ordenacion, v_parametros.dir_ordenacion, v_parametros.cantidad, v_parametros.puntero;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice 'consulta final %', v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_PER_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	elsif(p_transaccion='PM_PER_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_periodo)
					    from param.tperiodo per
					    inner join segu.tusuario usu1 on usu1.id_usuario = per.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = per.id_usuario_mod
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