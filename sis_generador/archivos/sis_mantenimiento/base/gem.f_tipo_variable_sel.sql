CREATE OR REPLACE FUNCTION "gem"."f_tipo_variable_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_tipo_variable_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.ttipo_variable'
 AUTOR: 		 (rac)
 FECHA:	        15-08-2012 15:28:09
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

	v_nombre_funcion = 'gem.f_tipo_variable_sel';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TVA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 15:28:09
	***********************************/

	if(p_transaccion='GEM_TVA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tva.id_tipo_variable,
						tva.estado_reg,
						tva.nombre,
						tva.id_tipo_equipo,
						tva.id_unidad_medida,
						tva.descripcion,
						tva.id_usuario_reg,
						tva.fecha_reg,
						tva.id_usuario_mod,
						tva.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.ttipo_variable tva
						inner join segu.tusuario usu1 on usu1.id_usuario = tva.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tva.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TVA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 15:28:09
	***********************************/

	elsif(p_transaccion='GEM_TVA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_variable)
					    from gem.ttipo_variable tva
					    inner join segu.tusuario usu1 on usu1.id_usuario = tva.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tva.id_usuario_mod
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
			v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "gem"."f_tipo_variable_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
