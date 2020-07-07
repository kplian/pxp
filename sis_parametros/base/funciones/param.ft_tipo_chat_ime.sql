CREATE OR REPLACE FUNCTION "param"."ft_tipo_chat_ime" (    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_tipo_chat_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_chat'
 AUTOR:          (admin)
 FECHA:            05-06-2020 16:49:24
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                05-06-2020 16:49:24    admin             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_tipo_chat    INTEGER;
    v_id_chat    INTEGER;

BEGIN

    v_nombre_funcion = 'param.ft_tipo_chat_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_TTC_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:49:24
    ***********************************/

    IF (p_transaccion='PM_TTC_INS') THEN
                    
        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.ttipo_chat(
            estado_reg,
            codigo,
            grupo,
            tabla,
            nombre_id,
            tipo_chat,
            nombre,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            id_usuario_ai,
            id_usuario_mod,
            fecha_mod
              ) VALUES (
            'activo',
            v_parametros.codigo,
            v_parametros.grupo,
            v_parametros.tabla,
            v_parametros.nombre_id,
            v_parametros.tipo_chat,
            v_parametros.nombre,
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            v_parametros._id_usuario_ai,
            null,
            null            
            ) RETURNING id_tipo_chat into v_id_tipo_chat;


            -- example for added chat for this table "ttipo_chat" , only for example
           /* INSERT INTO param.tchat(
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
                 'chat for example for table tipo_chat',
                 v_id_tipo_chat,
                 v_id_tipo_chat, --in another case this will be another id of another table
                 'activo',
                 v_parametros._id_usuario_ai,
                 v_parametros._nombre_usuario_ai,
                 now(),
                 p_id_usuario,
                 null,
                 null
             ) RETURNING id_chat into v_id_chat;
*/

            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Chat almacenado(a) con exito (id_tipo_chat'||v_id_tipo_chat||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_chat',v_id_tipo_chat::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_TTC_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:49:24
    ***********************************/

    ELSIF (p_transaccion='PM_TTC_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.ttipo_chat SET
            codigo = v_parametros.codigo,
            grupo = v_parametros.grupo,
            tabla = v_parametros.tabla,
            nombre_id = v_parametros.nombre_id,
            tipo_chat = v_parametros.tipo_chat,
            nombre = v_parametros.nombre,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_tipo_chat=v_parametros.id_tipo_chat;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Chat modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_chat',v_parametros.id_tipo_chat::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_TTC_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:49:24
    ***********************************/

    ELSIF (p_transaccion='PM_TTC_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.ttipo_chat
            WHERE id_tipo_chat=v_parametros.id_tipo_chat;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Chat eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_chat',v_parametros.id_tipo_chat::varchar);
              
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
ALTER FUNCTION "param"."ft_tipo_chat_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
