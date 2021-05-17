CREATE OR REPLACE FUNCTION "param"."ft_funcionario_dispositivo_sel"(
    p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
    RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Notificaciones Móviles
 FUNCION:         param.ft_funcionario_dispositivo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tfuncionario_dispositivo'
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

    v_consulta       VARCHAR;
    v_parametros     RECORD;
    v_nombre_funcion TEXT;
    v_resp           VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_funcionario_dispositivo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PARAM_FUNDISP_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        valvarado
     #FECHA:        30-03-2021 15:11:51
    ***********************************/

    IF (p_transaccion = 'PARAM_FUNDISP_SEL') THEN

        BEGIN
            --Sentencia de la consulta
            v_consulta := 'SELECT
                        DISTINCT(fundisp.id),
                        fundisp.estado_reg,
                        fundisp.id_funcionario,
                        fundisp.token,
                        fundisp.id_usuario_reg,
                        fundisp.fecha_reg,
                        fundisp.id_usuario_ai,
                        fundisp.usuario_ai,
                        fundisp.id_usuario_mod,
                        fundisp.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        fun.desc_funcionario1
                        FROM param.tfuncionario_dispositivo fundisp
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = fundisp.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = fundisp.id_usuario_mod
                        left join orga.vfuncionario_cargo fun on fun.id_funcionario = fundisp.id_funcionario
                        WHERE  ';

            --Definicion de la respuesta
            v_consulta := v_consulta || v_parametros.filtro;
            v_consulta := v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion ||
                          ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;

        END ;

    /*********************************
     #TRANSACCION:  'PARAM_FUNDISP_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        valvarado
     #FECHA:        30-03-2021 15:11:51
    ***********************************/

    ELSIF (p_transaccion='PARAM_FUNDISP_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id)
                         FROM param.tfuncionario_dispositivo fundisp
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = fundisp.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = fundisp.id_usuario_mod
                         WHERE ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;

    ELSE

        RAISE EXCEPTION 'Transaccion inexistente';

    END IF;

EXCEPTION

    WHEN OTHERS THEN
            v_resp='';
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            RAISE EXCEPTION '%',v_resp;
END;
$BODY$
    LANGUAGE 'plpgsql' VOLATILE
                       COST 100;
ALTER FUNCTION "param"."ft_funcionario_dispositivo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
