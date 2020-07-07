CREATE OR REPLACE FUNCTION "param"."ft_tipo_chat_sel"(    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_tipo_chat_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_chat'
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

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_tipo_chat_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_TTC_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:49:24
    ***********************************/

    IF (p_transaccion='PM_TTC_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        ttc.id_tipo_chat,
                        ttc.estado_reg,
                        ttc.codigo,
                        ttc.grupo,
                        ttc.tabla,
                        ttc.nombre_id,
                        ttc.tipo_chat,
                        ttc.nombre,
                        ttc.id_usuario_reg,
                        ttc.usuario_ai,
                        ttc.fecha_reg,
                        ttc.id_usuario_ai,
                        ttc.id_usuario_mod,
                        ttc.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod    
                        FROM param.ttipo_chat ttc
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = ttc.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = ttc.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_TTC_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:49:24
    ***********************************/

    ELSIF (p_transaccion='PM_TTC_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_tipo_chat)
                         FROM param.ttipo_chat ttc
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = ttc.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = ttc.id_usuario_mod
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
ALTER FUNCTION "param"."ft_tipo_chat_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
