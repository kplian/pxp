CREATE OR REPLACE FUNCTION wf.ft_tipo_columna_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
  $body$
  /**************************************************************************
   SISTEMA:       Work Flow
   FUNCION:       wf.ft_tipo_columna_sel
   DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_columna'
   AUTOR:          (admin)
   FECHA:         07-05-2014 21:41:15
   COMENTARIOS:
  ***************************************************************************
   HISTORIAL DE MODIFICACIONES:

   DESCRIPCION:
   AUTOR:
   FECHA:
  ***************************************************************************/

  DECLARE

    v_consulta          varchar;
    v_parametros        record;
    v_nombre_funcion    text;
    v_resp              varchar;
    v_accion			varchar;
    v_id_tabla			integer;
    v_id_tipo_estado	integer;
    v_id_proceso_wf		integer;

  BEGIN

    v_nombre_funcion = 'wf.ft_tipo_columna_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
    #TRANSACCION:  'WF_TIPCOL_SEL'
    #DESCRIPCION:   Consulta de datos
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    if(p_transaccion='WF_TIPCOL_SEL')then

      begin
        --Sentencia de la consulta
        v_consulta:='select
                        tipcol.id_tipo_columna,
                        tipcol.id_tabla,
                        tabla.id_tipo_proceso,
                        tipcol.bd_campos_adicionales,
                        tipcol.form_combo_rec,
                        tipcol.bd_joins_adicionales,
                        tipcol.bd_descripcion_columna,
                        tipcol.bd_tamano_columna,
                        tipcol.bd_formula_calculo,
                        tipcol.form_sobreescribe_config,
                        tipcol.form_tipo_columna,
                        tipcol.grid_sobreescribe_filtro,
                        tipcol.estado_reg,
                        tipcol.bd_nombre_columna,
                        tipcol.form_es_combo,
                        tipcol.form_label,
                        tipcol.grid_campos_adicionales,
                        tipcol.bd_tipo_columna,
                        tipcol.id_usuario_reg,
                        tipcol.fecha_reg,
                        tipcol.id_usuario_mod,
                        tipcol.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        tipcol.bd_prioridad,
                        tipcol.form_grupo,
                        tipcol.bd_campos_subconsulta    
                        from wf.ttipo_columna tipcol
                        inner join segu.tusuario usu1 on usu1.id_usuario = tipcol.id_usuario_reg
                        inner join wf.ttabla tabla on tabla.id_tabla = tipcol.id_tabla
                        left join segu.tusuario usu2 on usu2.id_usuario = tipcol.id_usuario_mod
                        where tipcol.estado_reg = ''activo'' and ';

        --Definicion de la respuesta
        v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

        --Devuelve la respuesta
        return v_consulta;

      end;

    /*********************************    
    #TRANSACCION:  'WF_TIPCOL_CONT'
    #DESCRIPCION:   Conteo de registros
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_TIPCOL_CONT')then

      begin
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_tipo_columna)
                        from wf.ttipo_columna tipcol
                        inner join segu.tusuario usu1 on usu1.id_usuario = tipcol.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = tipcol.id_usuario_mod
                        inner join wf.ttabla tabla on tabla.id_tabla = tipcol.id_tabla
                        where tipcol.estado_reg = ''activo'' and ';

        --Definicion de la respuesta
        v_consulta:=v_consulta||v_parametros.filtro;

        --Devuelve la respuesta
        return v_consulta;

      end;

    /*********************************    
    #TRANSACCION:  'WF_EXPTIPCOL_SEL'
    #DESCRIPCION:   Exportacion de Tipo columna
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_EXPTIPCOL_SEL')then

      BEGIN

        v_consulta:='select  ''tipo_columna''::varchar,tcol.bd_nombre_columna, tab.bd_codigo_tabla, tp.codigo,tcol.bd_tipo_columna,
                            tcol.bd_descripcion_columna,tcol.bd_tamano_columna,tcol.bd_campos_adicionales,tcol.bd_joins_adicionales,
                            tcol.bd_formula_calculo,tcol.grid_sobreescribe_filtro,tcol.grid_campos_adicionales,
                            tcol.form_tipo_columna,tcol.form_label,tcol.form_es_combo,  
                            tcol.form_combo_rec, tcol.form_sobreescribe_config,tcol.estado_reg,
                            tcol.bd_prioridad,tcol.form_grupo,
                            tcol.bd_campos_subconsulta
                            from wf.ttipo_columna tcol
                            inner join wf.ttabla tab
                            on tab.id_tabla = tcol.id_tabla
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tab.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

        if (v_parametros.todo = 'no') then
          v_consulta = v_consulta || ' and tcol.modificado is null ';
        end if;
        v_consulta = v_consulta || ' order by tcol.id_tipo_columna ASC';

        return v_consulta;


      END;

    /*********************************    
    #TRANSACCION:  'WF_TIPCOLES_SEL'
    #DESCRIPCION:   Consulta de datos por estado
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_TIPCOLES_SEL')then

      begin
        --Sentencia de la consulta
        v_consulta:='select
                        tipcol.id_tipo_columna,
                        tipcol.id_tabla,
                        tabla.id_tipo_proceso,
                        tipcol.bd_campos_adicionales,
                        tipcol.form_combo_rec,
                        tipcol.bd_joins_adicionales,
                        tipcol.bd_descripcion_columna,
                        tipcol.bd_tamano_columna,
                        tipcol.bd_formula_calculo,
                        tipcol.form_sobreescribe_config,
                        tipcol.form_tipo_columna,
                        tipcol.grid_sobreescribe_filtro,
                        tipcol.estado_reg,
                        tipcol.bd_nombre_columna,
                        tipcol.form_es_combo,
                        tipcol.form_label,
                        tipcol.grid_campos_adicionales,
                        case tipcol.bd_tipo_columna
                            when ''integer[]'' then ''text''::varchar
                            when ''varchar[]'' then ''text''::varchar
                            else tipcol.bd_tipo_columna::varchar
                        end as bd_tipo_columna,
                        tipcol.id_usuario_reg,
                        tipcol.fecha_reg,
                        tipcol.id_usuario_mod,
                        tipcol.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        (select coles.momento
                        from wf.tcolumna_estado coles
                        inner join wf.ttipo_estado te
                            on te.id_tipo_estado = coles.id_tipo_estado
                        where te.codigo = '''|| v_parametros.tipo_estado || ''' 
                            and coles.id_tipo_columna = tipcol.id_tipo_columna and coles.estado_reg = ''activo'' and coles.momento != ''preregistro'') as momento,
                        tipcol.bd_tipo_columna as bd_tipo_columna_comp,
                        tipcol.bd_campos_subconsulta
                        from wf.ttipo_columna tipcol
                        inner join segu.tusuario usu1 on usu1.id_usuario = tipcol.id_usuario_reg
                        inner join wf.ttabla tabla on tabla.id_tabla = tipcol.id_tabla
                        left join segu.tusuario usu2 on usu2.id_usuario = tipcol.id_usuario_mod
                        where tipcol.estado_reg = ''activo'' and  ';

        --Definicion de la respuesta
        v_consulta:=v_consulta||v_parametros.filtro;
        --v_consulta:=v_consulta||' and (te.codigo = '''|| v_parametros.tipo_estado || ''' or te.codigo is null) ';
        v_consulta:=v_consulta||' order by tipcol.bd_prioridad, tipcol.id_tipo_columna asc limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

        --Devuelve la respuesta
        return v_consulta;

      end;

    /*********************************    
    #TRANSACCION:  'WF_TIPCOLFOR_SEL'
    #DESCRIPCION:   Detalle de columnas a mostrar en el formulario
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:41:15
    ***********************************/

    elsif(p_transaccion='WF_TIPCOLFOR_SEL')then

      begin
        if (pxp.f_existe_parametro(p_tabla,'id_estado_wf')) then
          if (v_parametros.id_estado_wf is not null) THEN
            v_accion = 'edit';
          else
            v_accion = 'new';
          end if;
        else
          v_accion = 'new';
        end if;

        if v_accion = 'edit' THEN
          select t.id_tabla, ewf.id_tipo_estado, ewf.id_proceso_wf
          into	v_id_tabla, v_id_tipo_estado, v_id_proceso_wf
          from wf.testado_wf ewf
            inner join wf.tproceso_wf pwf on ewf.id_proceso_wf = pwf.id_proceso_wf
            inner join wf.ttabla t on t.id_tipo_proceso = pwf.id_tipo_proceso and
                                      t.vista_tipo = 'maestro'
          where ewf.id_estado_wf = v_parametros.id_estado_wf;

          if (v_id_tabla is null) then
            raise exception 'No se ha parametrizado la tabla y las columnas en el WF';
          end if;
          v_consulta = '
                		select tc.bd_nombre_columna,ce.momento,wf.f_evaluar_regla_wf (' || p_id_usuario || ',
                                             ' || v_id_proceso_wf || ',
                                             ce.regla,
                                             ' || v_id_tipo_estado || ',
                                             ' || v_parametros.id_estado_wf || ') 
                        from wf.ttipo_columna tc
        				inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna
        				inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
            			where ce.momento in (''registrar'',''exigir'') and ce.estado_reg = ''activo'' 
                        	and tc.estado_reg = ''activo'' and id_tabla = ' || v_id_tabla || ' and te.id_tipo_estado = ' || v_id_tipo_estado;


        else
          select t.id_tabla, te.id_tipo_estado
          into	v_id_tabla, v_id_tipo_estado
          from wf.ttipo_proceso tp
            inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.inicio = 'si'
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join wf.ttabla t on t.id_tipo_proceso = tp.id_tipo_proceso and
                                      t.vista_tipo = 'maestro'
          where tp.codigo = v_parametros.codigo_proceso and pm.codigo = v_parametros.proceso_macro;

          if (v_id_tabla is null) then
            raise exception 'No se ha parametrizado la tabla y las columnas en el WF';
          end if;
          v_consulta = '
                		select tc.bd_nombre_columna,ce.momento,true
                        from wf.ttipo_columna tc
        				inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna
        				inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
            			where ce.momento in (''registrar'',''exigir'') and ce.estado_reg = ''activo'' and tc.estado_reg = ''activo'' 
                        		and id_tabla = ' || v_id_tabla || ' and te.id_tipo_estado = ' || v_id_tipo_estado;

        end if;

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