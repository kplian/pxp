CREATE OR REPLACE FUNCTION "param"."ft_concepto_ingas_agrupador_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_concepto_ingas_agrupador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tconcepto_ingas_agrupador'
 AUTOR: 		 (egutierrez)
 FECHA:	        02-09-2019 21:07:26
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				02-09-2019 21:07:26								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tconcepto_ingas_agrupador'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_concepto_ingas_agrupador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_COINAGR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		egutierrez	
 	#FECHA:		02-09-2019 21:07:26
	***********************************/

	if(p_transaccion='PM_COINAGR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						coinagr.id_concepto_ingas_agrupador,
						coinagr.descripcion,
						coinagr.tipo_agrupador,
						coinagr.estado_reg,
						coinagr.nombre,
						coinagr.id_usuario_ai,
						coinagr.usuario_ai,
						coinagr.fecha_reg,
						coinagr.id_usuario_reg,
						coinagr.id_usuario_mod,
						coinagr.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tconcepto_ingas_agrupador coinagr
						inner join segu.tusuario usu1 on usu1.id_usuario = coinagr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = coinagr.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_COINAGR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		egutierrez	
 	#FECHA:		02-09-2019 21:07:26
	***********************************/

	elsif(p_transaccion='PM_COINAGR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_concepto_ingas_agrupador)
					    from param.tconcepto_ingas_agrupador coinagr
					    inner join segu.tusuario usu1 on usu1.id_usuario = coinagr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = coinagr.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_concepto_ingas_agrupador_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
