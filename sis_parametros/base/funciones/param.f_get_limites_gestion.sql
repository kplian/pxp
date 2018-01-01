CREATE OR REPLACE FUNCTION param.f_get_limites_gestion (
  p_fecha date,
  out po_fecha_ini date,
  out po_fecha_fin date,
  out po_id_gestion integer
)
RETURNS record AS
$body$
/*
  Autor: RAC (KPLIAN)
    Fecha: 14/12/2015
    Descripción: recupera la fecha inicial y fecha final de la gestion segun  la fecha indicada
*/

DECLARE
    v_id_gestion      integer;
    v_nombre_funcion    varchar;
    v_resp        varchar;

BEGIN
     v_nombre_funcion = 'param.f_get_limites_gestion';
  --Verifica la fecha recibida
    if p_fecha is null then
      raise exception '*Error al encontrar periodo: la fecha no debe estar vacía.';
    end if;
    
    
    select 
      p.id_gestion
    into
     po_id_gestion
    from param.tperiodo p
    where p.fecha_ini <=  p_fecha  and p.fecha_fin >= p_fecha;
    
    
    
    select
      min(p.fecha_ini),
      max(p.fecha_fin)
    into
      po_fecha_ini,
      po_fecha_fin
    from param.tperiodo p
    where p.id_gestion = po_id_gestion;
    
    
    --Envía la respuesta
    return;
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