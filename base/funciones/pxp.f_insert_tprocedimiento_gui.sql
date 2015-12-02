CREATE OR REPLACE FUNCTION pxp.f_insert_tprocedimiento_gui (
  par_procedimiento varchar,
  par_gui varchar,
  par_boton varchar
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
    
    if coalesce(v_id_gui,-1) = -1 then
    	raise exception 'Error al insertar Procedimiento. No existe el codigo de Interfaz: "%"  (procedimiento: "%")',par_gui,par_procedimiento;
    end if;
    
    select id_procedimiento into v_id_procedimiento
    from segu.tprocedimiento p
    where p.codigo = par_procedimiento;
    if (not exists( select 1 
    				from segu.tprocedimiento_gui 
                    where id_gui = v_id_gui and id_procedimiento = v_id_procedimiento and estado_reg = 'activo'))then
        insert into segu.tprocedimiento_gui (id_procedimiento, id_gui, boton, modificado)
        values (v_id_procedimiento, v_id_gui, par_boton, 1);
    else
    	ALTER TABLE segu.tprocedimiento_gui DISABLE TRIGGER USER;
    	
    	update segu.tprocedimiento_gui set modificado = 1 
    	where id_procedimiento = v_id_procedimiento and id_gui = v_id_gui;
    	
    	ALTER TABLE segu.tprocedimiento_gui ENABLE TRIGGER USER; 
    end if;
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;