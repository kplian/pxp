CREATE OR REPLACE FUNCTION pxp.f_insert_tfuncion (
  par_nombre varchar,
  par_descripcion varchar,
  par_subsistema varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
BEGIN
	if (exists (select 1 from segu.tfuncion where nombre = par_nombre and estado_reg = 'activo')) then
    	ALTER TABLE segu.tfuncion DISABLE TRIGGER USER;
    	update segu.tfuncion set
    		nombre = par_nombre, 
    		descripcion = par_descripcion, 
    		modificado = 1
    	where nombre = par_nombre and estado_reg = 'activo';
    	ALTER TABLE segu.tfuncion ENABLE TRIGGER USER;
    else
		select id_subsistema into v_id_subsistema
	    from segu.tsubsistema s
	    where s.codigo = par_subsistema;
	    
	    insert into segu.tfuncion (nombre, descripcion, id_subsistema, modificado)
	    values (par_nombre, par_descripcion, v_id_subsistema, 1);
	end if;
	
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;