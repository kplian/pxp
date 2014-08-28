--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_funcionario_tipo_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Work Flow
 FUNCION:     wf.ft_funcionario_tipo_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tfuncionario_tipo_estado'
 AUTOR:      (admin)
 FECHA:         15-03-2013 16:19:04
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
          
BEGIN

  v_nombre_funcion = 'wf.ft_funcionario_tipo_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'WF_FUNCTEST_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   15-03-2013 16:19:04
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
                        FUN.desc_funcionario1::varchar AS desc_funcionario1,
                        depto.nombre AS desc_depto,
                        ltp.nombre AS desc_labores ,
                        functest.regla 
                        from wf.tfuncionario_tipo_estado functest
                        inner join segu.tusuario usu1 on usu1.id_usuario = functest.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = functest.id_usuario_mod
                        LEFT JOIN orga.vfuncionario FUN ON FUN.id_funcionario = functest.id_funcionario
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
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   15-03-2013 16:19:04
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
   
   /*********************************    
 	#TRANSACCION:  'WF_EXPFUNTES_SEL'
 	#DESCRIPCION:	Exportacion de funcionarios tipo estado
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	elsif(p_transaccion='WF_EXPFUNTES_SEL')then

		BEGIN

               v_consulta:='select  ''funcionario_tipo_estado''::varchar,tes.codigo as codigo_estado,tp.codigo as codigo_proceso,fun.ci,dep.codigo,
							funte.regla,funte.estado_reg

                            from wf.tfuncionario_tipo_estado funte
                            inner join wf.ttipo_estado tes
                            on tes.id_tipo_estado = funte.id_tipo_estado                            
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tes.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            left join orga.vfuncionario fun
                            on fun.id_funcionario = funte.id_funcionario
                            left join param.tdepto dep
                            on dep.id_depto = funte.id_depto
                            where pm.id_proceso_macro ='|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and tdoces.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by funte.id_funcionario_tipo_estado ASC';	
                                                                       
               return v_consulta;


         END;
          
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