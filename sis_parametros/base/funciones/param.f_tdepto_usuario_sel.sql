--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_tdepto_usuario_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.f_tdepto_usuario_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          (mzm)
 FECHA:            24-11-2011 18:26:47
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:    
 AUTOR:            
 FECHA:        
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
                
BEGIN

    v_nombre_funcion = 'param.f_tdepto_usuario_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_DEPUSU_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        mzm    
     #FECHA:        24-11-2011 18:26:47
    ***********************************/

    if(p_transaccion='PM_DEPUSU_SEL')then
                     
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        depusu.id_depto_usuario,
                        depusu.estado_reg,
                        depusu.id_depto,
                        depusu.id_usuario,
                        depusu.id_usuario_reg,
                        depusu.fecha_reg,
                        depusu.id_usuario_mod,
                        depusu.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod   ,
                        person.nombre_completo1 as desc_usuario     ,
                        depusu.cargo,
                        depusu.sw_alerta
                        from param.tdepto_usuario depusu 
                        inner join segu.tusuario usudep on usudep.id_usuario=depusu.id_usuario
                        inner join segu.vpersona person on person.id_persona=usudep.id_persona
                        inner join segu.tusuario usu1 on usu1.id_usuario = depusu.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = depusu.id_usuario_mod
                        where  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            
            if (pxp.f_existe_parametro(p_tabla,'id_depto')) then         
                v_consulta:= v_consulta || ' and depusu.id_depto='||v_parametros.id_depto;
            end if;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                        
        end;

    /*********************************    
     #TRANSACCION:  'PM_DEPUSU_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        mzm    
     #FECHA:        24-11-2011 18:26:47
    ***********************************/

    elsif(p_transaccion='PM_DEPUSU_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_depto_usuario)
                        from param.tdepto_usuario depusu 
                        inner join segu.tusuario usudep on usudep.id_usuario=depusu.id_usuario
                        inner join segu.vpersona person on person.id_persona=usudep.id_persona
                        inner join segu.tusuario usu1 on usu1.id_usuario = depusu.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = depusu.id_usuario_mod
                        where  ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;
            if (pxp.f_existe_parametro(p_tabla,'id_depto')) then         
                v_consulta:= v_consulta || ' and depusu.id_depto='||v_parametros.id_depto;
            end if;
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