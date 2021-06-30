CREATE OR REPLACE FUNCTION "param"."ft_notificaciones_ime"(
    p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
    RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Notificaciones Móviles
 FUNCION:         param.ft_notificaciones_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tnotificaciones'
 AUTOR:          (valvarado)
 FECHA:            30-03-2021 15:12:35
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                30-03-2021 15:12:35    valvarado             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento INTEGER;
    v_parametros        RECORD;
    v_id_requerimiento  INTEGER;
    v_resp              VARCHAR;
    v_nombre_funcion    TEXT;
    v_mensaje_error     TEXT;
    v_id                INTEGER;
    v_notificacion      record;
    v_notificaciones    json;
    v_notificacion_obj  varchar;
    v_enviado           varchar;
BEGIN

    v_nombre_funcion = 'param.ft_notificaciones_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PARAM_NOTI_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        valvarado    
     #FECHA:        30-03-2021 15:12:35
    ***********************************/

    IF (p_transaccion = 'PARAM_NOTI_INS') THEN

        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.tnotificaciones(estado_reg,
                                              id_funcionario_emisor,
                                              id_funcionario_receptor,
                                              id_proceso_wf,
                                              id_estado_wf,
                                              modulo,
                                              esquema,
                                              id_usuario_reg,
                                              fecha_reg,
                                              id_usuario_ai,
                                              usuario_ai,
                                              id_usuario_mod,
                                              fecha_mod,
                                              title,
                                              body,
                                              id_registro)
            VALUES ('activo',
                    v_parametros.id_funcionario_emisor,
                    v_parametros.id_funcionario_receptor,
                    v_parametros.id_proceso_wf,
                    v_parametros.id_estado_wf,
                    v_parametros.modulo,
                    v_parametros.esquema,
                    p_id_usuario,
                    now(),
                    v_parametros._id_usuario_ai,
                    v_parametros._nombre_usuario_ai,
                    null,
                    null,
                    v_parametros.title,
                    v_parametros.body,
                    v_parametros.id_registro)
            RETURNING id into v_id;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Notificaciones almacenado(a) con exito (id' || v_id || ')');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_id::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PARAM_NOTI_MOD'
         #DESCRIPCION:    Modificacion de registros
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:12:35
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_NOTI_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tnotificaciones
            SET id_funcionario_emisor   = v_parametros.id_funcionario_emisor,
                id_funcionario_receptor = v_parametros.id_funcionario_receptor,
                id_proceso_wf           = v_parametros.id_proceso_wf,
                id_estado_wf            = v_parametros.id_estado_wf,
                modulo                  = v_parametros.modulo,
                esquema                 = v_parametros.esquema,
                id_usuario_mod          = p_id_usuario,
                fecha_mod               = now(),
                id_usuario_ai           = v_parametros._id_usuario_ai,
                usuario_ai              = v_parametros._nombre_usuario_ai,
                id_registro             = v_parametros.id_registro,
                title                   = v_parametros.title,
                body                    = v_parametros.body
            WHERE id = v_parametros.id;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Notificaciones modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_parametros.id::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PARAM_NOTI_ELI'
         #DESCRIPCION:    Eliminacion de registros
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:12:35
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_NOTI_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE
            FROM param.tnotificaciones
            WHERE id = v_parametros.id;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Notificaciones eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_parametros.id::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;
        /*********************************
        #TRANSACCION:  'PARAM_MOD_ENV'
        #DESCRIPCION:    Marcar enviados
        #AUTOR:        valvarado
        #FECHA:        13-04-2021 10:48:35
       ***********************************/

    ELSIF (p_transaccion = 'PARAM_MOD_ENV') THEN

        BEGIN

            v_resp = '';
            v_notificaciones = v_parametros.notificaciones::json;

            for v_notificacion in (select json_array_elements(v_notificaciones))
                loop
                    ---asignamos valores alas varibles

                    v_notificacion_obj = v_notificacion.json_array_elements::json;
                    v_enviado = v_notificacion_obj::JSON ->> 'enviado';
                    v_id = v_notificacion_obj::JSON ->> 'id';
                    update param.tnotificaciones
                    set enviado = v_enviado
                    where id = v_id;
                end loop;

            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Notificaciones eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', 0::varchar);

            RETURN v_resp;

        END;

    ELSE

        RAISE EXCEPTION 'Transaccion inexistente: %',p_transaccion;

    END IF;

EXCEPTION

    WHEN OTHERS THEN
        v_resp = '';
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
        raise exception '%',v_resp;

END;
$BODY$
    LANGUAGE 'plpgsql' VOLATILE
                       COST 100;
ALTER FUNCTION "param"."ft_notificaciones_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
