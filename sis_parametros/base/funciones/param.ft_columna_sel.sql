CREATE OR REPLACE FUNCTION "param"."ft_columna_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_columna_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcolumna'
 AUTOR: 		 (egutierrez)
 FECHA:	        07-08-2019 15:43:48
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				07-08-2019 15:43:48								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcolumna'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_columna_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_COL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		egutierrez	
 	#FECHA:		07-08-2019 15:43:48
	***********************************/

	if(p_transaccion='PM_COL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						col.id_columna,
						col.estado_reg,
						col.nombre_columna,
						col.tipo_dato,
						col.id_usuario_reg,
						col.fecha_reg,
						col.id_usuario_ai,
						col.usuario_ai,
						col.id_usuario_mod,
						col.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tcolumna col
						inner join segu.tusuario usu1 on usu1.id_usuario = col.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = col.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_COL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		egutierrez	
 	#FECHA:		07-08-2019 15:43:48
	***********************************/

	elsif(p_transaccion='PM_COL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_columna)
					    from param.tcolumna col
					    inner join segu.tusuario usu1 on usu1.id_usuario = col.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = col.id_usuario_mod
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
ALTER FUNCTION "param"."ft_columna_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
