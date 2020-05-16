--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_palabra_clave_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_palabra_clave_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tpalabra_clave'
 AUTOR:          (ADMIN)
 FECHA:            21-04-2020 02:54:58
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133               21-04-2020 02:54:58    ADMIN             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_palabra_clave_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PLC_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        ADMIN    
     #FECHA:        21-04-2020 02:54:58
    ***********************************/

    IF (p_transaccion='PM_PLC_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        plc.id_palabra_clave,                        
                        plc.estado_reg,
                        plc.codigo,
                        plc.default_text,
                        plc.id_grupo_idioma,
                        plc.fecha_reg,
                        plc.usuario_ai,
                        plc.id_usuario_reg,
                        plc.id_usuario_ai,
                        plc.fecha_mod,
                        plc.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        (gri.codigo|| '' ''||gri.nombre) as desc_grupo_idioma
                        FROM param.tpalabra_clave plc
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = plc.id_usuario_reg
                        JOIN param.tgrupo_idioma gri ON gri.id_grupo_idioma = plc.id_grupo_idioma 
                        LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = plc.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_PLC_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        ADMIN    
     #FECHA:        21-04-2020 02:54:58
    ***********************************/

    ELSIF (p_transaccion='PM_PLC_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_palabra_clave)
                         FROM param.tpalabra_clave plc
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = plc.id_usuario_reg
                         JOIN param.tgrupo_idioma gri ON gri.id_grupo_idioma = plc.id_grupo_idioma 
                         LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = plc.id_usuario_mod
                         WHERE ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
    
    /*********************************    
     #TRANSACCION:  'PM_EXPPLC_SEL'
     #DESCRIPCION:   istao de datos para exporatacion de configuracion 
     #AUTOR:        RAC    
     #FECHA:        14-05-2020 02:54:58
    ***********************************/

    ELSIF (p_transaccion='PM_EXPPLC_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                         ''palabra_clave''::varchar as tipo_reg,   
                          plc.estado_reg,
                          plc.codigo,
                          plc.default_text,
                          gri.codigo as codigo_grupo_idioma 
                        FROM param.tpalabra_clave plc
                        JOIN param.tgrupo_idioma gri ON gri.id_grupo_idioma = plc.id_grupo_idioma 
                        WHERE gri.id_grupo_idioma =  '|| v_parametros.id_grupo_idioma||'
                        ORDER BY plc.codigo';
            
           
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