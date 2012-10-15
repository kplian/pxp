CREATE OR REPLACE FUNCTION pxp.f1 (
)
RETURNS varchar
AS 
$body$
DECLARE
a integer;
v_mensaje_error text;
v_resp varchar[];
v_nombre_funcion varchar;
v_msg varchar;
BEGIN
v_nombre_funcion='pxp.f1';
raise exception 'error forzado';
  a= 5/0;
  return a::varchar;
EXCEPTION
WHEN OTHERS THEN
	v_msg = pxp.f_agrega_clave(v_msg,'mensaje',SQLERRM);	
  	v_msg = pxp.f_agrega_clave(v_msg,'codigo_error',SQLSTATE);
  	v_msg = pxp.f_agrega_clave(v_msg,'procedimientos',v_nombre_funcion);
  	raise exception '%',v_msg; 
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_agrega_clave (OID = 304215) : 
--
