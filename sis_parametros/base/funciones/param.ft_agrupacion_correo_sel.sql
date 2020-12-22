--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_agrupacion_correo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_agrupacion_correo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tagrupacion_correo'
 AUTOR:          (egutierrez)
 FECHA:            26-11-2020 15:27:53
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:27:53    egutierrez             Creacion
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_agrupacion_correo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_COR_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:27:53
    ***********************************/

    IF (p_transaccion='PM_COR_SEL') THEN

        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        cor.id_agrupacion_correo,
                        cor.estado_reg,
                        cor.id_funcionario,
                        cor.correo,
                        cor.id_usuario_reg,
                        cor.fecha_reg,
                        cor.id_usuario_ai,
                        cor.usuario_ai,
                        cor.id_usuario_mod,
                        cor.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        cor.id_tipo_envio_correo,
                        fun.desc_funcionario1::varchar,
                        f.email_empresa,
                        (COALESCE(dep.codigo,'''')||'' '' ||dep.nombre)::varchar as desc_depto,
                        cor.id_depto,
                        cor.cargo::varchar
                        FROM param.tagrupacion_correo cor
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = cor.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cor.id_usuario_mod
                        left join orga.vfuncionario fun on fun.id_funcionario = cor.id_funcionario
                        left join orga.tfuncionario f on f.id_funcionario = cor.id_funcionario
                        left join param.tdepto dep on dep.id_depto = cor.id_depto
                        WHERE  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;

    /*********************************
     #TRANSACCION:  'PM_COR_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:27:53
    ***********************************/

    ELSIF (p_transaccion='PM_COR_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_agrupacion_correo)
                         FROM param.tagrupacion_correo cor
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = cor.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cor.id_usuario_mod
                         left join orga.vfuncionario fun on fun.id_funcionario = cor.id_funcionario
                         left join orga.tfuncionario f on f.id_funcionario = cor.id_funcionario
                         left join param.tdepto dep on dep.id_depto = cor.id_depto
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