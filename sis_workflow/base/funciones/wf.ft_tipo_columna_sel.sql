CREATE OR REPLACE FUNCTION "wf"."ft_tipo_columna_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_columna_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_columna'
 AUTOR: 		 (admin)
 FECHA:	        07-05-2014 21:41:15
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

	v_nombre_funcion = 'wf.ft_tipo_columna_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPCOL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:15
	***********************************/

	if(p_transaccion='WF_TIPCOL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipcol.id_tipo_columna,
						tipcol.id_tabla,
						tabla.id_tipo_proceso,
						tipcol.bd_campos_adicionales,
						tipcol.form_combo_rec,
						tipcol.bd_joins_adicionales,
						tipcol.bd_descripcion_columna,
						tipcol.bd_tamano_columna,
						tipcol.bd_formula_calculo,
						tipcol.form_sobreescribe_config,
						tipcol.form_tipo_columna,
						tipcol.grid_sobreescribe_filtro,
						tipcol.estado_reg,
						tipcol.bd_nombre_columna,
						tipcol.form_es_combo,
						tipcol.form_label,
						tipcol.grid_campos_adicionales,
						tipcol.bd_tipo_columna,
						tipcol.id_usuario_reg,
						tipcol.fecha_reg,
						tipcol.id_usuario_mod,
						tipcol.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from wf.ttipo_columna tipcol
						inner join segu.tusuario usu1 on usu1.id_usuario = tipcol.id_usuario_reg
						inner join wf.ttabla tabla on tabla.id_tabla = tipcol.id_tabla
						left join segu.tusuario usu2 on usu2.id_usuario = tipcol.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPCOL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:15
	***********************************/

	elsif(p_transaccion='WF_TIPCOL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_columna)
					    from wf.ttipo_columna tipcol
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipcol.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipcol.id_usuario_mod
						inner join wf.ttabla tabla on tabla.id_tabla = tipcol.id_tabla
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
ALTER FUNCTION "wf"."ft_tipo_columna_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
