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

	if (exists (select 1 from segu.tprocedimiento where codigo = par_codigo and estado_reg = 'activo')) then
    
    	update segu.tprocedimiento set
    		codigo = par_codigo, 
    		descripcion = par_descripcion,
    		habilita_log = par_habilita_log,
    		autor = par_autor,
    		fecha_creacion = par_fecha_creacion, 
    		modificado = 1
    	where codigo = par_codigo and estado_reg = 'activo';
    	    
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
    LANGUAGE plpgsql;
--
-- Definition for function f_insert_tprocedimiento_gui (OID = 429323) : 
--
