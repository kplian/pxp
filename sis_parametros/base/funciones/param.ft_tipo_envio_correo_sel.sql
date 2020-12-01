--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_tipo_envio_correo_sel (
    p_administrador integer,
    p_id_usuario integer,
    p_tabla varchar,
    p_transaccion varchar
)
    RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_tipo_agrupacion_correo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_envio_correo'
 AUTOR:          (egutierrez)
 FECHA:            26-11-2020 15:26:10
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:26:10    egutierrez             Creacion
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_tipo_envio_correo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_GRC_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:26:10
    ***********************************/

    IF (p_transaccion='PM_GRC_SEL') THEN

        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        grc.id_tipo_envio_correo,
                        grc.estado_reg,
                        grc.codigo,
                        grc.descripcion,
                        grc.dias_envio,
                        grc.dias_consecutivo,
                        grc.habilitado,
                        grc.id_usuario_reg,
                        grc.fecha_reg,
                        grc.id_usuario_ai,
                        grc.usuario_ai,
                        grc.id_usuario_mod,
                        grc.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        grc.dias_vencimiento
                        FROM param.ttipo_envio_correo grc
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = grc.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = grc.id_usuario_mod
                        WHERE  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            RAISE NOTICE 'v_consulta %',v_consulta;
            --Devuelve la respuesta
            RETURN v_consulta;

        END;

        /*********************************
         #TRANSACCION:  'PM_GRC_CONT'
         #DESCRIPCION:    Conteo de registros
         #AUTOR:        egutierrez
         #FECHA:        26-11-2020 15:26:10
        ***********************************/

    ELSIF (p_transaccion='PM_GRC_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(grc.id_tipo_envio_correo)
                         FROM param.ttipo_envio_correo grc
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = grc.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = grc.id_usuario_mod
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
$body$
    LANGUAGE 'plpgsql'
    VOLATILE
    CALLED ON NULL INPUT
    SECURITY INVOKER
    PARALLEL UNSAFE
    COST 100;