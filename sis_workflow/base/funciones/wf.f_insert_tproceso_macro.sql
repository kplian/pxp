CREATE OR REPLACE FUNCTION wf.f_insert_tproceso_macro (
  par_codigo varchar,
  par_nombre varchar,
  par_inicio varchar,
  par_estado_reg varchar,
  par_subsistema varchar
)
RETURNS varchar AS
$body$
DECLARE
  	var_id_subsistema	integer;
BEGIN
	if (exists (select 1 from wf.tproceso_macro where nombre = par_nombre and estado_reg = 'activo')) then
    	ALTER TABLE wf.tproceso_macro DISABLE TRIGGER USER;
    	update wf.tproceso_macro set
    		nombre = par_nombre, 
    		codigo = par_codigo, 
    		inicio = par_inicio
    	where codigo = par_codigo and estado_reg = 'activo';
    	ALTER TABLE wf.tproceso_macro ENABLE TRIGGER USER;    
    else
    	select id_subsistema into var_id_subsistema
	    from segu.tsubsistema s
	    where s.nombre=par_subsistema;
    	insert into wf.tproceso_macro (	nombre, codigo, inicio, estado_reg, id_subsistema, id_usuario_reg)
    	values (par_nombre, par_codigo, par_inicio, par_estado_reg, var_id_subsistema, 1);
    
    end if;
                
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;