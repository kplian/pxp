DROP AGGREGATE IF EXISTS pxp.list (text);

CREATE OR REPLACE FUNCTION pxp.comma_cat (
  text,
  text
)
RETURNS text
AS 
$body$
select case
 WHEN $2 is null or $2 = '' THEN $1
 WHEN $1 is null or $1 = '' THEN $2
 ELSE $1 || ',' || $2
 END
$body$
    LANGUAGE sql;

CREATE AGGREGATE pxp.list (text) (
    SFUNC = pxp.comma_cat,
    STYPE = text
);
--
-- Definition for function concat (OID = 304142) : 
--
