CREATE OR REPLACE FUNCTION wf.f_import_ttipo_proceso (
  p_accion varchar,
  p_codigo varchar,
  p_codigo_tipo_estado varchar,
  p_codigo_tipo_proceso_estado varchar,
  p_codigo_pm varchar,
  p_nombre varchar,
  p_tabla varchar,
  p_columna_llave varchar,
  p_inicio varchar,
  p_funcion_validacion varchar,
  p_tipo_disparo varchar,
  p_descripcion varchar,
  p_codigo_llave varchar,
  p_funcion_disparo_wf varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_proceso_macro 	integer;    
    v_id_tipo_proceso		integer;
    v_id_tipo_proceso_estado		integer;
    v_id_tipo_estado	integer;
BEGIN
	 
    select id_proceso_macro into v_id_proceso_macro
    from wf.tproceso_macro pm    
    where pm.codigo = p_codigo_pm ;
    
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo ;
    
    select id_tipo_proceso into v_id_tipo_proceso_estado
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso_estado ;
    
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and te.id_tipo_proceso = v_id_tipo_proceso_estado;
    
    ALTER TABLE wf.ttipo_proceso DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttipo_proceso set estado_reg = 'inactivo',modificado = 1 
    	where id_tipo_proceso = v_id_tipo_proceso;
    else
        if (v_id_tipo_proceso is null)then
           INSERT INTO wf.ttipo_proceso
            (
              id_usuario_reg,              
              id_tipo_estado,
              id_proceso_macro,
              nombre,
              tabla,
              columna_llave,
              codigo,
              inicio,
              funcion_validacion_wf,
              tipo_disparo,
              descripcion,
              codigo_llave,
              modificado,
              funcion_disparo_wf
            ) 
            VALUES (
              1,
              v_id_tipo_estado,
              v_id_proceso_macro,
              p_nombre,
              p_tabla,
              p_columna_llave,
              p_codigo,
              p_inicio,
              p_funcion_validacion,
              p_tipo_disparo,
              p_descripcion,
              p_codigo_llave,
              1,
              p_funcion_disparo_wf
            );     
        else            
            UPDATE wf.ttipo_proceso  
              SET                 
                id_tipo_estado = v_id_tipo_estado,                
                nombre = p_nombre,
                tabla = p_tabla,
                columna_llave = p_columna_llave,
                codigo = p_codigo,
                inicio = p_inicio,
                funcion_validacion_wf = p_funcion_validacion,
                tipo_disparo = p_tipo_disparo,
                descripcion = p_descripcion,
                codigo_llave = p_codigo_llave,
                modificado = 1,
                funcion_disparo_wf = p_funcion_disparo_wf               
              WHERE id_tipo_proceso = v_id_tipo_proceso;       	
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_proceso ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;