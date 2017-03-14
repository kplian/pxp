CREATE OR REPLACE FUNCTION param.ft_grupo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_grupo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tgrupo'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 14:20:57
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

	v_nombre_funcion = 'param.ft_grupo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_GRU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		22-04-2013 14:20:57
	***********************************/

	if(p_transaccion='PM_GRU_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gru.id_grupo,
						gru.estado_reg,
						gru.nombre,
						gru.obs,
						gru.fecha_reg,
						gru.id_usuario_reg,
						gru.fecha_mod,
						gru.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        pxp.text_concat(uep.id_usuario::text) as id_usuario
						from param.tgrupo gru
						inner join segu.tusuario usu1 on usu1.id_usuario = gru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gru.id_usuario_mod
                        left join segu.tusuario_grupo_ep uep on uep.id_grupo = gru.id_grupo
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' GROUP BY gru.id_grupo,
						gru.estado_reg,
						gru.nombre,
						gru.obs,
						gru.fecha_reg,
						gru.id_usuario_reg,
						gru.fecha_mod,
						gru.id_usuario_mod,
						usu1.cuenta,
						usu2.cuenta';
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_GRU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		22-04-2013 14:20:57
	***********************************/

	elsif(p_transaccion='PM_GRU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_grupo)
					    from param.tgrupo gru
					    inner join segu.tusuario usu1 on usu1.id_usuario = gru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = gru.id_usuario_mod
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