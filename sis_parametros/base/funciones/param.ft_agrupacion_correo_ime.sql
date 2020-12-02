--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_agrupacion_correo_ime (
    p_administrador integer,
    p_id_usuario integer,
    p_tabla varchar,
    p_transaccion varchar
)
    RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_agrupacion_correo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tagrupacion_correo'
 AUTOR:          (egutierrez)
 FECHA:            26-11-2020 15:27:53
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:27:53    egutierrez             Creacion
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_agrupacion_correo    INTEGER;

BEGIN

    v_nombre_funcion = 'param.ft_agrupacion_correo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_COR_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:27:53
    ***********************************/

    IF (p_transaccion='PM_COR_INS') THEN

        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.tagrupacion_correo(
                estado_reg,
                id_funcionario,
                correo,
                id_usuario_reg,
                fecha_reg,
                id_usuario_ai,
                usuario_ai,
                id_usuario_mod,
                fecha_mod,
                id_tipo_envio_correo
            ) VALUES (
                         'activo',
                         v_parametros.id_funcionario,
                         v_parametros.correo,
                         p_id_usuario,
                         now(),
                         v_parametros._id_usuario_ai,
                         v_parametros._nombre_usuario_ai,
                         null,
                         null,
                         v_parametros.id_tipo_envio_correo
                     ) RETURNING id_agrupacion_correo into v_id_agrupacion_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Correos almacenado(a) con exito (id_agrupacion_correo'||v_id_agrupacion_correo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_agrupacion_correo',v_id_agrupacion_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PM_COR_MOD'
         #DESCRIPCION:    Modificacion de registros
         #AUTOR:        egutierrez
         #FECHA:        26-11-2020 15:27:53
        ***********************************/

    ELSIF (p_transaccion='PM_COR_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tagrupacion_correo SET
                                                id_funcionario = v_parametros.id_funcionario,
                                                correo = v_parametros.correo,
                                                id_usuario_mod = p_id_usuario,
                                                fecha_mod = now(),
                                                id_usuario_ai = v_parametros._id_usuario_ai,
                                                usuario_ai = v_parametros._nombre_usuario_ai,
                                                id_tipo_envio_correo = v_parametros.id_tipo_envio_correo
            WHERE id_agrupacion_correo=v_parametros.id_agrupacion_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Correos modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_agrupacion_correo',v_parametros.id_agrupacion_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PM_COR_ELI'
         #DESCRIPCION:    Eliminacion de registros
         #AUTOR:        egutierrez
         #FECHA:        26-11-2020 15:27:53
        ***********************************/

    ELSIF (p_transaccion='PM_COR_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tagrupacion_correo
            WHERE id_agrupacion_correo=v_parametros.id_agrupacion_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Correos eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_agrupacion_correo',v_parametros.id_agrupacion_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    ELSE

        RAISE EXCEPTION 'Transaccion inexistente: %',p_transaccion;

    END IF;

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
    PARALLEL UNSAFE
    COST 100;