CREATE OR REPLACE FUNCTION alm.ft_item_sel (
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
 FUNCION:        alm.ft_item_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.titem'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            20-09-2012
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

    v_nombre_funcion = 'alm.ft_item_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        20-09-2012
    ***********************************/

    if(p_transaccion='SAL_ITEM_SEL')then
                   
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        item.id_item,
                        item.id_clasificacion,
                        cla.nombre as desc_clasificacion,
                        cla.codigo_largo,
                        item.nombre,
                        item.descripcion,
                        item.palabras_clave,
                        item.codigo_fabrica,
                        item.observaciones,
                        item.numero_serie                      
                        from alm.titem item, alm.tclasificacion cla
                        where item.id_clasificacion = cla.id_clasificacion and ';
          
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
           
            --Devuelve la respuesta
            return v_consulta;
           
                      
        end;

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(item.id_item)
                        from alm.titem item
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
            v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_almacen_stock_sel (OID = 711099) :
--
