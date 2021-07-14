CREATE OR REPLACE FUNCTION orga.f_obtener_uo_gerente (
    p_id_usuario integer
)
    RETURNS integer AS
$body$
DECLARE
    v_resp                      varchar;
    v_nombre_funcion			varchar;
    v_id_uo						integer;
BEGIN
    v_nombre_funcion = 'orga.f_obtener_uo_gerente';
    v_id_uo = null;

    select ger.id_uo into v_id_uo
    from segu.vusuario usu
             inner join orga.vfuncionario_persona fp on fp.id_persona = usu.id_persona
             inner join orga.vfuncionario_cargo fc on fc.id_funcionario = fp.id_funcionario
             inner join orga.tuo ger ON ger.id_uo = fc.id_uo -- orga.f_get_uo_gerencia(fc.id_uo, null::integer, null::date)
    where usu.id_usuario = p_id_usuario
      and (fc.fecha_finalizacion is null or fc.fecha_finalizacion >= now()::date)
      and ger.gerencia = 'si';

    return v_id_uo;

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
    PARALLEL UNSAFE
    COST 100;CREATE OR REPLACE FUNCTION orga.f_obtener_uo_gerente (
    p_id_usuario integer
)
    RETURNS integer AS
$body$
DECLARE
    v_resp                      varchar;
    v_nombre_funcion			varchar;
    v_id_uo						integer;
BEGIN
    v_nombre_funcion = 'orga.f_obtener_uo_gerente';
    v_id_uo = null;

    select ger.id_uo into v_id_uo
    from segu.vusuario usu
             inner join orga.vfuncionario_persona fp on fp.id_persona = usu.id_persona
             inner join orga.vfuncionario_cargo fc on fc.id_funcionario = fp.id_funcionario
             inner join orga.tuo ger ON ger.id_uo = fc.id_uo -- orga.f_get_uo_gerencia(fc.id_uo, null::integer, null::date)
    where usu.id_usuario = p_id_usuario
      and (fc.fecha_finalizacion is null or fc.fecha_finalizacion >= now()::date)
      and ger.gerencia = 'si';

    return v_id_uo;

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
    PARALLEL UNSAFE
    COST 100;