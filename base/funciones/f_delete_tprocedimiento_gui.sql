CREATE OR REPLACE FUNCTION pxp.f_delete_tprocedimiento_gui (
  par_procedimiento varchar,
  par_gui varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_procedimiento integer;
    v_id_gui integer;
BEGIN
	select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_gui;
    
    select id_procedimiento into v_id_procedimiento
    from segu.tprocedimiento p
    where p.codigo = par_procedimiento;
    ALTER TABLE segu.tprocedimiento_gui DISABLE TRIGGER USER; 
    update segu.tprocedimiento_gui
    set estado_reg = 'inactivo',modificado = 1 
    where estado_reg = 'activo' and id_procedimiento = v_id_procedimiento 
    		and id_gui = v_id_gui;
    ALTER TABLE segu.tprocedimiento_gui ENABLE TRIGGER USER;
    
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;