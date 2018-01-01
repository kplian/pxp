CREATE OR REPLACE FUNCTION param.f_get_periodo_gestion (
  p_fecha date,
  p_id_subsistema integer = 0,
  out po_id_periodo integer,
  out po_id_gestion integer,
  out po_id_periodo_subsistema integer
)
RETURNS record AS
$body$
/*
    Autor: RCM
    Fecha: 03/09/2013
    Descripción: Función que devuelve el id_periodo y el id_gestion a partir de una fecha
*/

DECLARE

BEGIN

    --Verifica la fecha recibida
    if p_fecha is null then
        raise exception '*Error al encontrar periodo: la fecha no debe estar vacía.';
    end if;
    
    --Obtiene los datos
    select
    id_periodo, id_gestion
    into po_id_periodo, po_id_gestion
    from param.tperiodo per
    where p_fecha between per.fecha_ini and per.fecha_fin;
    
    if p_id_subsistema != 0 then
        select id_periodo_subsistema
        into po_id_periodo_subsistema
        from param.tperiodo_subsistema
        where id_periodo = po_id_periodo
        and id_subsistema = p_id_subsistema;
    else
        po_id_periodo_subsistema=0;
    end if;
    
    --Verifica que se haya encontrado Periodo y gestion
    if ((po_id_periodo is null or po_id_gestion is null) and p_id_subsistema=0) or ((po_id_periodo is null or po_id_gestion is null or po_id_periodo_subsistema is null) and p_id_subsistema!=0) then
        raise exception 'Período no encontrado para fecha: %',to_char(p_fecha,'dd/mm/yyyy');
    end if;
    
    --Envía la respuesta
    return;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;