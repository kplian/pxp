CREATE OR REPLACE FUNCTION param.f_insert_chat(p_administrador integer, p_id_usuario integer, p_tabla varchar,
                                               p_code_tipo_chat varchar, p_table_id integer)
    RETURNS integer
AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros
 FUNCION:         param.f_insert_chat
 DESCRIPCION:   Funciona para insertar chat y chat usuarios
 AUTOR:          Favio Figueroa (Finguer)
 FECHA:            30-06-2020 16:17:47
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                23-06-2020 16:17:47    Favio Figueroa             Creacion
 ***************************************************************************/
DECLARE
    v_parametros                 RECORD;
    v_resp                       varchar;
    v_nombre_funcion             text;
    v_id_tipo_chat               INTEGER;
    v_id_chat                    INTEGER;
    v_id_chat_usuario            INTEGER;
    v_usuarios                   varchar;
    v_tabla                      varchar;
    v_nombre_id                  varchar;
    v_record_names_usuarios_chat record;
    v_json                       json;
    v_id_usuario_chat            integer;

BEGIN


    v_nombre_funcion = 'afi.f_get_pago_periodo_afiliado';
    v_parametros = pxp.f_get_record(p_tabla);


    SELECT id_tipo_chat, usuarios, tabla, nombre_id
    INTO v_id_tipo_chat, v_usuarios, v_tabla, v_nombre_id
    FROM param.ttipo_chat
    WHERE codigo = p_code_tipo_chat
    LIMIT 1;

    INSERT INTO param.tchat(descripcion,
                            id_tipo_chat,
                            id_tabla,
                            estado_reg,
                            id_usuario_ai,
                            usuario_ai,
                            fecha_reg,
                            id_usuario_reg,
                            id_usuario_mod,
                            fecha_mod)
    VALUES ('chat for table tipo_chat',
            v_id_tipo_chat,
            p_table_id,
            'activo',
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            now(),
            p_id_usuario,
            NULL,
            NULL)
    RETURNING id_chat INTO v_id_chat;


    EXECUTE format('select row_to_json(t) from (SELECT %s FROM %s where %s = %s) t'
        , v_usuarios, v_tabla, v_nombre_id, p_table_id)
        INTO v_json;

    FOR v_record_names_usuarios_chat IN (SELECT unnest(string_to_array(trim(v_usuarios::text, '()'), ',')) AS id)
        LOOP
            v_id_usuario_chat := v_json ->> v_record_names_usuarios_chat.id;
            --RAISE EXCEPTION '%', v_json ->> v_record_names_usuarios_chat.id;



            INSERT INTO param.tchat_usuario(usuario_desc,
                                            id_chat,
                                            id_usuario,
                                            estado_reg,
                                            id_usuario_ai,
                                            usuario_ai,
                                            fecha_reg,
                                            id_usuario_reg,
                                            id_usuario_mod,
                                            fecha_mod)
            VALUES (v_record_names_usuarios_chat.id::varchar,
                    v_id_chat,
                    v_id_usuario_chat,
                    'activo',
                    v_parametros._id_usuario_ai,
                    v_parametros._nombre_usuario_ai,
                    now(),
                    p_id_usuario,
                    NULL,
                    NULL)
            RETURNING id_chat_usuario INTO v_id_chat_usuario;


        END LOOP;


    RETURN v_id_chat;


EXCEPTION
    WHEN OTHERS THEN
        v_resp = '';
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', 'f_insert_chat');
        RAISE EXCEPTION '%', v_resp;


END;
$BODY$
    LANGUAGE plpgsql VOLATILE;