CREATE OR REPLACE FUNCTION pxp.f_delete_tprocedimiento (
  par_codigo varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_funcion integer;
BEGIN
	ALTER TABLE segu.tprocedimiento DISABLE TRIGGER USER; 
	update segu.tprocedimiento
    set estado_reg = 'inactivo',modificado = 1 
    where estado_reg = 'activo' and codigo = par_codigo;
    ALTER TABLE segu.tprocedimiento ENABLE TRIGGER USER; 
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;