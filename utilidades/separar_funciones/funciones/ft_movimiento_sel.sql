CREATE OR REPLACE FUNCTION alm.ft_movimiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:  
***************************************************************************/

DECLARE
  v_nombre_funcion    varchar;
  v_consulta         varchar;
  v_parametros         record;
  v_respuesta        varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_sel';
  v_parametros=f_get_record(p_tabla);
 
  /*********************************  
     #TRANSACCION:  'SAL_MOV_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        02-12-2012
    ***********************************/
 
  if(p_transaccion='SAL_MOV_SEL')then
      begin
        v_consulta:='select
            mov.id_movimiento,
            mov.id_movimiento_tipo,
            mov.id_almacen,
            almo.nombre as nombre_origen,
            mov.id_funcionario,
            mov.id_proveedor,
            mov.id_almacen_dest,
            almd.nombre as nombre_destino,
            mov.fecha_mov,
            mov.numero_mov,
            mov.descripcion,
            mov.observaciones,
            mov.id_usuario_reg,
            mov.fecha_reg,
            mov.id_usuario_mod,
            mov.fecha_mod,
            mov.estado_mov
            from alm.tmovimiento_tipo movtipo
            INNER JOIN alm.tmovimiento mov on mov.id_movimiento_tipo = movtipo.id_movimiento_tipo
            INNER JOIN alm.talmacen almo on almo.id_almacen= mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen= mov.id_almacen_dest
            where movtipo.codigo='''||v_parametros.codigo||''' and ';
        v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;           
        return v_consulta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        24-09-2012
    ***********************************/
  elsif(p_transaccion='SAL_MOV_CONT')then
    begin
        v_consulta:='select count(mov.id_movimiento)
                    from alm.tmovimiento mov,alm.tmovimiento_tipo movtipo
                    where movtipo.codigo= ''||v_parametros.codigo||'' and
                          movtipo.id_movimiento_tipo=mov.id_movimiento_tipo and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;
  end if;
EXCEPTION
  WHEN OTHERS THEN
    v_respuesta='';
    v_respuesta=f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
    v_respuesta=f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
    v_respuesta=f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
    raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_movimiento_ime (OID = 738894) :
--
