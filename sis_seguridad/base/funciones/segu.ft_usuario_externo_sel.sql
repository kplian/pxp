CREATE OR REPLACE FUNCTION segu.ft_usuario_externo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_usuario_externo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tusuario_externo'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        27-09-2017 13:33:32
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

	v_nombre_funcion = 'segu.ft_usuario_externo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_UEO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

	if(p_transaccion='SG_UEO_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ueo.id_usuario_externo,
						ueo.id_usuario,
						ueo.usuario_externo,
						ueo.estado_reg,
						ueo.sistema_externo,
						ueo.fecha_reg,
						ueo.usuario_ai,
						ueo.id_usuario_reg,
						ueo.id_usuario_ai,
						ueo.fecha_mod,
						ueo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from segu.tusuario_externo ueo
						inner join segu.tusuario usu1 on usu1.id_usuario = ueo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ueo.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'SG_UEO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

	elsif(p_transaccion='SG_UEO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_usuario_externo)
					    from segu.tusuario_externo ueo
					    inner join segu.tusuario usu1 on usu1.id_usuario = ueo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ueo.id_usuario_mod
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