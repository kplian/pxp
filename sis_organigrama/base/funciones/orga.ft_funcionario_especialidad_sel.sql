CREATE OR REPLACE FUNCTION orga.ft_funcionario_especialidad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.f_funcionario_especialidad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tfuncionario_especialidad'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 17:48:38
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

	v_nombre_funcion = 'orga.f_funcionario_especialidad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:38
	***********************************/

	if(p_transaccion='RH_RHESFU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						rhesfu.id_funcionario_especialidad,
						rhesfu.id_funcionario,
						rhesfu.estado_reg,
						rhesfu.id_especialidad,
						rhesfu.id_usuario_reg,
						rhesfu.fecha_reg,
						rhesfu.id_usuario_mod,
						rhesfu.fecha_mod,
                        rhesfu.fecha,
                        rhesfu.numero_especialidad,
                        rhesfu.descripcion,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						especi.nombre as desc_especialidad
                        from orga.tfuncionario_especialidad rhesfu
						inner join segu.tusuario usu1 on usu1.id_usuario = rhesfu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = rhesfu.id_usuario_mod
						inner join orga.tespecialidad especi on especi.id_especialidad = rhesfu.id_especialidad
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:38
	***********************************/

	elsif(p_transaccion='RH_RHESFU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_funcionario_especialidad)
					    from orga.tfuncionario_especialidad rhesfu
					    inner join segu.tusuario usu1 on usu1.id_usuario = rhesfu.id_usuario_reg
					    left join segu.tusuario usu2 on usu2.id_usuario = rhesfu.id_usuario_mod
					    inner join orga.tespecialidad especi on especi.id_especialidad = rhesfu.id_especialidad
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
ALTER FUNCTION "orga"."ft_funcionario_especialidad_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
