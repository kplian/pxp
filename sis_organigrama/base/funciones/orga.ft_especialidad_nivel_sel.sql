CREATE OR REPLACE FUNCTION "orga"."ft_especialidad_nivel_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_especialidad_nivel_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tespecialidad_nivel'
 AUTOR: 		 (admin)
 FECHA:	        16-04-2016 07:45:20
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
 	#TRANSACCION:  'OR_esp_niv_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 07:45:20
	***********************************/

	if(p_transaccion='OR_esp_niv_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						esp_niv.id_especialidad_nivel,
						esp_niv.codigo,
						esp_niv.estado_reg,
						esp_niv.nombre,
						esp_niv.usuario_ai,
						esp_niv.fecha_reg,
						esp_niv.id_usuario_reg,
						esp_niv.id_usuario_ai,
						esp_niv.fecha_mod,
						esp_niv.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from orga.tespecialidad_nivel esp_niv
						inner join segu.tusuario usu1 on usu1.id_usuario = esp_niv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = esp_niv.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_esp_niv_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 07:45:20
	***********************************/

	elsif(p_transaccion='OR_esp_niv_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_especialidad_nivel)
					    from orga.tespecialidad_nivel esp_niv
					    inner join segu.tusuario usu1 on usu1.id_usuario = esp_niv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = esp_niv.id_usuario_mod
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
