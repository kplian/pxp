CREATE OR REPLACE FUNCTION alm.ft_movimiento_ime (
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
 FUNCION:        alm.ft_movimiento_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          03-10-2012
 COMENTARIOS:  
************************************************************************/
DECLARE
  v_nombre_funcion                 varchar; 
  v_parametros                    record;
  v_id_movimiento_tipo            integer;
  v_id_movimiento                integer;
  v_id_movimiento_tipo_ingreso    integer;
  v_id_movimiento_tipo_salida    integer;
  v_respuesta                    varchar;
  v_id_movimiento_ingreso        integer;
  v_id_movimiento_salida        integer;
  v_transferencia                record;
  v_consulta                    varchar;
  v_detalle                        record;

BEGIN
  v_nombre_funcion='alm.ft_movimiento_ime';
  v_parametros=f_get_record(p_tabla);
 
 
  /*********************************  
     #TRANSACCION:  'SAL_MOV_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/
  if(p_transaccion='SAL_MOV_INS')then
      begin       
        v_id_movimiento_tipo=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo=v_parametros.codigo);       

        insert into alm.tmovimiento
                      (id_movimiento_tipo, id_almacen,
                     id_funcionario, id_proveedor,
                     id_almacen_dest, fecha_mov,
                     numero_mov, descripcion,
                     observaciones, id_usuario_reg,
                     fecha_reg, estado_reg, estado_mov)
                     values(v_id_movimiento_tipo,v_parametros.id_almacen,
                     v_parametros.id_funcionario, v_parametros.id_proveedor,
                     v_parametros.id_almacen_dest,v_parametros.fecha_mov,
                     v_parametros.numero_mov, v_parametros.descripcion,
                     v_parametros.observaciones, p_id_usuario,
                     now(),'activo', 'borrador')
                     RETURNING id_movimiento into v_id_movimiento;

        v_respuesta =f_agrega_clave(v_respuesta,'mensaje','Movimiento almacenado correctamente');
        v_respuesta =f_agrega_clave(v_respuesta,'id_movimiento',v_id_movimiento::varchar);

        return v_respuesta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/         
               
  elseif(p_transaccion='SAL_MOV_MOD')then
      begin
        update alm.tmovimiento set                    
                     id_almacen=v_parametros.id_almacen,
                     id_funcionario=v_parametros.id_funcionario,
                     id_proveedor=v_parametros.id_proveedor,
                     id_almacen_dest=v_parametros.id_almacen_dest,
                     fecha_mov=v_parametros.fecha_mov,
                     numero_mov=v_parametros.numero_mov,
                     descripcion=v_parametros.descripcion,
                     observaciones=v_parametros.observaciones,
                     id_usuario_mod=p_id_usuario,
                     fecha_mod=now()
        where id_movimiento = v_parametros.id_movimiento;
       
        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento modificado con exito');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/
  elseif(p_transaccion='SAL_MOV_ELI')then
      begin
        delete from alm.tmovimiento
        where id_movimiento=v_parametros.id_movimiento;

        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento eliminado');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);

        return v_respuesta;
    end;
  elseif(p_transaccion='SAL_MOV_FIN')then
      begin

        update alm.tmovimiento set
        estado_mov='finalizado'
        where id_movimiento=v_parametros.id_movimiento;
       
        if(v_parametros.operacion='finalizarTransferencia')then
            begin
                select * into v_transferencia from alm.tmovimiento where id_movimiento=v_parametros.id_movimiento;
                v_id_movimiento_tipo_ingreso=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo='ING');                       
               
                v_id_movimiento_tipo_salida=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo='SAL');
               
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_ingreso,
                v_transferencia.id_almacen_dest,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
                now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_ingreso;
               
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_salida,
                v_transferencia.id_almacen,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
                now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_salida;
               
                v_consulta='select * from alm.tmovimiento_det where id_movimiento='||v_parametros.id_movimiento||'';
                FOR v_detalle IN EXECUTE(v_consulta)
                LOOP    
                    insert into alm.tmovimiento_det(
                    id_movimiento,id_item,cantidad, costo_unitario,fecha_caducidad,
                    id_usuario_reg,fecha_reg,estado_reg)values
                    (v_id_movimiento_ingreso, v_detalle.id_item,v_detalle.cantidad,
                    v_detalle.costo_unitario, v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg,now(),'activo');
                   
                    insert into alm.tmovimiento_det(
                    id_movimiento,id_item, cantidad, costo_unitario,
                    fecha_caducidad, id_usuario_reg, fecha_reg, estado_reg)
                    values(
                    v_id_movimiento_salida, v_detalle.id_item, v_detalle.cantidad,
                    v_detalle.costo_unitario,v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg, now(),'activo');                             
                   END LOOP;
            end;
        end if;
        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento finalizado');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;   
    end;
  else
       raise exception 'Transaccion inexistente: %',p_transaccion;
  end if;
EXCEPTION
  WHEN OTHERS THEN
        v_respuesta='';
        v_respuesta = f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta = f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta = f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;