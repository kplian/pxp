CREATE OR REPLACE FUNCTION param.ft_concepto_ingas_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_concepto_ingas_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tconcepto_ingas_det'
 AUTOR:          (admin)
 FECHA:            22-07-2019 14:37:28
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                 AUTOR                DESCRIPCION
#39 ETR		          EGS	    		    31/07/2019			Creacion #
 ***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
                
BEGIN

    v_nombre_funcion = 'param.ft_concepto_ingas_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_COIND_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin    
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    if(p_transaccion='PM_COIND_SEL')then
                     
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        coind.id_concepto_ingas_det,
                        coind.estado_reg,
                        coind.nombre,
                        coind.descripcion,
                        coind.id_concepto_ingas,
                        coind.id_usuario_reg,
                        coind.fecha_reg,
                        coind.id_usuario_ai,
                        coind.usuario_ai,
                        coind.id_usuario_mod,
                        coind.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        coind.agrupador,
                        coind.id_concepto_ingas_det_fk,    
                        cid.nombre as desc_agrupador
                        from param.tconcepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        left join param.tconcepto_ingas_det cid on cid.id_concepto_ingas_det = coind.id_concepto_ingas_det_fk
                        where  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            
            if pxp.f_existe_parametro(p_tabla, 'groupBy') THEN
                --raise exception 'groupBy % ',v_parametros.groupBy;
                v_consulta:=v_consulta||' order by ' ||v_parametros.groupBy|| ' ' ||v_parametros.groupDir|| ', ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
             else
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
            end if;
            
            --Devuelve la respuesta
            raise notice 'v_consulta %',v_consulta;
            return v_consulta;
                        
        end;

    /*********************************    
     #TRANSACCION:  'PM_COIND_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin    
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COIND_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(coind.id_concepto_ingas_det)
                        from param.tconcepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        where ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
                    
    else
                         
        raise exception 'Transaccion inexistente';
                             
    end if;
                    
EXCEPTION
                    
    WHEN OTHERS THEN
            v_resp='';
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION param.ft_concepto_ingas_det_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO dbaegutierrez;