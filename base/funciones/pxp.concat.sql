CREATE OR REPLACE FUNCTION pxp.concat (
  text,
  text
)
RETURNS text
AS 
$body$
begin
  if $1 is null then
    return $2;
  end if;
  if $2 is null then
    return $1;
  end if;
  return $1 || ',' || $2;
end
$body$
    LANGUAGE plpgsql IMMUTABLE;