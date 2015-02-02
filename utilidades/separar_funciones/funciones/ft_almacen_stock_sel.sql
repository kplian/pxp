CREATE OR REPLACE FUNCTION alm.ft_almacen_stock_sel (
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
 FUNCION:         alm.ft_almacen_stock_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            01-10-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_item_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        01-10-2012
    ***********************************/

    if(p_transaccion='SAL_ALMITEM_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        almitem.id_almacen_stock,
                        almitem.estado_reg,
                        almitem.id_almacen,
                        almitem.id_item,
                        item.nombre as desc_item,
                        almitem.cantidad_min,
                        almitem.cantidad_alerta_amarilla,
                        almitem.cantidad_alerta_roja,
                        almitem.id_usuario_reg,
                        almitem.fecha_reg,
                        almitem.id_usuario_mod,
                        almitem.fecha_mod
                        from alm.talmacen_stock almitem, alm.titem item
                        where almitem.id_item = item.id_item and ';
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
           
            if (public.f_existe_parametro(p_tabla,'id_almacen')) then        
                v_consulta:= v_consulta || ' and almitem.id_almacen='||v_parametros.id_almacen;
            end if;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                       
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(almitem.id_almacen_stock)
                        from alm.talmacen_stock almitem, alm.titem item
                        where almitem.id_item = item.id_item and  ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;
            if (public.f_existe_parametro(p_tabla,'id_almacen')) then        
                v_consulta:= v_consulta || ' and almitem.id_almacen='||v_parametros.id_almacen;
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
            v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_almacen_stock_ime (OID = 712319) :
--
