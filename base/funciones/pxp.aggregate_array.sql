CREATE OR REPLACE FUNCTION pxp.aggregate_array (
  anyarray,
  anyelement
)
RETURNS anyarray
AS 
$body$
SELECT
CASE
WHEN $1 IS NULL
THEN ARRAY[$2]
WHEN $2 IS NULL
THEN $1
ELSE array_append($1,$2)
END;
$body$
    LANGUAGE sql;