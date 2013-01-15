CREATE OR REPLACE FUNCTION pxp.f_insert_tprocedimiento_gui (
  par_procedimiento character varying,
  par_gui character varying,
  par_boton character varying
)
RETURNS varchar
AS 
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
    
    insert into segu.tprocedimiento_gui (id_procedimiento, id_gui, boton, modificado)
    values (v_id_procedimiento, v_id_gui, par_boton, 1);
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_trol_procedimiento_gui (OID = 429324) : 
--
