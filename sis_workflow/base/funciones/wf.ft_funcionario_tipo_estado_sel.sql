CREATE OR REPLACE FUNCTION wf.ft_funcionario_tipo_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_funcionario_tipo_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tfuncionario_tipo_estado'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 16:19:04
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

	v_nombre_funcion = 'wf.ft_funcionario_tipo_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_FUNCTEST_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 16:19:04
	***********************************/

	if(p_transaccion='WF_FUNCTEST_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='
                    select
                        functest.id_funcionario_tipo_estado,
                        functest.id_labores_tipo_proceso,
                        functest.id_tipo_estado,
                        functest.id_funcionario,
                        functest.id_depto,
                        functest.estado_reg,
                        functest.fecha_reg,
                        functest.id_usuario_reg,
                        functest.id_usuario_mod,
                        functest.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        FUNCAR.desc_funcionario1::varchar AS desc_funcionario1,
                        depto.nombre AS desc_depto,
                        ltp.descripcion AS desc_labores	
                        from wf.tfuncionario_tipo_estado functest
                        inner join segu.tusuario usu1 on usu1.id_usuario = functest.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = functest.id_usuario_mod
                        LEFT JOIN orga.vfuncionario_cargo FUNCAR ON FUNCAR.id_funcionario = functest.id_funcionario
                        LEFT JOIN param.tdepto depto ON depto.id_depto = functest.id_depto
                        LEFT join WF.tlabores_tipo_proceso ltp on ltp.id_labores_tipo_proceso = functest.id_labores_tipo_proceso                            
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_FUNCTEST_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 16:19:04
	***********************************/

	elsif(p_transaccion='WF_FUNCTEST_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_funcionario_tipo_estado)
					    from wf.tfuncionario_tipo_estado functest
					    inner join segu.tusuario usu1 on usu1.id_usuario = functest.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = functest.id_usuario_mod
                        LEFT JOIN orga.vfuncionario_cargo FUNCAR ON FUNCAR.id_funcionario = functest.id_funcionario
                        LEFT JOIN param.tdepto depto ON depto.id_depto = functest.id_depto
                        LEFT join WF.tlabores_tipo_proceso ltp on ltp.id_labores_tipo_proceso = functest.id_labores_tipo_proceso
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