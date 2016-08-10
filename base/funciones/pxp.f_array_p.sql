CREATE OR REPLACE FUNCTION pxp.f_array_p (
  p_array character varying[]
)
RETURNS varchar
AS 
$body$
DECLARE

	i integer;
    j integer;

BEGIN
--j=array_length(p_array);
 for i in 1..array_upper(p_array,1) loop
 	raise notice '%', p_array[i];
 end loop;
return 'bien';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_array_ubicar_clave (OID = 304218) : 
--
