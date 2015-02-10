CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_ime (
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
 FUNCION:         alm.ft_movimiento_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_det'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion         varchar;
  v_consulta            varchar;
  v_parametros          record;
  v_respuesta             varchar;
  v_id_movimiento_det    integer;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_det_ime';
  v_parametros=f_get_record(p_tabla);
  /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Gonzalo Sarmiento 
     #FECHA:        02-10-2012
    ***********************************/
    if(p_transaccion='SAL_MOV_DET_INS') then
        begin
            insert into alm.tmovimiento_det(
                id_usuario_reg,
                fecha_reg,
                estado_reg,               
                id_movimiento,
                id_item,
                cantidad,
                costo_unitario,
                fecha_caducidad)
                VALUES(
                p_id_usuario,
                now(),
                'activo',
                v_parametros.id_movimiento,
                v_parametros.id_item,
                v_parametros.cant,
                v_parametros.costo_unitario,
                v_parametros.fecha_caducidad)
                RETURNING id_movimiento_det into v_id_movimiento_det;
                 
                v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento almacenado(a) con exito (id_movimiento_det'||v_id_movimiento_det||')');
                v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento_det',v_id_movimiento_det::varchar);

                return v_respuesta;
        end;
    /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/
    elseif(p_transaccion='SAL_MOV_DET_MOD')then
        begin
            update alm.tmovimiento_det set
            id_usuario_mod=p_id_usuario,
            fecha_mod=now(),
            id_movimiento=v_parametros.id_movimiento,
            id_item=v_parametros.id_item,
            cantidad=v_parametros.cant,
            costo_unitario=v_parametros.costo_unitario,
            fecha_caducidad=v_parametros.fecha_caducidad
            where id_movimiento_det=v_parametros.id_movimiento_det;
           
            v_respuesta = f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento modificado con exito');
            v_respuesta = f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
           
            return v_respuesta;
        end;
    /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/
    elseif(p_transaccion='SAL_MOV_DET_ELI')then
        begin
            RAISE NOTICE 'llega gonzalo';
            delete from alm.tmovimiento_det
            where id_movimiento_det=v_parametros.id_movimiento_det;
           
            v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento eliminado correctamente');
            v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
          
            return v_respuesta;
        end;
    else
        raise exception 'Transaccion inexistente';
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
-- Definition for function ft_movimiento_sel (OID = 728848) :
--
