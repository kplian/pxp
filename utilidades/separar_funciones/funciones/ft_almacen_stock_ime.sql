CREATE OR REPLACE FUNCTION alm.ft_almacen_stock_ime (
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
 FUNCION:         alm.ft_almacen_stock_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen_stock'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            01-10-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_almacen_stock    integer;
               
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_stock_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        Gonzalo Sarmiento 
     #FECHA:        01-10-2012
    ***********************************/

    if(p_transaccion='SAL_ALMITEM_INS')then
                   
        begin
            --Sentencia de la insercion
            insert into alm.talmacen_stock(
            estado_reg,
            id_almacen,
            id_item,
            id_usuario_reg,
            fecha_reg,
            id_usuario_mod,
            fecha_mod    ,
            cantidad_min,
            cantidad_alerta_amarilla,
            cantidad_alerta_roja
              ) values(
            'activo',
            v_parametros.id_almacen,
            v_parametros.id_item,
            p_id_usuario,
            now(),
            null,
            null ,
            v_parametros.cantidad_min,
            v_parametros.cantidad_alerta_amarilla,
            v_parametros.cantidad_alerta_roja
            )RETURNING id_almacen_stock into v_id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen almacenado(a) con exito (id_almacen_stock'||v_id_almacen_stock||')');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_id_almacen_stock::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_MOD')then

        begin
            --Sentencia de la modificacion
            update alm.talmacen_stock set
            id_almacen = v_parametros.id_almacen,
            id_item = v_parametros.id_item,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now() ,
            cantidad_min=v_parametros.cantidad_min,
            cantidad_alerta_amarilla=v_parametros.cantidad_alerta_amarilla,
            cantidad_alerta_roja=v_parametros.cantidad_alerta_roja
            where id_almacen_stock=v_parametros.id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_parametros.id_almacen_stock::varchar);
              
            --Devuelve la respuesta
            return v_resp;
           
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from alm.talmacen_stock
            where id_almacen_stock=v_parametros.id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_parametros.id_almacen_stock::varchar);
             
            --Devuelve la respuesta
            return v_resp;

        end;
        
    else
    
        raise exception 'Transaccion inexistente: %',p_transaccion;

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
-- Definition for function ft_movimiento_det_sel (OID = 722844) :
--
