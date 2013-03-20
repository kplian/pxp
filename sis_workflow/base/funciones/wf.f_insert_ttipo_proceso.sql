CREATE OR REPLACE FUNCTION wf.f_insert_ttipo_proceso (
  par_nombre varchar,
  par_codigo varchar,
  par_tabla varchar,
  par_columna_llave varchar,
  par_estado_reg varchar,
  par_inicio varchar,
  par_cod_proceso_macro varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_proceso_macro	integer;
BEGIN
	if (exists (select 1 from wf.ttipo_proceso where codigo = par_codigo and estado_reg = 'activo')) then
    	ALTER TABLE wf.ttipo_proceso DISABLE TRIGGER USER;
    	update wf.ttipo_proceso set
    		nombre = par_nombre,
            tabla = par_tabla,
            columna_llave = par_columna_llave,  
    		inicio = par_inicio
    	where codigo = par_codigo and estado_reg = 'activo';
    	ALTER TABLE wf.ttipo_proceso ENABLE TRIGGER USER;    
    else
    	select id_proceso_macro into v_id_proceso_macro
	    from wf.tproceso_macro pm
	    where pm.codigo=par_cod_proceso_macro;
    	insert into wf.ttipo_proceso (nombre, tabla, columna_llave, codigo, inicio, estado_reg, id_proceso_macro, id_usuario_reg)
    	values (par_nombre, par_tabla, par_columna_llave, par_codigo, par_inicio, par_estado_reg, v_id_proceso_macro, 1);
    
    end if;
                
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;