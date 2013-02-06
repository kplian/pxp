CREATE OR REPLACE FUNCTION "param"."f_ep_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tep'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 19:20:32
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

	v_nombre_funcion = 'param.f_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FRPP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 19:20:32
	***********************************/

	if(p_transaccion='PM_FRPP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						frpp.id_ep,
						frpp.estado_reg,
						frpp.id_financiador,
						frpp.id_prog_pory_acti,
						frpp.id_regional,
						frpp.sw_presto,
						frpp.fecha_reg,
						frpp.id_usuario_reg,
						frpp.fecha_mod,
						frpp.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tep frpp
						inner join segu.tusuario usu1 on usu1.id_usuario = frpp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = frpp.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FRPP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 19:20:32
	***********************************/

	elsif(p_transaccion='PM_FRPP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_ep)
					    from param.tep frpp
					    inner join segu.tusuario usu1 on usu1.id_usuario = frpp.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = frpp.id_usuario_mod
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
ALTER FUNCTION "param"."f_ep_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
