CREATE OR REPLACE FUNCTION orga.ft_tipo_cargo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Organigrama
 FUNCION:         orga.ft_tipo_cargo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.ttipo_cargo'
 AUTOR:          (rarteaga)
 FECHA:            15-07-2019 19:39:12
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #30                15-07-2019 19:39:12                                Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.ttipo_cargo'
 #46                05/08/2019              EGS                 Se agrega campo id_contrato
 #52 endeEtr        20/08/2019              EGS                 Se arregla la paginacion en el count
 #70 etr        25/09/2019              	MMV                 Nueva campo factor nocturno
 ***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;

BEGIN

    v_nombre_funcion = 'orga.ft_tipo_cargo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'OR_TCAR_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        rarteaga
     #FECHA:        15-07-2019 19:39:12
    ***********************************/

    if(p_transaccion='OR_TCAR_SEL')then

        begin
            --Sentencia de la consulta
            v_consulta:='select
                        TCAR.id_tipo_cargo,
                        TCAR.estado_reg,
                        TCAR.codigo,
                        TCAR.nombre,
                        TCAR.id_escala_salarial_min,
                        TCAR.id_escala_salarial_max,
                        TCAR.factor_disp,
                        TCAR.obs,
                        TCAR.id_usuario_reg,
                        TCAR.fecha_reg,
                        TCAR.id_usuario_ai,
                        TCAR.usuario_ai,
                        TCAR.id_usuario_mod,
                        TCAR.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        COALESCE(escmin.codigo||''- ''||escmin.nombre||'' (''||escmin.haber_basico||'')'','''')  as desc_escmim ,
                        escmax.codigo||''- ''||escmax.nombre||'' (''||escmax.haber_basico||'')''  as desc_escmax ,
                        TCAR.id_tipo_contrato,--#46
                        tc.nombre as desc_tipo_contrato,  --#46
                        TCAR.factor_nocturno --#70
                        from orga.ttipo_cargo TCAR
                        inner join segu.tusuario usu1 on usu1.id_usuario = TCAR.id_usuario_reg
                        left  join orga.tescala_salarial escmin on escmin.id_escala_salarial = tcar.id_escala_salarial_min
                        inner join orga.tescala_salarial escmax on escmax.id_escala_salarial = tcar.id_escala_salarial_max
                        left  join segu.tusuario usu2 on usu2.id_usuario = TCAR.id_usuario_mod
                        left  join orga.ttipo_contrato tc on tc.id_tipo_contrato = TCAR.id_tipo_contrato
                        where  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice 'v_consulta %',v_consulta;
            --Devuelve la respuesta
            return v_consulta;

        end;

    /*********************************
     #TRANSACCION:  'OR_TCAR_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        rarteaga
     #FECHA:        15-07-2019 19:39:12
    ***********************************/

    elsif(p_transaccion='OR_TCAR_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_tipo_cargo)
                        from orga.ttipo_cargo TCAR
                        inner join segu.tusuario usu1 on usu1.id_usuario = TCAR.id_usuario_reg
                        left join orga.tescala_salarial escmin on escmin.id_escala_salarial = tcar.id_escala_salarial_min --#52
                        inner join orga.tescala_salarial escmax on escmax.id_escala_salarial = tcar.id_escala_salarial_max
                        left join segu.tusuario usu2 on usu2.id_usuario = TCAR.id_usuario_mod
                        left  join orga.ttipo_contrato tc on tc.id_tipo_contrato = TCAR.id_tipo_contrato
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