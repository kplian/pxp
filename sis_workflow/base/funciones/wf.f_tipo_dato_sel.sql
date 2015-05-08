CREATE OR REPLACE FUNCTION "wf"."f_tipo_dato_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_tipo_dato_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_dato'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 23:08:25
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

	v_nombre_funcion = 'wf.f_tipo_dato_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TDT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 23:08:25
	***********************************/

	if(p_transaccion='WF_TDT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tdt.id_tipo_dato,
						tdt.estado_reg,
						tdt.presicion,
						tdt.descripcion,
						tdt.tipo,
						tdt.tamano,
						tdt.fecha_reg,
						tdt.id_usuario_reg,
						tdt.fecha_mod,
						tdt.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from wf.ttipo_dato tdt
						inner join segu.tusuario usu1 on usu1.id_usuario = tdt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tdt.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TDT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 23:08:25
	***********************************/

	elsif(p_transaccion='WF_TDT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_dato)
					    from wf.ttipo_dato tdt
					    inner join segu.tusuario usu1 on usu1.id_usuario = tdt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tdt.id_usuario_mod
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
ALTER FUNCTION "wf"."f_tipo_dato_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
