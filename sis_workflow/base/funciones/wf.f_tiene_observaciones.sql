CREATE OR REPLACE FUNCTION wf.f_tiene_observaciones (
  p_id_estado_wf integer
)
RETURNS integer AS
$body$
DECLARE
  v_resp			varchar;
  v_nombre_funcion	varchar;
BEGIN
  v_nombre_funcion = 'wf.f_tiene_observaciones';
  if (exists (select 1 from wf.tobs 
  				where id_estado_wf = p_id_estado_wf and estado_reg = 'activo' 
                	and estado = 'abierto')) then
  	return 1;
  else
  	return 0;
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