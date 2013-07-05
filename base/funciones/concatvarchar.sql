CREATE OR REPLACE FUNCTION pxp.concatvarchar (
  varchar,
  varchar
)
RETURNS varchar AS
$body$
DECLARE
BEGIN
  if $1 is null then
    return $2;
  end if;
  if $2 is null then
    return $1;
  end if;
  return $1 || '.' || $2;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;