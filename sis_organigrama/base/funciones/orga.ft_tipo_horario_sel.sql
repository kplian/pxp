-- Function: orga.f_tipo_horario_sel(integer, integer, character varying, character varying)

-- DROP FUNCTION orga.f_tipo_horario_sel(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION orga.f_tipo_horario_sel(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.f_tipo_horario_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.ttipo_horario'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 16:28:19
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

	v_nombre_funcion = 'orga.ft_tipo_horario_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHTIHO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 16:28:19
	***********************************/

	if(p_transaccion='RH_RHTIHO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						rhtiho.id_tipo_horario,
						rhtiho.estado_reg,
						rhtiho.nombre,
						rhtiho.codigo,
						rhtiho.fecha_reg,
						rhtiho.id_usuario_reg,
						rhtiho.fecha_mod,
						rhtiho.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from orga.ttipo_horario rhtiho
						inner join segu.tusuario usu1 on usu1.id_usuario = rhtiho.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhtiho.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHTIHO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 16:28:19
	***********************************/

	elsif(p_transaccion='RH_RHTIHO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_horario)
					    from orga.ttipo_horario rhtiho
					    inner join segu.tusuario usu1 on usu1.id_usuario = rhtiho.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhtiho.id_usuario_mod
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
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION orga.f_tipo_horario_sel(integer, integer, character varying, character varying) OWNER TO postgres;
