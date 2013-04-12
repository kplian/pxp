CREATE OR REPLACE FUNCTION wf.f_insert_ttipo_estado (
  par_codigo varchar,
  par_nombre_estado varchar,
  par_inicio varchar,
  par_disparador varchar,
  par_fin varchar,
  par_tipo_asignacion varchar,
  par_nombre_func_list varchar,
  par_depto_asignacion varchar,
  par_nombre_depto_func_list varchar,
  par_obs text,
  par_estado_reg varchar,
  par_codigo_proceso varchar,
  par_tipos_proceso text
)
RETURNS varchar AS
$body$
DECLARE
  v_id_tipo_proceso integer;
  v_tipos_procesos  text[];
  v_size			integer;
  var_id_tipo_estado integer;
BEGIN
	select id_tipo_proceso into v_id_tipo_proceso
	    from wf.ttipo_proceso pm
	    where pm.codigo=par_codigo_proceso;

	if (exists (select 1 from wf.ttipo_estado where nombre_estado = par_nombre_estado and id_tipo_proceso=v_id_tipo_proceso and estado_reg = 'activo')) then
     	ALTER TABLE wf.ttipo_estado DISABLE TRIGGER USER;
    	update wf.ttipo_estado set
            codigo = par_codigo,
    		inicio = par_inicio,
            disparador = par_disparador,
            fin = par_fin,
            tipo_asignacion = par_tipo_asignacion,
            nombre_func_list = par_nombre_func_list,
            depto_asignacion = par_depto_asignacion,
            nombre_depto_func_list = par_nombre_depto_func_list,
            obs = par_obs
    	where nombre_estado = par_nombre_estado and estado_reg = 'activo';
		
		--modificamos la tabla ttipo_proceso
		v_tipos_procesos=regexp_split_to_array(par_tipos_proceso,',');
		v_size = array_length(v_tipos_procesos,1);
        FOR i IN 1..v_size
        LOOP 
        	select id_tipo_estado into var_id_tipo_estado from wf.ttipo_estado te where te.nombre_estado=par_nombre_estado;       	
        	select tp.id_tipo_proceso into v_id_tipo_proceso from wf.ttipo_proceso tp
            where tp.codigo=v_tipos_procesos[i]; 
            update wf.ttipo_proceso tp set 
            id_tipo_estado=var_id_tipo_estado
            where tp.id_tipo_proceso = v_id_tipo_proceso;            
        END LOOP;
        
    	ALTER TABLE wf.ttipo_estado ENABLE TRIGGER USER;    
    else
    	insert into wf.ttipo_estado (codigo, nombre_estado, inicio, disparador, fin, tipo_asignacion, nombre_func_list,
        depto_asignacion, nombre_depto_func_list,obs, estado_reg, id_tipo_proceso, id_usuario_reg)
    	values (par_codigo, par_nombre_estado, par_inicio, par_disparador, par_fin, par_tipo_asignacion, par_nombre_func_list,
         par_depto_asignacion, par_nombre_depto_func_list, par_obs, par_estado_reg, v_id_tipo_proceso, 1);
  		
        --modificamos la tabla ttipo_proceso	  
        v_tipos_procesos=regexp_split_to_array(par_tipos_proceso,',');
		v_size = array_length(v_tipos_procesos,1);
        FOR i IN 1..v_size
        LOOP 
        	select id_tipo_estado into var_id_tipo_estado from wf.ttipo_estado te where te.nombre_estado=par_nombre_estado;       	
        	select tp.id_tipo_proceso into v_id_tipo_proceso from wf.ttipo_proceso tp
            where tp.codigo=v_tipos_procesos[i]; 
            update wf.ttipo_proceso tp set 
            id_tipo_estado=var_id_tipo_estado
            where tp.id_tipo_proceso = v_id_tipo_proceso;            
        END LOOP;
    end if;
                
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;