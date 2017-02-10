--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.months_between (
  date,
  date
)
RETURNS integer AS
$body$
   select abs(months_of(age($1, $2)))
$body$
LANGUAGE 'sql'
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER
COST 100;