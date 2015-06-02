CREATE OR REPLACE FUNCTION wf.ft_tipo_documento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Work Flow
 FUNCION:     wf.ft_tipo_documento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_documento'
 AUTOR:      (admin)
 FECHA:         14-01-2014 17:43:47
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

  v_nombre_funcion = 'wf.ft_tipo_documento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'WF_TIPDW_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   14-01-2014 17:43:47
  ***********************************/

  if(p_transaccion='WF_TIPDW_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            tipdw.id_tipo_documento,
            tipdw.nombre,
            tipdw.id_proceso_macro,
            tipdw.codigo,
            tipdw.descripcion,
            tipdw.estado_reg,
            tipdw.tipo,
            tipdw.id_tipo_proceso,            
            tipdw.action,
            tipdw.id_usuario_reg,
            tipdw.fecha_reg,
            tipdw.id_usuario_mod,
            tipdw.fecha_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod,
                        tipdw.solo_lectura,
                        array_to_string( tipdw.categoria_documento,'','',''null'')::varchar as categoria_documento,
                        tipdw.orden,
                        tipdw.nombre_vista,
                        tipdw.nombre_archivo_plantilla,
                        tipdw.esquema_vista
            from wf.ttipo_documento tipdw
            inner join segu.tusuario usu1 on usu1.id_usuario = tipdw.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tipdw.id_usuario_mod
                where tipdw.estado_reg = ''activo'' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'WF_TIPDW_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   14-01-2014 17:43:47
  ***********************************/

  elsif(p_transaccion='WF_TIPDW_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_tipo_documento)
              from wf.ttipo_documento tipdw
              inner join segu.tusuario usu1 on usu1.id_usuario = tipdw.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = tipdw.id_usuario_mod
              where  tipdw.estado_reg = ''activo'' and  ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
        
    /*********************************    
  #TRANSACCION:  'WF_EXPTIPDW_SEL'
  #DESCRIPCION: Exportacion de Tipo documento
  #AUTOR:   admin 
  #FECHA:   14-01-2014 17:43:47
  ***********************************/

  elsif(p_transaccion='WF_EXPTIPDW_SEL')then

    BEGIN

               v_consulta:='select  ''tipo_documento''::varchar,tdoc.codigo,tp.codigo,tdoc.nombre,tdoc.descripcion,
                            tdoc.action,tdoc.tipo,tdoc.estado_reg,tdoc.orden,tdoc.categoria_documento
                            from wf.ttipo_documento tdoc
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tdoc.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro ='|| v_parametros.id_proceso_macro;

        if (v_parametros.todo = 'no') then                   
                  v_consulta = v_consulta || ' and tdoc.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by tdoc.id_tipo_documento ASC'; 
                                                                       
               return v_consulta;


         END;
         
   /*********************************    
    #TRANSACCION:  'WF_TIDOCPLAN_SEL'
    #DESCRIPCION: Consulta de datos
    #AUTOR:       RCM 
    #FECHA:       20/05/2015
    ***********************************/

    elsif(p_transaccion='WF_TIDOCPLAN_SEL')then
              
        begin

        if v_parametros.nombre_vista is null then
          raise exception 'Parametro nombre_vista es nulo';
        end if;
        
          --Sentencia de la consulta
          v_consulta:='select column_name::varchar,
                       data_type::varchar,
                       character_maximum_length::int4
                       from INFORMATION_SCHEMA.COLUMNS
                    where table_name = '''||v_parametros.nombre_vista || '''';
          
          --Definicion de la respuesta
          --v_consulta:=v_consulta||' order by 1';

          --Devuelve la respuesta
          return v_consulta;
                
        end;
        
  /*********************************    
  #TRANSACCION:  'WF_TIDOCPLAN_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:     RCM
  #FECHA:     20/05/2015
  ***********************************/

  elsif(p_transaccion='WF_TIDOCPLAN_CONT')then

    begin
          if v_parametros.nombre_vista is null then
              raise exception 'Parametro nombre_vista es nulo';
            end if;
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(1)
              from INFORMATION_SCHEMA.COLUMNS
                      where table_name = '''||v_parametros.nombre_vista || '''';
      raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;

    end;
    
    
  /*********************************    
  #TRANSACCION:  'WF_VISTA_SEL'
  #DESCRIPCION: Devuelve los datos dinámicos de la vista enviada
  #AUTOR:       RCM 
  #FECHA:       20/05/2015
  ***********************************/

    elsif(p_transaccion='WF_VISTA_SEL')then
              
        begin

        if v_parametros.nombre_vista is null then
          raise exception 'Parametro nombre_vista es nulo';
        end if;
        
          --Sentencia de la consulta
          v_consulta:='select *
                       from ' || v_parametros.esquema_vista || '.' ||v_parametros.nombre_vista || '
                       where id_proceso_wf = '||v_parametros.id_proceso_wf;
          
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