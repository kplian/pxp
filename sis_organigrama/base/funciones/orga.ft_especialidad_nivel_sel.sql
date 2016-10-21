
CREATE OR REPLACE FUNCTION "orga"."ft_especialidad_nivel_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.ft_especialidad_nivel_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tespecialidad_nivel'
 AUTOR: 		 (admin)
 FECHA:	        26-08-2012 00:05:28
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

	v_nombre_funcion = 'orga.ft_especialidad_nivel_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHNIES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-08-2012 00:05:28
	***********************************/

	if(p_transaccion='RH_RHNIES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						rhnies.id_especialidad_nivel,
						rhnies.codigo,
						rhnies.nombre,
						rhnies.estado_reg,
						rhnies.id_usuario_reg,
						rhnies.fecha_reg,
						rhnies.id_usuario_mod,
						rhnies.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from orga.tespecialidad_nivel rhnies
						inner join segu.tusuario usu1 on usu1.id_usuario = rhnies.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhnies.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHNIES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-08-2012 00:05:28
	***********************************/

	elsif(p_transaccion='RH_RHNIES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_especialidad_nivel)
					    from orga.tespecialidad_nivel rhnies
					    inner join segu.tusuario usu1 on usu1.id_usuario = rhnies.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhnies.id_usuario_mod
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
ALTER FUNCTION "orga"."ft_especialidad_nivel_sel"(integer, integer, character varying, character varying) OWNER TO postgres;