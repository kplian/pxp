CREATE OR REPLACE FUNCTION "param"."ft_mensaje_ime" (    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_mensaje_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tmensaje'
 AUTOR:          (favio)
 FECHA:            15-06-2020 21:17:46
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                15-06-2020 21:17:46    favio             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_mensaje    INTEGER;
    v_id_tabla    INTEGER;
    v_rec_usuarios_chat         RECORD;
    v_usuarios varchar;
    v_url varchar;
    v_id_alarma				   integer;
    v_id_chat				   integer;
    v_users				       record;
    v_phone_obfuscation        varchar;
    v_message                  varchar;
    v_evento                   varchar;
    v_desc_persona                   varchar;

BEGIN

    v_nombre_funcion = 'param.ft_mensaje_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_MEN_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        favio    
     #FECHA:        15-06-2020 21:17:46
    ***********************************/

    IF (p_transaccion='PM_MEN_INS') THEN
                    
        BEGIN

            SELECT string_agg(chat_usuario.id_usuario::text, ',')::varchar,
                   replace(tc.url_notificacion, ':id', chat.id_tabla::varchar) ::varchar as url,
                   chat.id_chat, tc.phone_obfuscation, tc.tipo_chat || '_' || tc.nombre_id || '_' || chat.id_chat || '_' || chat.id_chat as evento
            INTO v_usuarios, v_url , v_id_chat, v_phone_obfuscation, v_evento
            FROM param.tchat_usuario chat_usuario
                     INNER JOIN param.tchat chat on chat.id_chat = chat_usuario.id_chat
                     INNER JOIN param.ttipo_chat tc on tc.id_tipo_chat = chat.id_tipo_chat
            WHERE chat_usuario.id_chat = v_parametros.id_chat and id_usuario != p_id_usuario
            GROUP BY chat.id_tabla, url, chat.id_chat, tc.phone_obfuscation, evento;

            IF v_phone_obfuscation = 'Y' THEN
                v_message:= param.f_obfuscation_phone(v_parametros.mensaje);
            ELSE
                v_message := v_parametros.mensaje;
            END IF;

            --Sentencia de la insercion
            INSERT INTO param.tmensaje(
            id_usuario_from,
            id_usuario_to,
            id_chat,
            estado_reg,
            mensaje,
            id_usuario_ai,
            id_usuario_reg,
            fecha_reg,
            usuario_ai,
            fecha_mod,
            id_usuario_mod
              ) VALUES (
            p_id_usuario,
            null,
            v_parametros.id_chat,
            'activo',
            v_message,
            v_parametros._id_usuario_ai,
            p_id_usuario,
            now(),
            v_parametros._nombre_usuario_ai,
            null,
            null            
            ) RETURNING id_mensaje into v_id_mensaje;

            SELECT id_tabla
            INTO v_id_tabla
            FROM param.tchat
            WHERE id_chat = v_parametros.id_chat;






            -- added alarm for users to sending the message
            FOR v_users IN (SELECT id_usuario as id_usuario_to
                        FROM param.tchat_usuario
                        WHERE id_chat = v_id_chat
                        AND id_usuario != p_id_usuario)
                    LOOP
                    v_id_alarma :=  param.f_inserta_alarma_citas(v_users.id_usuario_to, 'Chat', v_parametros.mensaje, 'mail', v_url, now()::date , p_id_usuario);

            end loop;


            SELECT desc_persona::varchar
            into v_desc_persona
            FROM segu.vusuario
            WHERE id_usuario = p_id_usuario;


            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mensaje almacenado(a) con exito (id_mensaje'||v_id_mensaje||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mensaje',v_id_mensaje::varchar);

            --websockets chat
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_chat_id_from',p_id_usuario::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_chat_from',v_desc_persona::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_chat_message',v_message::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_chat_event',v_evento::varchar);

            --websockets notifications
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_notifications',v_usuarios::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_notifications_message','Tienes un nuevo mensaje: '||v_message::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'__ws_notifications_url',v_url::varchar);


            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_MEN_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        favio    
     #FECHA:        15-06-2020 21:17:46
    ***********************************/

    ELSIF (p_transaccion='PM_MEN_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tmensaje SET
            id_usuario_from = v_parametros.id_usuario_from,
            id_usuario_to = v_parametros.id_usuario_to,
            id_chat = v_parametros.id_chat,
            mensaje = v_parametros.mensaje,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_mensaje=v_parametros.id_mensaje;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mensaje modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mensaje',v_parametros.id_mensaje::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_MEN_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        favio    
     #FECHA:        15-06-2020 21:17:46
    ***********************************/

    ELSIF (p_transaccion='PM_MEN_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tmensaje
            WHERE id_mensaje=v_parametros.id_mensaje;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Mensaje eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_mensaje',v_parametros.id_mensaje::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_mensaje_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
