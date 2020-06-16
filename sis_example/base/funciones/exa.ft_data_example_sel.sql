CREATE OR REPLACE FUNCTION "exa"."ft_data_example_sel"(
    p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Example
 FUNCION:         exa.ft_data_example_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'exa.tdata_example'
 AUTOR:          (Favio Figueroa)
 FECHA:            12-06-2020 16:37:18
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                12-06-2020 16:37:18     Favio Figueroa             Creacion
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'exa.ft_data_example_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'EXA_TDE_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Favio Figueroa    
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    IF (p_transaccion='EXA_TDE_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        tde.id_data_example,
                        tde.estado_reg,
                        tde.desc_example,
                        tde.usuario_ai,
                        tde.fecha_reg,
                        tde.id_usuario_reg,
                        tde.id_usuario_ai,
                        tde.fecha_mod,
                        tde.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod    
                        FROM exa.tdata_example tde
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = tde.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tde.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'EXA_TDE_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        Favio Figueroa    
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    ELSIF (p_transaccion='EXA_TDE_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_data_example)
                         FROM exa.tdata_example tde
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = tde.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tde.id_usuario_mod
                         WHERE ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
                
    /*********************************    
     #TRANSACCION:  'EXA_TDECHAT_SEL'
     #DESCRIPCION:    query for example of data for chat
     #AUTOR:        Favio Figueroa    
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    ELSIF (p_transaccion='EXA_TDECHAT_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        tde.id_data_example,
                        tde.estado_reg,
                        tde.desc_example,
                        tde.usuario_ai,
                        tde.fecha_reg,
                        tde.id_usuario_reg,
                        tde.id_usuario_ai,
                        tde.fecha_mod,
                        tde.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        chat.id_chat::integer,
                        ttc.id_tipo_chat::integer
                    FROM exa.tdata_example tde
                             JOIN segu.tusuario usu1 ON usu1.id_usuario = tde.id_usuario_reg
                             LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tde.id_usuario_mod
                    LEFT JOIN param.tchat chat on chat.id_tabla = tde.id_data_example
                    LEFT JOIN param.ttipo_chat ttc on ttc.id_tipo_chat = chat.id_tipo_chat and ttc.codigo = ''CHAT_DATA_EXAMPLE''
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'EXA_TDECHAT_CONT'
     #DESCRIPCION:    count for example of data for chat
     #AUTOR:        Favio Figueroa    
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    ELSIF (p_transaccion='EXA_TDECHAT_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_data_example)
                         FROM exa.tdata_example tde
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = tde.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tde.id_usuario_mod
                        LEFT JOIN param.tchat chat on chat.id_tabla = tde.id_data_example
                         LEFT JOIN param.ttipo_chat ttc on ttc.id_tipo_chat = chat.id_tipo_chat and ttc.codigo = ''CHAT_DATA_EXAMPLE''
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
ALTER FUNCTION "exa"."ft_data_example_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
