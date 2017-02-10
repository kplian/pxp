--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.months_of (
  interval
)
RETURNS integer AS
$body$
  select extract(years from $1)::int * 12 + extract(month from $1)::int
$body$
LANGUAGE 'sql'
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER
COST 100;