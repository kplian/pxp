CREATE OR REPLACE FUNCTION orga.f_get_haber_basico_a_fecha (
  p_id_escala_salarial integer,
  p_fecha date = now()
)
RETURNS numeric AS
$body$
DECLARE
  v_id_empleado				integer;
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_mensaje_error         	text;
  v_haber_basico			numeric;
BEGIN
  v_nombre_funcion = 'orga.f_get_haber_basico_a_fecha';
  select es.haber_basico into v_haber_basico
  from orga.tescala_salarial es
  where (id_escala_padre = p_id_escala_salarial or id_escala_salarial = p_id_escala_salarial) and 
  ((es.fecha_ini is null and es.estado_reg = 'activo') or 
  (es.fecha_ini is not null  and p_fecha between es.fecha_ini and coalesce(es.fecha_fin,now()::date)));
    
  return v_haber_basico;  
  
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
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;