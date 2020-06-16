CREATE OR REPLACE FUNCTION "param"."ft_chat_sel"(    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_chat_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tchat'
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

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_chat_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_CHAT_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:50:02
    ***********************************/

    IF (p_transaccion='PM_CHAT_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        chat.id_chat,
                        chat.descripcion,
                        chat.id_tipo_chat,
                        chat.id_tabla,
                        chat.estado_reg,
                        chat.id_usuario_ai,
                        chat.usuario_ai,
                        chat.fecha_reg,
                        chat.id_usuario_reg,
                        chat.id_usuario_mod,
                        chat.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod    
                        FROM param.tchat chat
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = chat.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = chat.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_CHAT_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin    
     #FECHA:        05-06-2020 16:50:02
    ***********************************/

    ELSIF (p_transaccion='PM_CHAT_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_chat)
                         FROM param.tchat chat
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = chat.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = chat.id_usuario_mod
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
ALTER FUNCTION "param"."ft_chat_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
