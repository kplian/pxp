CREATE OR REPLACE FUNCTION pxp.list_unique (
  text,
  text
)
RETURNS text AS
$body$
SELECT
CASE
WHEN $1 IS NULL OR $1 = ''
THEN $2
WHEN $2 IS NULL OR $2 = ''
THEN $1
WHEN position($2 in $1) != 0
THEN $1
ELSE $1 || ',' || $2
END;
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;