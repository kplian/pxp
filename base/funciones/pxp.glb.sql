--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.glb (
  code text
)
RETURNS varchar AS
$body$
    select current_setting('glb.' || code)::varchar;
$body$
LANGUAGE 'sql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;