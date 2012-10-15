CREATE OR REPLACE FUNCTION pxp.f_copy (
  pm_nombre_tabla character varying,
  pm_ruta_archivo character varying
)
RETURNS varchar
AS 
$body$
DECLARE
  g_respuesta	varchar;
BEGIN
     EXECUTE ('COPY '||pm_nombre_tabla||' FROM '''||pm_ruta_archivo||''' DELIMITER '','';'); 
     g_respuesta='si';
     RETURN g_respuesta;
END;
$body$
    LANGUAGE plpgsql SECURITY DEFINER;
--
-- Definition for function f_dblink (OID = 304223) : 
--
