CREATE OR REPLACE FUNCTION "param"."ft_mensaje_sel"(
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_mensaje_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tmensaje'
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

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_mensaje_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_MEN_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        favio
     #FECHA:        15-06-2020 21:17:46
    ***********************************/

    IF (p_transaccion='PM_MEN_SEL') THEN

        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        men.id_mensaje,
                        men.id_usuario_from,
                        men.id_usuario_to,
                        men.id_chat,
                        men.estado_reg,
                        men.mensaje,
                        men.id_usuario_ai,
                        men.id_usuario_reg,
                        men.fecha_reg,
                        men.usuario_ai,
                        men.fecha_mod,
                        men.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        coalesce(tu.alias, vp.nombre_completo2::varchar)::text as user_name_from
                        FROM param.tmensaje men
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = men.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = men.id_usuario_mod
                        INNER JOIN segu.tusuario tu on tu.id_usuario = men.id_usuario_from
                        INNER JOIN segu.vpersona2 vp on vp.id_persona = tu.id_persona
                        WHERE  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;

    /*********************************
     #TRANSACCION:  'PM_MEN_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        favio
     #FECHA:        15-06-2020 21:17:46
    ***********************************/

    ELSIF (p_transaccion='PM_MEN_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_mensaje)
                         FROM param.tmensaje men
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = men.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = men.id_usuario_mod
                         INNER JOIN segu.tusuario tu on tu.id_usuario = men.id_usuario_from
                         INNER JOIN segu.vpersona2 vp on vp.id_persona = tu.id_persona
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
ALTER FUNCTION "param"."ft_mensaje_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
