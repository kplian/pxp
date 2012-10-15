CREATE OR REPLACE FUNCTION pxp.f_insert_tgui_rol (
  par_rol character varying,
  par_gui character varying
)
RETURNS varchar
AS 
$body$
DECLARE
	v_id_rol integer;
    v_id_gui integer;
BEGIN
	select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_gui;
    
    select id_rol into v_id_rol
    from segu.trol r
    where r.rol = par_rol;
    
    insert into segu.tgui_rol (id_rol, id_gui, estado_reg)
    values (v_id_rol, v_id_gui, 'activo');
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_tprocedimiento (OID = 429322) : 
--
