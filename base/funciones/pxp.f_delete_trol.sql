CREATE OR REPLACE FUNCTION pxp.f_delete_trol (
  par_rol varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
   
BEGIN
	ALTER TABLE segu.trol DISABLE TRIGGER USER;
    update segu.trol set estado_reg = 'inactivo',modificado = 1 
    where estado_reg = 'activo' and rol = par_rol;
	ALTER TABLE segu.trol ENABLE TRIGGER USER;
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;