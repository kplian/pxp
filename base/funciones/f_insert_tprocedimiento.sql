CREATE OR REPLACE FUNCTION pxp.f_insert_tprocedimiento (
  par_codigo character varying,
  par_descripcion text,
  par_habilita_log character varying,
  par_autor character varying,
  par_fecha_creacion character varying,
  par_funcion character varying
)
RETURNS varchar
AS 
$body$
DECLARE
	v_id_funcion integer;
BEGIN
	select id_funcion into v_id_funcion
    from segu.tfuncion f
    where f.nombre = par_funcion;
    
    insert into segu.tprocedimiento (	codigo, descripcion, habilita_log, 
    									autor, fecha_creacion, id_funcion)
    values (par_codigo, par_descripcion, par_habilita_log,
    		par_autor, par_fecha_creacion, v_id_funcion);
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_tprocedimiento_gui (OID = 429323) : 
--
