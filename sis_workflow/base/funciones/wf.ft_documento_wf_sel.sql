CREATE OR REPLACE FUNCTION wf.ft_documento_wf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Work Flow
 FUNCION:     wf.ft_documento_wf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tdocumento_wf'
 AUTOR:      (admin)
 FECHA:         15-01-2014 13:52:19
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
    v_nro_tramite varchar;
    v_id_proceso_macro integer;
    v_filtro      varchar;
    v_id_tipo_estado_actual   integer; 
    v_id_estado_actual    integer; 
    v_id_tipo_estado_siguiente  integer[]; 
    v_cantidad_siguiente    integer;
    v_id_tipo_estado      integer;
          
BEGIN

  v_nombre_funcion = 'wf.ft_documento_wf_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'WF_DWF_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   15-01-2014 13:52:19
  ***********************************/

  if(p_transaccion='WF_DWF_SEL')then
            
      begin
           
           select 
               pw.nro_tramite,
               tp.id_proceso_macro,
                 ew.id_tipo_estado
             into 
               v_nro_tramite,
               v_id_proceso_macro,
                 v_id_tipo_estado
             
             from wf.tproceso_wf pw
               inner join wf.testado_wf ew on ew.id_proceso_wf = pw.id_proceso_wf and 
                            ew.estado_reg= 'activo'                                        
             inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
             where pw.id_proceso_wf = v_parametros.id_proceso_wf;
               
           if (v_parametros.todos_documentos = 'si') then            
             
             v_filtro = ' pw.nro_tramite = '''||COALESCE(v_nro_tramite,'--')||''' and  ';
         else
            v_filtro = ' pw.id_proceso_wf = ' || v_parametros.id_proceso_wf::varchar || ' and  ';
         
         end if;
           
           
            raise notice '>>>>>>>>>>>  % - % - %<<<<<<<<<<<<<<<<<', v_nro_tramite,
               v_id_proceso_macro,
                 v_id_tipo_estado;
           
        --Sentencia de la consulta
      v_consulta:='
                  with documento_modificar as (
                        select td.id_tipo_documento,''si''::varchar as modificar
                        from wf.ttipo_documento td
                        inner join wf.ttipo_documento_estado tde on tde.id_tipo_documento = td.id_tipo_documento
                        where tde.id_tipo_estado = ' || v_id_tipo_estado || ' and tde.estado_reg=''activo''
                        and tde.momento = ''modificar''
                        ), documento_insertar as (
                        select td.id_tipo_documento,''si''::varchar as insertar
                        from wf.ttipo_documento td
                        inner join wf.ttipo_documento_estado tde on tde.id_tipo_documento = td.id_tipo_documento
                        where tde.id_tipo_estado = ' || v_id_tipo_estado || ' and tde.estado_reg=''activo''
                        and tde.momento = ''insertar''
                        ), documento_eliminar as (
                        select td.id_tipo_documento,''si''::varchar as eliminar
                        from wf.ttipo_documento td
                        inner join wf.ttipo_documento_estado tde on tde.id_tipo_documento = td.id_tipo_documento
                        where tde.id_tipo_estado = ' || v_id_tipo_estado || ' and tde.estado_reg=''activo''
                        and tde.momento = ''eliminar''
                        )
                  select
                        dwf.id_documento_wf,
                        dwf.url,
                        dwf.num_tramite,
                        dwf.id_tipo_documento,
                        dwf.obs,
                        dwf.id_proceso_wf,
                        dwf.extension,
                        dwf.chequeado,
                        dwf.estado_reg,
                        dwf.nombre_tipo_doc,
                        dwf.nombre_doc,
                        dwf.momento,
                        dwf.fecha_reg,
                        dwf.id_usuario_reg,
                        dwf.fecha_mod,
                        dwf.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        tp.codigo as codigo_tipo_proceso,
                        td.codigo as codigo_tipo_documento,
                        td.nombre as nombre_tipo_documento,
                        td.descripcion as descripcion_tipo_documento,
                        
                        pw.nro_tramite,
                        pw.codigo_proceso,
                        pw.descripcion as descripcion_proceso_wf,
                        tewf.nombre_estado,
                        dwf.chequeado_fisico,
                        usu3.cuenta as usr_upload,
                        dwf.fecha_upload,
                        td.tipo as tipo_documento,
                        td.action,
                        td.solo_lectura,
                        dwf.id_documento_wf_ori,
                        dwf.id_proceso_wf_ori,
                        dwf.nro_tramite_ori,
                        wf.f_priorizar_documento(' || v_parametros.id_proceso_wf ||',' || p_id_usuario ||
                        ',td.id_tipo_documento,''' || v_parametros.dir_ordenacion ||''' ) as priorizacion,
                        dm.modificar,
                        di.insertar,
                        de.eliminar,
                        dwf.demanda,
                        td.nombre_vista,
                        td.esquema_vista,
                        td.nombre_archivo_plantilla
            from wf.tdocumento_wf dwf
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf
                        inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
                        left join segu.tusuario usu2 on usu2.id_usuario = dwf.id_usuario_mod
                        left join segu.tusuario usu3 on usu3.id_usuario = dwf.id_usuario_upload
                        inner join segu.tusuario usu1 on usu1.id_usuario = dwf.id_usuario_reg
                        inner join wf.testado_wf ewf  on ewf.id_proceso_wf = dwf.id_proceso_wf and ewf.estado_reg = ''activo''
                        inner join wf.ttipo_estado tewf on tewf.id_tipo_estado = ewf.id_tipo_estado
                        left join documento_modificar dm on dm.id_tipo_documento = td.id_tipo_documento
                        left join documento_insertar di on di.id_tipo_documento = td.id_tipo_documento
                        left join documento_eliminar de on de.id_tipo_documento = td.id_tipo_documento
                        
                        
                where  ' || v_filtro;
      --raise notice 'zzzzz %',array_length(v_id_tipo_estado_siguiente, 1);
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by priorizacion ' || v_parametros.dir_ordenacion || ',pw.fecha_reg ,td.orden, ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            
            raise notice '>>>>>>>>  % <<<<<<<<<<<<<<',  v_consulta;
            --Devuelve la respuesta
      return v_consulta;
            
    end;
    
    
    /*********************************    
  #TRANSACCION:  'WF_DWFRUTA_SEL'
  #DESCRIPCION: Obtener ruta de documento
  #AUTOR:   admin 
  #FECHA:   15-01-2014 13:52:19
  ***********************************/

  elsif(p_transaccion='WF_DWFRUTA_SEL')then

    begin        
        
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select (''' || v_parametros.dominio || ''' || replace(dwf.url, ''./../../../'', ''''))::varchar
              from wf.tdocumento_wf dwf                        
                where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;

  /*********************************    
  #TRANSACCION:  'WF_DWF_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   15-01-2014 13:52:19
  ***********************************/

  elsif(p_transaccion='WF_DWF_CONT')then

    begin
            
        
            if (v_parametros.todos_documentos = 'si') then
             select 
               pw.nro_tramite,
               tp.id_proceso_macro
             into 
               v_nro_tramite,
               v_id_proceso_macro
             
             from wf.tproceso_wf pw
             inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
             where pw.id_proceso_wf = v_parametros.id_proceso_wf;
             
             v_filtro = ' pw.nro_tramite = '''||COALESCE(v_nro_tramite,'--')||''' and  ';
         else
            v_filtro = ' pw.id_proceso_wf = ' || v_parametros.id_proceso_wf || ' and ';
         
         end if;
        
        
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_documento_wf)
              from wf.tdocumento_wf dwf
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf
                        inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
                        left join segu.tusuario usu2 on usu2.id_usuario = dwf.id_usuario_mod
                        left join segu.tusuario usu3 on usu3.id_usuario = dwf.id_usuario_upload
                        inner join segu.tusuario usu1 on usu1.id_usuario = dwf.id_usuario_reg
                        inner join wf.testado_wf ewf  on ewf.id_proceso_wf = dwf.id_proceso_wf and ewf.estado_reg = ''activo''
                        inner join wf.ttipo_estado tewf on tewf.id_tipo_estado = ewf.id_tipo_estado
                where ' || v_filtro;
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
        
    /*********************************    
  #TRANSACCION:  'WF_DWFFIRMA_SEL'
  #DESCRIPCION: fira de documentos
  #AUTOR:   gayme 
  #FECHA:   15-01-2014 13:52:19
  ***********************************/
    elsif(p_transaccion='WF_DWFFIRMA_SEL')then
            
      begin           
          
        --Sentencia de la consulta
      v_consulta:='select
            dwf.id_documento_wf,
            dwf.url,
            dwf.num_tramite,
            dwf.id_tipo_documento,
            dwf.obs,
            dwf.id_proceso_wf,
            dwf.extension,
            dwf.chequeado,
            dwf.estado_reg,
            dwf.nombre_tipo_doc,
            dwf.nombre_doc,
            dwf.momento,
                        dwf.accion_pendiente,
                        dwf.fecha_firma,
                        dwf.usuario_firma,
                        td.action,
                        usu.desc_persona as nombre_usuario_firma       
            from wf.tdocumento_wf dwf
                        inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf 
                        inner join segu.vusuario usu on usu.cuenta = dwf.usuario_firma                       
                where  dwf.accion_pendiente is not null ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion;

            
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