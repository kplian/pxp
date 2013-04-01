CREATE OR REPLACE FUNCTION wf.f_insert_ttipo_proceso (
  par_nombre_tipo_estado varchar,
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
    v_id_tipo_estado	integer;
BEGIN
	select te.id_tipo_estado into v_id_tipo_estado from wf.ttipo_estado te where te.nombre_estado=par_nombre_tipo_estado; 
    
	if (exists (select 1 from wf.ttipo_proceso where codigo = par_codigo and estado_reg = 'activo')) then
    	ALTER TABLE wf.ttipo_proceso DISABLE TRIGGER USER;
    	update wf.ttipo_proceso set
        	id_tipo_estado=v_id_tipo_estado,
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
    	insert into wf.ttipo_proceso (id_tipo_estado, nombre, tabla, columna_llave, codigo, inicio, estado_reg, id_proceso_macro, id_usuario_reg)
    	values (v_id_tipo_estado, par_nombre, par_tabla, par_columna_llave, par_codigo, par_inicio, par_estado_reg, v_id_proceso_macro, 1);
    
    end if;
                
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;