--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.concat_array (
  pg_catalog.anyarray,
  pg_catalog.anyarray
)
RETURNS pg_catalog.anyarray AS
$body$
SELECT
CASE
WHEN $1 IS NULL
THEN $2
WHEN $2 IS NULL
THEN $1
ELSE $1||$2
END;
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;