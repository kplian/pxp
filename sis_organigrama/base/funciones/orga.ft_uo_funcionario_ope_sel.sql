--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.ft_uo_funcionario_ope_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_uo_funcionario_ope_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tuo_funcionario_ope'
 AUTOR: 		 (admin)
 FECHA:	        19-05-2015 17:53:09
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

	v_nombre_funcion = 'orga.ft_uo_funcionario_ope_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_UOFO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-05-2015 17:53:09
	***********************************/

	if(p_transaccion='OR_UOFO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						uofo.id_uo_funcionario_ope,
						uofo.estado_reg,
						uofo.id_uo,
						uofo.id_funcionario,
						uofo.fecha_asignacion,
						uofo.fecha_finalizacion,
						uofo.id_usuario_reg,
						uofo.fecha_reg,
						uofo.id_usuario_ai,
						uofo.usuario_ai,
						uofo.id_usuario_mod,
						uofo.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        FUNCIO.ci,
                        FUNCIO.codigo,
                        FUNCIO.desc_funcionario1,
                        FUNCIO.desc_funcionario2,
                        FUNCIO.num_doc	
						from orga.tuo_funcionario_ope uofo
						inner join segu.tusuario usu1 on usu1.id_usuario = uofo.id_usuario_reg
                        INNER JOIN orga.vfuncionario FUNCIO ON FUNCIO.id_funcionario=uofo.id_funcionario
						left join segu.tusuario usu2 on usu2.id_usuario = uofo.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            --raise exception '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_UOFO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-05-2015 17:53:09
	***********************************/

	elsif(p_transaccion='OR_UOFO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uo_funcionario_ope)
					    from orga.tuo_funcionario_ope uofo
					    inner join segu.tusuario usu1 on usu1.id_usuario = uofo.id_usuario_reg
                        INNER JOIN orga.vfuncionario FUNCIO ON FUNCIO.id_funcionario=uofo.id_funcionario
						left join segu.tusuario usu2 on usu2.id_usuario = uofo.id_usuario_mod
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