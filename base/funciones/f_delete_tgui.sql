CREATE OR REPLACE FUNCTION pxp.f_delete_tgui (
  par_codigo_gui varchar
)
RETURNS varchar AS
$body$
DECLARE
	
BEGIN
	ALTER TABLE segu.tgui DISABLE TRIGGER USER;  
	update segu.tgui set estado_reg = 'inactivo',modificado = 1 
    where estado_reg = 'activo' and codigo_gui = par_codigo_gui;
    ALTER TABLE segu.tgui ENABLE TRIGGER USER; 
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;