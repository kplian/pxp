CREATE OR REPLACE FUNCTION pxp.f_insert_tgui (
  par_nombre character varying,
  par_descripcion text,
  par_codigo_gui character varying,
  par_visible character varying,
  par_orden_logico integer,
  par_ruta_archivo text,
  par_nivel integer,
  par_icono character varying,
  par_clase_vista character varying,
  par_subsistema character varying
)
RETURNS varchar
AS 
$body$
DECLARE
	v_id_subsistema integer;
BEGIN
	select id_subsistema into v_id_subsistema
    from segu.tsubsistema s
    where s.codigo = par_subsistema;
    
    insert into segu.tgui (	nombre, descripcion, codigo_gui, visible, orden_logico, ruta_archivo, 
    							nivel, icono, clase_vista, id_subsistema)
    values (	par_nombre, par_descripcion, par_codigo_gui, par_visible, par_orden_logico, par_ruta_archivo, 
    			par_nivel, par_icono, par_clase_vista, v_id_subsistema);
                
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_testructura_gui (OID = 429317) : 
--
