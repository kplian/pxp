CREATE OR REPLACE FUNCTION pxp.f_get_dias_habiles (
  p_fecha_ini date,
  p_fecha_fin date,
  p_id_lugar integer = null::integer
)
RETURNS integer AS
$body$
/**************************************************************************
 SISTEMA:   	PXP
 FUNCION:     	pxp.f_get_dias_habiles
 DESCRIPCION:   Devuelve la cantidad de días hábiles (sin fines de semana ni feriados) entre dos fechas
 AUTOR:      	RCM
 FECHA:         26/10/2017
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/
DECLARE

	v_nombre_funcion           text;
	v_resp                     varchar;
    v_dias_habiles		       integer;
    v_dias_feriados            integer;
    v_dias_feriados_x_lugar    integer;
    v_gestion                  integer;
  
BEGIN

	v_nombre_funcion = 'pxp.f_get_dias_habiles';
    
    --Obtiene la cantidad de días hábiles incluyendo feriados
    select
    count(1) as dias_habiles
    into v_dias_habiles
    from generate_series(p_fecha_ini, p_fecha_fin, interval  '1 day') dias
    where extract('ISODOW' from dias) < 6;

    --Obtención de gestión de la fecha fin
    v_gestion = extract('year' from p_fecha_fin);
    
    --Se obtiene los feriados globales en el rango de fechas
    select 
    count(1)
    into v_dias_feriados
    from param.tferiado
    where id_lugar is null
    and case tipo
            when 'permanente' then
                (extract('day' from fecha)::varchar||'-'||extract('month' from fecha)::varchar||'-'||v_gestion::varchar)::date between p_fecha_ini and p_fecha_fin
            else fecha between p_fecha_ini and p_fecha_fin
        end;

    --Se obtiene los feriados por el lugar enviado (p_id_lugar) en el rango de fechas si corresponde
    select 
    count(1)
    into v_dias_feriados_x_lugar
    from param.tferiado
    where id_lugar = p_id_lugar
    and case tipo
            when 'permanente' then
                (extract('day' from fecha)::varchar||'-'||extract('month' from fecha)::varchar||'-'||v_gestion::varchar)::date between p_fecha_ini and p_fecha_fin
            else fecha between p_fecha_ini and p_fecha_fin
        end;
    
    --Devuelve la diferencia
    raise notice 'Días feriados nacionales: %, días feriados locales: %',coalesce(v_dias_feriados,0),coalesce(v_dias_feriados_x_lugar,0);
    return v_dias_habiles - coalesce(v_dias_feriados,0) - coalesce(v_dias_feriados_x_lugar,0);

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
SECURITY INVOKER;