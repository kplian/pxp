CREATE OR REPLACE FUNCTION orga.f_get_funcionarios_con_asignacion_activa (
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
  v_nombre_funcion = 'orga.f_get_empleados_con_asignacion_activa';
  select pxp.list(asig.id_funcionario::text) into v_resp
  from orga.tuo_funcionario asig
  where asig.fecha_asignacion <= p_fecha and coalesce(asig.fecha_finalizacion, p_fecha)>=p_fecha and
  asig.estado_reg = 'activo' and asig.tipo = 'oficial';
  
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
END;
$body$
LANGUAGE 'plpgsql'
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;