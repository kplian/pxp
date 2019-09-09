--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_columna_concepto_ingas_det_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_columna_concepto_ingas_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcolumna_concepto_ingas_det'
 AUTOR:          (egutierrez)
 FECHA:            06-09-2019 13:01:53
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                06-09-2019 13:01:53                                Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcolumna_concepto_ingas_det'
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_columna_concepto_ingas_det    integer;

BEGIN

    v_nombre_funcion = 'param.ft_columna_concepto_ingas_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_COLCIGD_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez
     #FECHA:        06-09-2019 13:01:53
    ***********************************/

    if(p_transaccion='PM_COLCIGD_INS')then

        begin
            --Sentencia de la insercion
            insert into param.tcolumna_concepto_ingas_det(
            id_columna,
            id_concepto_ingas_det,
            valor,
            estado_reg,
            id_usuario_reg,
            fecha_reg,
            usuario_ai,
            id_usuario_ai,
            fecha_mod,
            id_usuario_mod
              ) values(
            v_parametros.id_columna,
            v_parametros.id_concepto_ingas_det,
            v_parametros.valor,
            'activo',
            p_id_usuario,
            now(),
            v_parametros._nombre_usuario_ai,
            v_parametros._id_usuario_ai,
            null,
            null



            )RETURNING id_columna_concepto_ingas_det into v_id_columna_concepto_ingas_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Valor Columna Detalle almacenado(a) con exito (id_columna_concepto_ingas_det'||v_id_columna_concepto_ingas_det||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_concepto_ingas_det',v_id_columna_concepto_ingas_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'PM_COLCIGD_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        06-09-2019 13:01:53
    ***********************************/

    elsif(p_transaccion='PM_COLCIGD_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tcolumna_concepto_ingas_det set
            id_columna = v_parametros.id_columna,
            id_concepto_ingas_det = v_parametros.id_concepto_ingas_det,
            valor = v_parametros.valor,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            where id_columna_concepto_ingas_det=v_parametros.id_columna_concepto_ingas_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Valor Columna Detalle modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_concepto_ingas_det',v_parametros.id_columna_concepto_ingas_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'PM_COLCIGD_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        egutierrez
     #FECHA:        06-09-2019 13:01:53
    ***********************************/

    elsif(p_transaccion='PM_COLCIGD_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tcolumna_concepto_ingas_det
            where id_columna_concepto_ingas_det=v_parametros.id_columna_concepto_ingas_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Valor Columna Detalle eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_concepto_ingas_det',v_parametros.id_columna_concepto_ingas_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    else

        raise exception 'Transaccion inexistente: %',p_transaccion;

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