CREATE OR REPLACE FUNCTION pxp.f_is_loaded_script (
  p_codigo varchar
)
RETURNS integer AS
$body$
DECLARE
BEGIN	
	IF (not exists (SELECT 1 
    			from pxp.tscript_version 
                where codigo = p_codigo))THEN
    	return 0;
    ELSE
    	return 1;
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
