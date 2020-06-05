CREATE OR REPLACE FUNCTION "param"."ft_chat_ime" (    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_chat_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tchat'
 AUTOR:          (admin)
 FECHA:            05-06-2020 16:50:02
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                05-06-2020 16:50:02    admin             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_chat    INTEGER;
                
BEGIN

    v_nombre_funcion = 'param.ft_chat_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_CHAT_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:50:02
    ***********************************/

    IF (p_transaccion='PM_CHAT_INS') THEN
                    
        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.tchat(
            descripcion,
            id_tipo_chat,
            id_tabla,
            estado_reg,
            id_usuario_ai,
            usuario_ai,
            fecha_reg,
            id_usuario_reg,
            id_usuario_mod,
            fecha_mod
              ) VALUES (
            v_parametros.descripcion,
            v_parametros.id_tipo_chat,
            v_parametros.id_tabla,
            'activo',
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            now(),
            p_id_usuario,
            null,
            null            
            ) RETURNING id_chat into v_id_chat;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','chat almacenado(a) con exito (id_chat'||v_id_chat||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_chat',v_id_chat::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_CHAT_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:50:02
    ***********************************/

    ELSIF (p_transaccion='PM_CHAT_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tchat SET
            descripcion = v_parametros.descripcion,
            id_tipo_chat = v_parametros.id_tipo_chat,
            id_tabla = v_parametros.id_tabla,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_chat=v_parametros.id_chat;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','chat modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_chat',v_parametros.id_chat::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_CHAT_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:50:02
    ***********************************/

    ELSIF (p_transaccion='PM_CHAT_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tchat
            WHERE id_chat=v_parametros.id_chat;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','chat eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_chat',v_parametros.id_chat::varchar);
              
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
ALTER FUNCTION "param"."ft_chat_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
