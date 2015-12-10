CREATE OR REPLACE FUNCTION pxp.isleapyear (
  year integer
)
RETURNS boolean AS
$body$
SELECT ($1 % 4 = 0) AND (($1 % 100 <> 0) or ($1 % 400 = 0))
$body$
LANGUAGE 'sql'
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER
COST 100;