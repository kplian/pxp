CREATE OR REPLACE FUNCTION pxp.last_post (
  text,
  char
)
RETURNS integer AS
$body$
select length($1)- length(regexp_replace($1, E'.*\\' || $2,''));
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

