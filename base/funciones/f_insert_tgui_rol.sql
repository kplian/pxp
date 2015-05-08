CREATE OR REPLACE FUNCTION pxp.f_insert_tgui_rol (
  par_gui varchar,
  par_rol varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_rol integer;
    v_id_gui integer;
BEGIN

	
    
    select id_rol into v_id_rol
    from segu.trol r
    where r.rol = par_rol;
    
    select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_gui;
    
    
raise notice  'v_id_gui  % v_id_rol   % ', v_id_gui, v_id_rol;
    if (not exists( select 1 
    				from segu.tgui_rol 
                    where id_gui = v_id_gui and id_rol = v_id_rol and estado_reg = 'activo'))then
        insert 
            into segu.tgui_rol (id_rol, id_gui, estado_reg, modificado)
                        values (v_id_rol, v_id_gui, 'activo', 1);
                        
    else
    	ALTER TABLE segu.tgui_rol DISABLE TRIGGER USER;
    	
    	update segu.tgui_rol set modificado = 1 
    	where id_rol = v_id_rol and id_gui = v_id_gui;
    	
    	ALTER TABLE segu.tgui_rol ENABLE TRIGGER USER; 
    end if;
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;