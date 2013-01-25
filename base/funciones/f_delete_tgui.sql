CREATE OR REPLACE FUNCTION pxp.f_delete_tgui (
  par_codigo_gui varchar
)
RETURNS varchar AS
$body$
DECLARE
	
BEGIN
	update segu.tgui set estado_reg = 'inactivo'
    where estado_reg = 'activo' and codigo_gui = par_codigo_gui;
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;