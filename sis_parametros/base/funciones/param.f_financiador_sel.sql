CREATE OR REPLACE FUNCTION "param"."f_financiador_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_financiador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tfinanciador'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        05-02-2013 22:30:22
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

	v_nombre_funcion = 'param.f_financiador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_fin_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		05-02-2013 22:30:22
	***********************************/

	if(p_transaccion='PM_fin_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						fin.id_financiador,
						fin.estado_reg,
						fin.nombre_financiador,
						fin.id_financiador_actif,
						fin.descripcion_financiador,
						fin.codigo_financiador,
						fin.fecha_reg,
						fin.id_usuario_reg,
						fin.fecha_mod,
						fin.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tfinanciador fin
						inner join segu.tusuario usu1 on usu1.id_usuario = fin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fin.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_fin_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		05-02-2013 22:30:22
	***********************************/

	elsif(p_transaccion='PM_fin_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_financiador)
					    from param.tfinanciador fin
					    inner join segu.tusuario usu1 on usu1.id_usuario = fin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = fin.id_usuario_mod
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
ALTER FUNCTION "param"."f_financiador_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
