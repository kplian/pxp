CREATE OR REPLACE FUNCTION "param"."f_insertar_notificacion"(
    p_administrador integer, p_id_usuario integer, p_id_registro integer, p_id_proceso_wf integer,
    p_id_estado_wf integer,
    p_id_funcionario_emisor integer, p_id_funcionario_receptor integer, p_modulo varchar, p_esquema varchar,
    p_mensaje varchar,
    p_titulo varchar,
    p_nombre_vista varchar default '')
    RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Notificaciones Móviles
 FUNCION:         param.f_insertar_notificacion
 DESCRIPCION:   funcion que se utiliza para registrar una notificacion para enivarse a telefonos moviles
 AUTOR:          (valvarado)
 FECHA:            13-04-2021 11:57:35
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                13-04-2021 11:57:35    valvarado             Creacion
 #
 ***************************************************************************/

DECLARE

    v_parametros     RECORD;
    v_resp           VARCHAR;
    v_nombre_funcion TEXT;
    v_id             INTEGER;
BEGIN

    v_nombre_funcion = 'param.f_insertar_notificacion';


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
                                          title,
                                          body,
                                          id_registro,
                                          enviado,
                                          nombre_vista)
        VALUES ('activo',
                p_id_funcionario_emisor,
                p_id_funcionario_receptor,
                p_id_proceso_wf,
                p_id_estado_wf,
                p_modulo,
                p_esquema,
                p_id_usuario,
                now(),
                p_titulo,
                p_mensaje,
                p_id_registro,
                'no',
                p_nombre_vista)
        RETURNING id into v_id;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Notificaciones almacenado(a) con exito (id' || v_id || ')');
        v_resp = pxp.f_agrega_clave(v_resp, 'id', v_id::varchar);

        --Devuelve la respuesta
        RETURN v_resp;

    END;


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
ALTER FUNCTION "param"."f_insertar_notificacion"(integer, integer, integer, integer, integer, integer, integer, varchar, varchar, varchar, varchar,varchar) OWNER TO postgres;
