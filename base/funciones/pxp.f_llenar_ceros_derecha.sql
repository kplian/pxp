CREATE OR REPLACE FUNCTION pxp.f_llenar_ceros_derecha (
  numero varchar,
  digitos integer
)
RETURNS text AS
$body$
DECLARE
	largo_cad 		integer;
	cadena			text;
BEGIN
    cadena:=numero;
    largo_cad:=char_length(cadena);
    while (largo_cad<digitos) loop
        cadena:=cadena||'0';
        largo_cad:=char_length(cadena);
    end loop;
    return cadena;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION pxp.f_llenar_ceros_derecha (numero varchar, digitos integer)
  OWNER TO postgres;