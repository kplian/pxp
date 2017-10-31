CREATE OR REPLACE FUNCTION "param"."ft_feriado_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_feriado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tferiado'
 AUTOR: 		 (admin)
 FECHA:	        27-10-2017 13:52:45
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

	v_nombre_funcion = 'param.ft_feriado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FERIA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-10-2017 13:52:45
	***********************************/

	if(p_transaccion='PM_FERIA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						feria.id_feriado,
						feria.estado_reg,
						feria.descripcion,
						feria.tipo,
						feria.fecha,
						feria.id_lugar,
						feria.usuario_ai,
						feria.fecha_reg,
						feria.id_usuario_reg,
						feria.id_usuario_ai,
						feria.id_usuario_mod,
						feria.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						lug.nombre as desc_lugar
						from param.tferiado feria
						inner join segu.tusuario usu1 on usu1.id_usuario = feria.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = feria.id_usuario_mod
						left join param.tlugar lug on lug.id_lugar = feria.id_lugar
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FERIA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2017 13:52:45
	***********************************/

	elsif(p_transaccion='PM_FERIA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_feriado)
					    from param.tferiado feria
					    inner join segu.tusuario usu1 on usu1.id_usuario = feria.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = feria.id_usuario_mod
						left join param.tlugar lug on lug.id_lugar = feria.id_lugar
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
ALTER FUNCTION "param"."ft_feriado_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
