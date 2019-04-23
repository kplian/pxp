CREATE OR REPLACE FUNCTION "param"."ft_field_tipo_archivo_sel"(
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_field_tipo_archivo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tfield_tipo_archivo'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2017 14:28:34
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				18-10-2017 14:28:34								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tfield_tipo_archivo'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'param.ft_field_tipo_archivo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_FITIAR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	if(p_transaccion='PM_FITIAR_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						fitiar.id_field_tipo_archivo,
						fitiar.id_tipo_archivo,
						fitiar.estado_reg,
						fitiar.nombre,
						fitiar.descripcion,
						fitiar.tipo,
						fitiar.usuario_ai,
						fitiar.fecha_reg,
						fitiar.id_usuario_reg,
						fitiar.id_usuario_ai,
						fitiar.fecha_mod,
						fitiar.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from param.tfield_tipo_archivo fitiar
						inner join segu.tusuario usu1 on usu1.id_usuario = fitiar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fitiar.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FITIAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	elsif(p_transaccion='PM_FITIAR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_field_tipo_archivo)
					    from param.tfield_tipo_archivo fitiar
					    inner join segu.tusuario usu1 on usu1.id_usuario = fitiar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fitiar.id_usuario_mod
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_FITIARVAL_SEL'
 	#DESCRIPCION:	field valor
 	#AUTOR:		FAVIO FIGUEROA
 	#FECHA:		18-10-2017 14:28:34
	***********************************/

	elsif(p_transaccion='PM_FITIARVAL_SEL')then

		begin
			--RAISE EXCEPTION '%',v_parametros.id_archivo;
			--RAISE EXCEPTION '%',v_parametros.id_tipo_archivo;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
									fta.id_field_tipo_archivo,
									fva.id_field_valor_archivo,
									fta.nombre,
									fta.tipo,
									fva.valor,
									fta.descripcion

									from param.tfield_tipo_archivo fta
								left join param.tfield_valor_archivo fva on fva.id_field_tipo_archivo = fta.id_field_tipo_archivo and fva.id_archivo = '||v_parametros.id_archivo||'
									left join param.tarchivo a on a.id_archivo = fva.id_archivo

								where fta.id_tipo_archivo = '||v_parametros.id_tipo_archivo||'
								and (a.estado_reg != ''inactivo'' or a.estado_reg is NULL ) ';

			--Definicion de la respuesta


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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_field_tipo_archivo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
