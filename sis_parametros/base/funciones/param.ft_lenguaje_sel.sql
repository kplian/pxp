CREATE OR REPLACE FUNCTION "param"."ft_lenguaje_sel"(    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_lenguaje_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tlenguaje'
 AUTOR:         rac
 FECHA:         21-04-2020 02:04:08
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133                21-04-2020 02:04:08    rac             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_lenguaje_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_LEN_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin    
     #FECHA:        21-04-2020 02:04:08
    ***********************************/

    IF (p_transaccion='PM_LEN_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        len.id_lenguaje,
                        len.codigo,
                        len.nombre,
                        len.defecto,
                        len.estado_reg,
                        len.id_usuario_ai,
                        len.fecha_reg,
                        len.usuario_ai,
                        len.id_usuario_reg,
                        len.id_usuario_mod,
                        len.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod    
                        FROM param.tlenguaje len
                        JOIN segu.tusuario usu1 on usu1.id_usuario = len.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = len.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_LEN_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 02:04:08
    ***********************************/

    ELSIF (p_transaccion='PM_LEN_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_lenguaje)
                         FROM param.tlenguaje len
                         JOIN segu.tusuario usu1 on usu1.id_usuario = len.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = len.id_usuario_mod
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
ALTER FUNCTION "param"."ft_lenguaje_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
