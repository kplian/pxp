--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_traduccion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_traduccion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttraduccion'
 AUTOR:          (admin)
 FECHA:            21-04-2020 03:41:52
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133                21-04-2020 03:41:52    admin             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_traduccion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_TRA_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin    
     #FECHA:        21-04-2020 03:41:52
    ***********************************/

    IF (p_transaccion='PM_TRA_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        tra.id_traduccion,
                        tra.id_lenguaje,
                        tra.id_palabra_clave,
                        tra.texto,
                        tra.estado_reg,
                        tra.id_usuario_ai,
                        tra.id_usuario_reg,
                        tra.fecha_reg,
                        tra.usuario_ai,
                        tra.fecha_mod,
                        tra.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        len.nombre as desc_lenguaje 
                        FROM param.ttraduccion tra
                        JOIN segu.tusuario usu1 ON usu1.id_usuario = tra.id_usuario_reg
                        JOIN param.tlenguaje len ON len.id_lenguaje = tra.id_lenguaje
                        LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = tra.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_TRA_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 03:41:52
    ***********************************/

    ELSIF (p_transaccion='PM_TRA_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_traduccion)
                         FROM param.ttraduccion tra
                         JOIN segu.tusuario usu1 ON usu1.id_usuario = tra.id_usuario_reg
                         JOIN param.tlenguaje len ON len.id_lenguaje = tra.id_lenguaje
                         LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = tra.id_usuario_mod
                         WHERE ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
        
    /*********************************    
     #TRANSACCION:  'PM_EXPTRA_SEL'
     #DESCRIPCION:   Listao de datos para exporatacion de traducciones 
     #AUTOR:        RAC    
     #FECHA:        14-05-2020 02:54:58
    ***********************************/

    ELSIF (p_transaccion='PM_EXPTRA_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT 
                          ''traduccion''::varchar as tipo_reg,                            
                          tra.texto,
                          tra.estado_reg,
                          len.codigo as codigo_lenguaje,
                          plc.codigo as codigo_palabra_clave,
                          gri.codigo as codigo_grupo
                          FROM param.ttraduccion tra
                          JOIN param.tpalabra_clave plc ON plc.id_palabra_clave = tra.id_palabra_clave
                          JOIN param.tgrupo_idioma gri ON gri.id_grupo_idioma = plc.id_grupo_idioma 
                          JOIN param.tlenguaje len ON len.id_lenguaje = tra.id_lenguaje                     
                          WHERE gri.id_grupo_idioma =  '|| v_parametros.id_grupo_idioma ||'
                          ORDER BY len.codigo, plc.codigo';
                       
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