CREATE OR REPLACE FUNCTION pxp.f_insert_tprocedimiento (
  par_codigo varchar,
  par_descripcion text,
  par_habilita_log varchar,
  par_autor varchar,
  par_fecha_creacion varchar,
  par_funcion varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_funcion integer;
BEGIN

	if (exists (select 1 from segu.tprocedimiento where codigo = par_codigo and estado_reg = 'activo')) then
    	ALTER TABLE segu.tprocedimiento DISABLE TRIGGER USER;
    	update segu.tprocedimiento set
    		codigo = par_codigo, 
    		descripcion = par_descripcion,
    		habilita_log = par_habilita_log,
    		autor = par_autor,
    		fecha_creacion = par_fecha_creacion, 
    		modificado = 1
    	where codigo = par_codigo and estado_reg = 'activo';
    	ALTER TABLE segu.tprocedimiento ENABLE TRIGGER USER;
    else
		select id_funcion into v_id_funcion
	    from segu.tfuncion f
	    where f.nombre = par_funcion;
	    
	    insert into segu.tprocedimiento (	codigo, descripcion, habilita_log, 
	    									autor, fecha_creacion, id_funcion, modificado)
	    values (par_codigo, par_descripcion, par_habilita_log,
	    		par_autor, par_fecha_creacion, v_id_funcion, 1);
	end if;
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;