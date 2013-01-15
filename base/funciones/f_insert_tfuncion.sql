CREATE OR REPLACE FUNCTION pxp.f_insert_tfuncion (
  par_nombre character varying,
  par_descripcion character varying,
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
    
    insert into segu.tfuncion (nombre, descripcion, id_subsistema, modificado)
    values (par_nombre, par_descripcion, v_id_subsistema, 1);
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_tgui (OID = 429316) : 
--
