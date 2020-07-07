--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_grupo_idioma_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_grupo_idioma_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tgrupo_idioma'
 AUTOR:          (RAC)
 FECHA:            21-04-2020 02:29:46
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133               21-04-2020 02:29:46    RAC             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_consulta            VARCHAR;
    v_parametros          RECORD;
    v_nombre_funcion      TEXT;
    v_resp                VARCHAR;
                
BEGIN

    v_nombre_funcion = 'param.ft_grupo_idioma_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_GRI_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/

    IF (p_transaccion='PM_GRI_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                        gri.id_grupo_idioma,
                        gri.codigo,
                        gri.nombre,
                        gri.tipo,
                        gri.estado_reg,
                        gri.nombre_tabla,
                        gri.id_usuario_ai,
                        gri.id_usuario_reg,
                        gri.usuario_ai,
                        gri.fecha_reg,
                        gri.id_usuario_mod,
                        gri.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        gri.columna_llave,
                        gri.columna_texto_defecto  
                        FROM param.tgrupo_idioma gri
                        JOIN segu.tusuario usu1 on usu1.id_usuario = gri.id_usuario_reg
                        LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = gri.id_usuario_mod
                        WHERE  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            RETURN v_consulta;
                        
        END;

    /*********************************    
     #TRANSACCION:  'PM_GRI_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/

    ELSIF (p_transaccion='PM_GRI_CONT') THEN

        BEGIN
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT COUNT(id_grupo_idioma)
                         FROM param.tgrupo_idioma gri
                         JOIN segu.tusuario usu1 on usu1.id_usuario = gri.id_usuario_reg
                         LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = gri.id_usuario_mod
                         WHERE ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            RETURN v_consulta;

        END;
    
    /*********************************
 	#TRANSACCION:  'PM_EXPGRUPIDI_SEL'
 	#DESCRIPCION:	Listado de los datos del grupo seleccionado para exportar
 	#AUTOR:		    RAC
 	#FECHA:		    14-05-2020
	***********************************/
    elsif(p_transaccion='PM_EXPGRUPIDI_SEL')then
		 BEGIN

               v_consulta:='SELECT
                            ''grupo_idioma''::varchar as tipo_reg,
                            gri.codigo,
                            gri.nombre,
                            gri.tipo,
                            gri.estado_reg,
                            gri.nombre_tabla,
                            gri.columna_llave,
                            gri.columna_texto_defecto                             
                            FROM param.tgrupo_idioma gri
                            WHERE gri.id_grupo_idioma =  '|| v_parametros.id_grupo_idioma;

				
               v_consulta = v_consulta || ' order by gri.id_grupo_idioma ASC';	
                                                                       
               return v_consulta;


         END;
    
    /*********************************    
     #TRANSACCION:  'PM_GRICMN_SEL'
     #DESCRIPCION:   Consulta los grupos de tupo comun (no allmacenados apra genrar archivos de traduccion),se usa sin paginacion
     #AUTOR:         RAC    
     #FECHA:         21-04-2020 02:29:46
    ***********************************/

    ELSEIF (p_transaccion='PM_GRICMN_SEL') THEN
                     
        BEGIN
            --Sentencia de la consulta
            v_consulta:='SELECT
                          gri.id_grupo_idioma,
                          gri.codigo,
                          gri.nombre,
                          gri.tipo
                        FROM param.tgrupo_idioma gri
                        WHERE  gri.estado_reg = ''activo'' 
                          AND  gri.tipo = ''comun'' ';
            

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