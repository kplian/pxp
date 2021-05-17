CREATE OR REPLACE FUNCTION "param"."ft_funcionario_dispositivo_ime"(
    p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
    RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Notificaciones Móviles
 FUNCION:         param.ft_funcionario_dispositivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfuncionario_dispositivo'
 AUTOR:          (valvarado)
 FECHA:            30-03-2021 15:11:51
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                30-03-2021 15:11:51    valvarado             Creacion    
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

BEGIN

    v_nombre_funcion = 'param.ft_funcionario_dispositivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PARAM_FUNDISP_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        valvarado    
     #FECHA:        30-03-2021 15:11:51
    ***********************************/

    IF (p_transaccion = 'PARAM_FUNDISP_INS') THEN

        BEGIN
            --Sentencia de la insercion
            if (not exists(select fnd.id_funcionario
                           from param.tfuncionario_dispositivo fnd
                           where fnd.id_funcionario = v_parametros.id_funcionario)) then
                INSERT INTO param.tfuncionario_dispositivo(estado_reg,
                                                           id_funcionario,
                                                           token,
                                                           id_usuario_reg,
                                                           fecha_reg,
                                                           id_usuario_ai,
                                                           usuario_ai,
                                                           id_usuario_mod,
                                                           fecha_mod)
                VALUES ('activo',
                        v_parametros.id_funcionario,
                        v_parametros.token,
                        p_id_usuario,
                        now(),
                        v_parametros._id_usuario_ai,
                        v_parametros._nombre_usuario_ai,
                        null,
                        null)
                RETURNING id into v_id;
                --Definicion de la respuesta
                v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                            'Dispositivos almacenado(a) con exito (id' || v_id || ')');
            else
                update param.tfuncionario_dispositivo
                set token = v_parametros.token
                where id_funcionario = v_parametros.id_funcionario;
                --Definicion de la respuesta
                v_id = v_parametros.id_funcionario;
                v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                            'Dispositivos actualizado con exito (id' || v_parametros.id_funcionario ||
                                            ')');
            end if;


            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_id::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PARAM_FUNDISP_MOD'
         #DESCRIPCION:    Modificacion de registros
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:11:51
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_FUNDISP_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tfuncionario_dispositivo
            SET id_funcionario = v_parametros.id_funcionario,
                token          = v_parametros.token,
                id_usuario_mod = p_id_usuario,
                fecha_mod      = now(),
                id_usuario_ai  = v_parametros._id_usuario_ai,
                usuario_ai     = v_parametros._nombre_usuario_ai
            WHERE id = v_parametros.id;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Dispositivos modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_parametros.id::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

        /*********************************
         #TRANSACCION:  'PARAM_FUNDISP_ELI'
         #DESCRIPCION:    Eliminacion de registros
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:11:51
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_FUNDISP_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE
            FROM param.tfuncionario_dispositivo
            WHERE id = v_parametros.id;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Dispositivos eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp, 'id', v_parametros.id::varchar);

            --Devuelve la respuesta
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
ALTER FUNCTION "param"."ft_funcionario_dispositivo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
