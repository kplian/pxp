CREATE OR REPLACE FUNCTION pxp.f_campo_constraint (
  descripcion text,
  tipo integer
)
RETURNS varchar
AS 
$body$
DECLARE
  inicio	integer;
  fin 		integer;
  cadena	text;
BEGIN
  if(tipo=1)then	
  inicio=strpos(descripcion,'REFERENCES');
  cadena=SUBSTRING(descripcion,inicio);
  inicio=strpos(cadena,'(');
  fin=strpos(cadena,')');
  cadena=SUBSTRING(cadena,inicio+1,fin-inicio-1);
  return cadena;
  elsif(tipo=0)then
  inicio=strpos(descripcion,'REFERENCES');
  cadena=SUBSTRING(descripcion,inicio);
  inicio=strpos(cadena,'.');
  fin=strpos(cadena,'(');
  cadena=SUBSTRING(cadena,inicio+1,fin-inicio-1);
  return cadena;
  else
  inicio=strpos(descripcion,'(');
  fin=strpos(descripcion,')');
  cadena=SUBSTRING(descripcion,inicio+1,fin-inicio-1);
  --raise notice '%',descripcion;
  return cadena;
  end if;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_convertir_num_a_letra (OID = 304221) : 
--
