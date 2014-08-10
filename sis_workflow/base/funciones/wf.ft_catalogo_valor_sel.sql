CREATE OR REPLACE FUNCTION "wf"."ft_catalogo_valor_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_catalogo_valor_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tcatalogo_valor'
 AUTOR: 		 (admin)
 FECHA:	        16-05-2014 22:55:18
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

	v_nombre_funcion = 'wf.ft_catalogo_valor_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_CATVAL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		16-05-2014 22:55:18
	***********************************/

	if(p_transaccion='WF_CATVAL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						catval.id_catalogo_valor,
						catval.estado_reg,
						catval.id_catalogo,
						catval.nombre,
						catval.codigo,
						catval.orden,
						catval.id_usuario_ai,
						catval.fk_id_catalogo_valor,
						catval.fecha_reg,
						catval.id_usuario_reg,
						catval.fecha_mod,
						catval.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from wf.tcatalogo_valor catval
						inner join segu.tusuario usu1 on usu1.id_usuario = catval.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = catval.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_CATVAL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		16-05-2014 22:55:18
	***********************************/

	elsif(p_transaccion='WF_CATVAL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_catalogo_valor)
					    from wf.tcatalogo_valor catval
					    inner join segu.tusuario usu1 on usu1.id_usuario = catval.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = catval.id_usuario_mod
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
ALTER FUNCTION "wf"."ft_catalogo_valor_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
