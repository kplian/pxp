CREATE OR REPLACE FUNCTION pxp.f_generate_token(size int)
RETURNS text AS $$
SELECT array_to_string(
  ARRAY(
      SELECT substring(
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
        trunc(random()*62)::int+1,
        1
      )
      FROM generate_series(1,size) AS gs(x)
  )
  , ''
)
$$ LANGUAGE SQL
RETURNS NULL ON NULL INPUT
VOLATILE LEAKPROOF;