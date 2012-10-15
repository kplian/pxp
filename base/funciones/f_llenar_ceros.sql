CREATE OR REPLACE FUNCTION pxp.f_llenar_ceros (
  numero numeric,
  digitos integer
)
RETURNS text
AS 
$body$
DECLARE
	largo_cad 		integer;
	cadena			text;
BEGIN
    cadena:=text(numero);
    largo_cad:=char_length(cadena);
    while (largo_cad<digitos) loop
        cadena:='0'||cadena;
        largo_cad:=char_length(cadena);
    end loop;
    return cadena;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_obtener_literal_periodo (OID = 304241) : 
--
