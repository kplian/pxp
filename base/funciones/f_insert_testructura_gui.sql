CREATE OR REPLACE FUNCTION pxp.f_insert_testructura_gui (
  par_codigo_gui character varying,
  par_codigo_gui_fk character varying
)
RETURNS varchar
AS 
$body$
DECLARE
	v_id_gui integer;
    v_id_gui_fk integer;
BEGIN
	select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_codigo_gui;
    
    select id_gui into v_id_gui_fk
    from segu.tgui g
    where g.codigo_gui = par_codigo_gui_fk;
    
    insert into segu.testructura_gui (id_gui, fk_id_gui, modificado)
    values (v_id_gui, v_id_gui_fk, 1);
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_tgui_rol (OID = 429318) : 
--
