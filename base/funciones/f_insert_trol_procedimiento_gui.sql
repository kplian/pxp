CREATE OR REPLACE FUNCTION pxp.f_insert_trol_procedimiento_gui (
  par_rol varchar,
  par_procedimiento varchar,
  par_gui varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_procedimiento_gui 	integer;
    v_id_rol				integer;
BEGIN
	 
    select id_procedimiento_gui into v_id_procedimiento_gui
    from segu.tprocedimiento_gui pg
    inner join segu.tprocedimiento p 
    	on p.id_procedimiento = pg.id_procedimiento
    inner join segu.tgui g
    	on g.id_gui = pg.id_gui
    where p.codigo = par_procedimiento and g.codigo_gui = par_gui;
    
    select id_rol into v_id_rol
    from segu.trol r
    where r.rol = par_rol;
    if (not exists( select 1 
    				from segu.trol_procedimiento_gui 
                    where id_rol = v_id_rol and id_procedimiento_gui = v_id_procedimiento_gui and estado_reg = 'activo'))then
        insert into segu.trol_procedimiento_gui (id_rol, id_procedimiento_gui, modificado)
        values (v_id_rol, v_id_procedimiento_gui, 1);
    
    else
    	ALTER TABLE segu.trol_procedimiento_gui DISABLE TRIGGER USER;
    	
    	update segu.trol_procedimiento_gui set modificado = 1 
    	where id_rol = v_id_rol and id_procedimiento_gui = v_id_procedimiento_gui;
    	
    	ALTER TABLE segu.trol_procedimiento_gui ENABLE TRIGGER USER; 
    end if;
    
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;