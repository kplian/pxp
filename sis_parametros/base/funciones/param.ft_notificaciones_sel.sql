CREATE OR REPLACE FUNCTION "param"."ft_notificaciones_sel"(
    p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
    RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Notificaciones Móviles
 FUNCION:         param.ft_notificaciones_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tnotificaciones'
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

    v_consulta       VARCHAR;
    v_parametros     RECORD;
    v_nombre_funcion TEXT;
    v_resp           VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_notificaciones_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PARAM_NOTI_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        valvarado    
     #FECHA:        30-03-2021 15:12:35
    ***********************************/

    IF (p_transaccion = 'PARAM_NOTI_SEL') THEN

        BEGIN
            --Sentencia de la consulta
            v_consulta := 'SELECT DISTINCT (noti.id),
                           noti.estado_reg,
                           noti.id_funcionario_emisor,
                           noti.id_funcionario_receptor,
                           noti.id_proceso_wf,
                           noti.id_estado_wf,
                           noti.modulo,
                           noti.esquema,
                           noti.id_usuario_reg,
                           noti.fecha_reg,
                           noti.id_usuario_ai,
                           noti.usuario_ai,
                           noti.id_usuario_mod,
                           noti.fecha_mod,
                           usu1.cuenta as                 usr_reg,
                           usu2.cuenta as                 usr_mod,
                           noti.enviado,
                           noti.title,
                           noti.body,
                           noti.id_registro,
                           fun_emisor.desc_funcionario1   desc_fun_emisor,
                           fun_receptor.desc_funcionario1 desc_fun_receptor,
                           noti.nombre_vista
                        FROM param.tnotificaciones noti
                            JOIN segu.tusuario usu1 ON usu1.id_usuario = noti.id_usuario_reg
                             LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = noti.id_usuario_mod
                             LEFT JOIN param.tfuncionario_dispositivo fundisp on fundisp.id_funcionario = noti.id_funcionario_receptor
                             LEFT JOIN orga.vfuncionario_cargo fun_emisor on fun_emisor.id_funcionario = noti.id_funcionario_emisor
                             JOIN orga.vfuncionario_cargo fun_receptor on fun_receptor.id_funcionario = noti.id_funcionario_receptor
                        WHERE  ';

            --Definicion de la respuesta
            v_consulta := v_consulta || v_parametros.filtro;
            v_consulta := v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion ||
                          ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;

        /*********************************
         #TRANSACCION:  'PARAM_NOTI_CONT'
         #DESCRIPCION:    Conteo de registros
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:12:35
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_NOTI_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta := 'SELECT COUNT(id)
                         FROM param.tnotificaciones noti
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = noti.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = noti.id_usuario_mod
                         WHERE ';

            --Definicion de la respuesta            
            v_consulta := v_consulta || v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
        /*********************************
         #TRANSACCION:  'PARAM_NOTILISTAR_SEL'
         #DESCRIPCION:    Consulta de datos
         #AUTOR:        valvarado
         #FECHA:        30-03-2021 15:12:35
        ***********************************/

    ELSIF (p_transaccion = 'PARAM_NOTILISTAR_SEL') THEN

        BEGIN

            --Sentencia de la consulta
            v_consulta := 'SELECT DISTINCT(noti.id),
                                    noti.estado_reg,
                                    noti.id_funcionario_emisor,
                                    noti.id_funcionario_receptor,
                                    noti.id_proceso_wf,
                                    noti.id_estado_wf,
                                    noti.modulo,
                                    noti.esquema,
                                    noti.id_usuario_reg,
                                    noti.fecha_reg,
                                    noti.id_usuario_ai,
                                    noti.usuario_ai,
                                    noti.id_usuario_mod,
                                    noti.fecha_mod,
                                    usu1.cuenta as usr_reg,
                                    usu2.cuenta as usr_mod,
                                    noti.enviado,
                                    fundisp.token,
                                    noti.title,
                                    noti.body,
                                    noti.id_registro,
                                   fun_emisor.desc_funcionario1   desc_fun_emisor,
                                   fun_receptor.desc_funcionario1 desc_fun_receptor,
                                   noti.nombre_vista
                           FROM param.tnotificaciones noti
                             JOIN segu.tusuario usu1 ON usu1.id_usuario = noti.id_usuario_reg
                             LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = noti.id_usuario_mod
                             JOIN param.tfuncionario_dispositivo fundisp on fundisp.id_funcionario = noti.id_funcionario_receptor
                             LEFT JOIN orga.vfuncionario_cargo fun_emisor on fun_emisor.id_funcionario = noti.id_funcionario_emisor
                             JOIN orga.vfuncionario_cargo fun_receptor on fun_receptor.id_funcionario = noti.id_funcionario_receptor
                           WHERE ';

            --Definicion de la respuesta
            v_consulta := v_consulta || v_parametros.filtro;
            v_consulta := v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
    ELSE

        RAISE EXCEPTION 'Transaccion inexistente';

    END IF;

EXCEPTION

    WHEN OTHERS THEN
        v_resp = '';
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
        RAISE EXCEPTION '%',v_resp;
END;
$BODY$
    LANGUAGE 'plpgsql' VOLATILE
                       COST 100;
ALTER FUNCTION "param"."ft_notificaciones_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
