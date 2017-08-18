CREATE OR REPLACE FUNCTION orga.f_iniciales_funcionarios (
  p_funcionarios text
)
RETURNS varchar AS
$body$
DECLARE
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_arreglo					varchar[];
  v_iniciales				varchar;
  v_i						integer;
  v_cantidad				integer;



BEGIN
   v_nombre_funcion = 'orga.f_iniciales_funcionarios';

   select regexp_split_to_array(p_funcionarios,E'\\s+')
   into
   v_arreglo;

   v_cantidad = array_length(v_arreglo, 1);

   for v_i in 1..v_cantidad loop
   if v_cantidad = 4 then
   v_iniciales = substring(v_arreglo[v_i-3]from 1 for 1)||''||substring(v_arreglo[v_i-1]from 1 for 1)||''||substring(v_arreglo[v_i]from 1 for 1);
   end if;
   if v_cantidad = 3 then
   v_iniciales = substring(v_arreglo[v_i-2]from 1 for 1)||''||substring(v_arreglo[v_i-1]from 1 for 1)||''||substring(v_arreglo[v_i]from 1 for 1);
   end if;
    if v_cantidad = 2 then
   v_iniciales = substring(v_arreglo[v_i-1]from 1 for 1)||''||substring(v_arreglo[v_i]from 1 for 1);
   end if;
   end loop;
   RETURN v_iniciales;

EXCEPTION
WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;