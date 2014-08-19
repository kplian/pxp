CREATE OR REPLACE FUNCTION wf.ft_labores_tipo_proceso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Work Flow
 FUNCION:     wf.ft_labores_tipo_proceso_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tlabores_tipo_proceso'
 AUTOR:      (admin)
 FECHA:         15-03-2013 16:08:41
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

  v_nombre_funcion = 'wf.ft_labores_tipo_proceso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'WF_LABTPROC_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   15-03-2013 16:08:41
  ***********************************/

  if(p_transaccion='WF_LABTPROC_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            labtproc.id_labores_tipo_proceso,
            labtproc.id_tipo_proceso,
            labtproc.codigo,
            labtproc.nombre,
            labtproc.descripcion,
            labtproc.estado_reg,
            labtproc.id_usuario_reg,
            labtproc.fecha_reg,
            labtproc.fecha_mod,
            labtproc.id_usuario_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod,
                        tp.nombre AS desc_tipo_proceso  
            from wf.tlabores_tipo_proceso labtproc
            inner join segu.tusuario usu1 on usu1.id_usuario = labtproc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = labtproc.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp ON tp.id_tipo_proceso = labtproc.id_tipo_proceso
                where  labtproc.estado_reg = ''activo'' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'WF_LABTPROC_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   15-03-2013 16:08:41
  ***********************************/

  elsif(p_transaccion='WF_LABTPROC_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_labores_tipo_proceso)
              from wf.tlabores_tipo_proceso labtproc
              inner join segu.tusuario usu1 on usu1.id_usuario = labtproc.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = labtproc.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp ON tp.id_tipo_proceso = labtproc.id_tipo_proceso
              where labtproc.estado_reg = ''activo'' and ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
    
  /*********************************    
  #TRANSACCION:  'WF_EXPLABTPROC_SEL'
  #DESCRIPCION: Exportacion de labores tipo proceso
  #AUTOR:   admin 
  #FECHA:   15-03-2013 16:08:41
  ***********************************/

  elsif(p_transaccion='WF_EXPLABTPROC_SEL')then

  		BEGIN
			v_consulta:='select  ''labores''::varchar,lab.codigo,tp.codigo,lab.nombre,lab.descripcion,lab.estado_reg
                            from wf.tlabores_tipo_proceso lab
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = lab.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and  lab.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by lab.id_labores_tipo_proceso ASC';	
                                                                       
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