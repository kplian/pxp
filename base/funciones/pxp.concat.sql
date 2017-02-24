DROP AGGREGATE IF EXISTS pxp.text_concat (text);

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

CREATE AGGREGATE pxp.text_concat (text) (
    SFUNC = pxp.concat,
    STYPE = text
);
--
-- Definition for function existe_archivo (OID = 304209) : 
--
