CREATE OR REPLACE FUNCTION pxp.br_cat (
  text,
  text
)
RETURNS text AS
$body$
select case
 WHEN $2 is null or $2 = '' THEN $1
 WHEN $1 is null or $1 = '' THEN $2
 ELSE $1 || '<br>' || $2
 END
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;