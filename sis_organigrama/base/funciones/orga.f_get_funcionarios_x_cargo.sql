CREATE OR REPLACE FUNCTION orga.f_get_funcionarios_x_cargo (
  p_id_cargo integer,
  p_fecha date
)
RETURNS integer [] AS
$body$
DECLARE
  v_id_empleado				integer;
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_mensaje_error         	text;
BEGIN
  v_nombre_funcion = 'orga.f_get_funcionarios_x_cargo';
  select 
     pxp.aggarray (asig.id_funcionario) 
  into 
      v_resp
  from orga.tuo_funcionario asig
  where 
         asig.fecha_asignacion <= p_fecha 
     and coalesce(asig.fecha_finalizacion, p_fecha)>=p_fecha 
     and asig.estado_reg = 'activo' 
     and asig.tipo in ('oficial','funcional')
     and asig.id_cargo = p_id_cargo;
  
  
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