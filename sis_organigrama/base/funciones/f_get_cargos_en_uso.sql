CREATE OR REPLACE FUNCTION orga.f_get_cargos_en_uso (
  p_id_uo integer,
  p_fecha date
)
RETURNS varchar AS
$body$
DECLARE
  v_id_empleado				integer;
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_mensaje_error         	text;
BEGIN
  v_nombre_funcion = 'orga.f_get_cargos_en_uso';
  select pxp.list(asig.id_cargo::text) into v_resp
  from orga.tuo_funcionario asig
  where asig.fecha_asignacion <= p_fecha and coalesce(asig.fecha_finalizacion, p_fecha)>=p_fecha and
  asig.estado_reg = 'activo' and asig.tipo = 'oficial' and asig.id_uo = p_id_uo;
  
  if (v_resp is null or v_resp = '') then
  		v_resp = '-1';
  end if;
  return v_resp::varchar;
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