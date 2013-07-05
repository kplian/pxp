CREATE OR REPLACE FUNCTION param.f_tproveedor_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Parametros Generales
 FUNCION:     param.f_tproveedor_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tproveedor'
 AUTOR:      (mzm)
 FECHA:         15-11-2011 10:44:58
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

  v_nombre_funcion = 'param.f_tproveedor_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'PM_PROVEE_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   mzm 
  #FECHA:   15-11-2011 10:44:58
  ***********************************/

  if(p_transaccion='PM_PROVEE_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            provee.id_proveedor,
            provee.id_persona,
            provee.codigo,
              provee.numero_sigma,
            provee.tipo,
            provee.estado_reg,
            provee.id_institucion,
            provee.id_usuario_reg,
            provee.fecha_reg,
            provee.id_usuario_mod,
            provee.fecha_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod  ,
            person.nombre_completo1,
            instit.nombre,
            provee.nit,
            provee.id_lugar,
            lug.nombre as lugar,
            param.f_obtener_padre_lugar(provee.id_lugar,''pais'') as pais,
            param.f_get_datos_proveedor(provee.id_proveedor,''correos'') as correos,
            param.f_get_datos_proveedor(provee.id_proveedor,''telefonos'') as telefonos,
            param.f_get_datos_proveedor(provee.id_proveedor,''items'') as items,
            param.f_get_datos_proveedor(provee.id_proveedor,''servicios'') as servicios 
            from param.tproveedor provee
            inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
                where  ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
raise notice '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'PM_PROVEE_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   mzm 
  #FECHA:   15-11-2011 10:44:58
  ***********************************/

  elsif(p_transaccion='PM_PROVEE_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_proveedor)
              from param.tproveedor provee
            inner join segu.tusuario usu1 on usu1.id_usuario = provee.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = provee.id_usuario_mod   
                        left join segu.vpersona person on person.id_persona=provee.id_persona
                        left join param.tinstitucion instit on instit.id_institucion=provee.id_institucion
                        left join param.tlugar lug on lug.id_lugar = provee.id_lugar
                where  ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
    
    /*********************************    
  #TRANSACCION:  'PM_PROVEEV_SEL'
  #DESCRIPCION: Consulta de datos de proveedores a partir de una vista de base
                    de datos
  #AUTOR:   rac 
  #FECHA:   08-12-2011 10:44:58
  ***********************************/    
        
          
  elseif(p_transaccion='PM_PROVEEV_SEL')then
            
      begin
          
        --Sentencia de la consulta
      v_consulta:='select
            id_proveedor,
                        id_persona,
                        codigo,
                        numero_sigma,
                        tipo,
                        id_institucion,
                        desc_proveedor,
                        nit,
                        id_lugar,
                        lugar,
                        pais
            from param.vproveedor provee
            where  ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'PM_PROVEEV_CONT'
  #DESCRIPCION: Conteo de registros de proveedores en la vista vproveedor
  #AUTOR:   rac 
  #FECHA:   09-12-2011 10:44:58
  ***********************************/

  elsif(p_transaccion='PM_PROVEEV_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_proveedor)
              from param.vproveedor provee
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