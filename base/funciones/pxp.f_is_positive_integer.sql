CREATE OR REPLACE FUNCTION pxp.f_is_positive_integer (
  p_value varchar
)
RETURNS boolean AS
$body$
DECLARE
  v_resp 				varchar;
  v_nombre_funcion		varchar;
BEGIN
	v_nombre_funcion = 'pxp.f_is_positive_integer';
  	if (p_value ~ '^[0-9]+$') then
    	return true;
    else
  		return false;
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
IMMUTABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;