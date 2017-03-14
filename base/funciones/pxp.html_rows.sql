CREATE OR REPLACE FUNCTION pxp.html_rows (
  varchar,
  varchar
)
RETURNS varchar AS
$body$
SELECT
CASE
WHEN $1 IS NULL
THEN '<tr>' || $2 || '</tr>'
WHEN $2 IS NULL
THEN $1
WHEN position($2 in $1) != 0
THEN $1
ELSE $1 || '<tr>' || $2 || '</tr>'
END;
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;