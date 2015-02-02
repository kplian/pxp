CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_sel (
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
 FUNCION:        alm.ft_movimiento_det_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion    text;
  v_parametros         record;
  v_consulta         varchar;
  v_respuesta         varchar;
BEGIN
  v_nombre_funcion = 'alm.ft_movimiento_det_sel';
  v_parametros = f_get_record(p_tabla);
 
  /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        02-10-2012
    ***********************************/
   
  if(p_transaccion='SAL_MOV_DET_SEL') then
      begin
    ---sentencia de la consulta----
     v_consulta:='select
                     movdet.id_movimiento_det,
                    movdet.id_movimiento,
                    movdet.id_item,                   
                    item.nombre as desc_item,
                    movdet.cantidad,
                    movdet.costo_unitario,
                    movdet.fecha_caducidad,
                    movdet.id_usuario_reg,
                    movdet.fecha_reg,
                    movdet.id_usuario_mod,
                    movdet.fecha_mod
                    from alm.tmovimiento_det movdet,alm.titem item
                    where movdet.id_item = item.id_item and ';         
    -----DEFINICION DE LA RESPUESTA-----
     v_consulta:=v_consulta||v_parametros.filtro;
           
            if (public.f_existe_parametro(p_tabla,'id_movimiento')) then        
                v_consulta:= v_consulta || ' and movdet.id_movimiento='||v_parametros.id_movimiento;
            end if;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

       
            raise notice '%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;
    end;
      /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_CONT'
     #DESCRIPCION:   Conteo de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_MOV_DET_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(movdet.id_movimiento_det)
                        from alm.tmovimiento_det movdet, alm.tmovimiento mov
                        where movdet.id_movimiento = mov.id_movimiento and  ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;
            if (public.f_existe_parametro(p_tabla,'id_movimiento')) then        
                v_consulta:= v_consulta || ' and movdet.id_movimiento='||v_parametros.id_movimiento;
            end if;
            --Devuelve la respuesta
            return v_consulta;

        end;
                   
    else
                        
        raise exception 'Transaccion inexistente';
                            
    end if;
 
EXCEPTION
    WHEN OTHERS THEN
            v_respuesta='';
            v_respuesta = f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_respuesta = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_respuesta = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_movimiento_det_ime (OID = 725600) :
--
