--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_import_ttipo_estado (
    p_accion varchar,
    p_codigo varchar,
    p_codigo_tipo_proceso varchar,
    p_nombre_estado varchar,
    p_inicio varchar,
    p_disparador varchar,
    p_fin varchar,
    p_tipo_asignacion varchar,
    p_nombre_func_list varchar,
    p_depto_asignacion varchar,
    p_nombre_depto_func_list varchar,
    p_obs text,
    p_alerta varchar,
    p_pedir_obs varchar,
    p_descripcion varchar,
    p_plantilla_mensaje varchar,
    p_plantilla_mensaje_asunto varchar,
    p_cargo_depto text,
    p_mobile varchar,
    p_funcion_inicial varchar,
    p_funcion_regreso varchar,
    p_acceso_directo_alerta varchar,
    p_nombre_clase_alerta varchar,
    p_tipo_noti varchar,
    p_titulo_alerta varchar,
    p_parametros_ad varchar,
    p_codigo_estado_anterior varchar,
    p_admite_obs varchar default 'no',
    p_etapa varchar default null,
    p_grupo_doc varchar default null,
    p_icono varchar default null,
    p_dias_alerta integer default null,
    p_sla varchar default 'no',
    p_dias_limite integer default null,
    p_dias_envio varchar default null,
    p_hrs_envio varchar default null
)
    RETURNS varchar AS
$body$
DECLARE
    v_id_tipo_proceso			integer;
    v_id_tipo_estado			integer;
    v_cargo_depto				varchar[];
    v_id_tipo_estado_anterior	integer;
BEGIN

    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp
    where tp.codigo = p_codigo_tipo_proceso ;

    select id_tipo_estado into v_id_tipo_estado_anterior
    from wf.ttipo_estado te
    where te.codigo = p_codigo_estado_anterior ;

    select te.id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te
             inner join wf.ttipo_proceso tp
                        on tp.id_tipo_proceso = te.id_tipo_proceso
    where te.codigo = p_codigo
      and tp.codigo = p_codigo_tipo_proceso;


    if (p_cargo_depto is not null) then
        v_cargo_depto = string_to_array(p_cargo_depto,',')::varchar[];
    end if;

    ALTER TABLE wf.ttabla DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
        update wf.ttipo_estado set estado_reg = 'inactivo',modificado = 1
        where id_tipo_estado = v_id_tipo_estado;
    else
        if (v_id_tipo_estado is null)then
            INSERT INTO wf.ttipo_estado
            (
                id_usuario_reg,
                id_tipo_proceso,
                codigo,
                nombre_estado,
                inicio,
                disparador,
                fin,
                tipo_asignacion,
                nombre_func_list,
                depto_asignacion,
                nombre_depto_func_list,
                obs,
                alerta,
                pedir_obs,
                descripcion,
                plantilla_mensaje,
                plantilla_mensaje_asunto,
                cargo_depto,
                mobile,
                funcion_inicial,
                funcion_regreso,
                acceso_directo_alerta,
                nombre_clase_alerta,
                tipo_noti,
                titulo_alerta,
                parametros_ad,
                modificado,
                id_tipo_estado_anterior,
                admite_obs,
                etapa,
                grupo_doc,
                icono,
                dias_alerta,
                sla,
                dias_limite,
                dias_envio,
                hrs_envio
            )
            VALUES (
                       1,
                       v_id_tipo_proceso,
                       p_codigo,
                       p_nombre_estado,
                       p_inicio,
                       p_disparador,
                       p_fin,
                       p_tipo_asignacion,
                       p_nombre_func_list,
                       p_depto_asignacion,
                       p_nombre_depto_func_list,
                       p_obs,
                       p_alerta,
                       p_pedir_obs,
                       p_descripcion,
                       p_plantilla_mensaje,
                       p_plantilla_mensaje_asunto,
                       v_cargo_depto,
                       p_mobile,
                       p_funcion_inicial,
                       p_funcion_regreso,
                       p_acceso_directo_alerta,
                       p_nombre_clase_alerta,
                       p_tipo_noti,
                       p_titulo_alerta,
                       p_parametros_ad,
                       1,
                       v_id_tipo_estado_anterior,
                       p_admite_obs,
                       p_etapa,
                       p_grupo_doc,
                       p_icono,
                       p_dias_alerta,
                       p_sla,
                       p_dias_limite,
                       p_dias_envio,
                       p_hrs_envio
                   );
        else
            UPDATE wf.ttipo_estado
            SET
                codigo = p_codigo,
                nombre_estado = p_nombre_estado,
                inicio = p_inicio,
                disparador = p_disparador,
                fin = p_fin,
                tipo_asignacion = p_tipo_asignacion,
                nombre_func_list = p_nombre_func_list,
                depto_asignacion = p_depto_asignacion,
                nombre_depto_func_list = p_nombre_depto_func_list,
                obs = p_obs,
                alerta = p_alerta,
                pedir_obs = p_pedir_obs,
                descripcion = p_descripcion,
                plantilla_mensaje = p_plantilla_mensaje,
                plantilla_mensaje_asunto = p_plantilla_mensaje_asunto,
                cargo_depto = v_cargo_depto,
                mobile = p_mobile,
                funcion_inicial = p_funcion_inicial,
                funcion_regreso = p_funcion_regreso,
                acceso_directo_alerta = p_acceso_directo_alerta,
                nombre_clase_alerta = p_nombre_clase_alerta,
                tipo_noti = p_tipo_noti,
                titulo_alerta = p_titulo_alerta,
                parametros_ad = p_parametros_ad,
                modificado = 1 ,
                id_tipo_estado_anterior = v_id_tipo_estado_anterior,
                admite_obs=  p_admite_obs,
                etapa =  p_etapa,
                grupo_doc =  p_grupo_doc,
                icono =  p_icono,
                dias_alerta =  p_dias_alerta,
                sla =  p_sla,
                dias_limite =  p_dias_limite,
                dias_envio =  p_dias_envio,
                hrs_envio =  p_hrs_envio
            WHERE id_tipo_estado = v_id_tipo_estado;
        end if;

    end if;

    ALTER TABLE wf.ttipo_estado ENABLE TRIGGER USER;
    return 'exito';
END;
$body$
    LANGUAGE 'plpgsql'
    VOLATILE
    CALLED ON NULL INPUT
    SECURITY INVOKER
    PARALLEL UNSAFE
    COST 100;