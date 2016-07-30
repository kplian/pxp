CREATE OR REPLACE FUNCTION pxp.file_exists (
  p_file text
)
RETURNS integer AS
$body$
DECLARE
  v_res	record;
BEGIN
  select pg_stat_file(p_file) 
  into v_res;
  return 1;
EXCEPTION
WHEN OTHERS THEN
  return 0;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;