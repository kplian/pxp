CREATE OR REPLACE FUNCTION wf.f_import_tlabores_tipo_proceso (
 p_accion varchar,
 p_codigo varchar,	
 p_codigo_tipo_proceso varchar,	
 p_nombre varchar,	
 p_descripcion varchar
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_labores_tipo_proceso	integer;    
    v_id_tipo_proceso			integer;
    v_id_proceso_macro			integer;
BEGIN	 
        
    select id_tipo_proceso,id_proceso_macro into v_id_tipo_proceso,v_id_proceso_macro
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;
    
    select id_labores_tipo_proceso into v_id_labores_tipo_proceso
    from wf.tlabores_tipo_proceso lab    
    where lab.codigo = p_codigo and
    	lab.id_tipo_proceso = v_id_tipo_proceso;    
        
    ALTER TABLE wf.tlabores_tipo_proceso DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tlabores_tipo_proceso set estado_reg = 'inactivo',modificado = 1 
    	where id_labores_tipo_proceso = v_id_labores_tipo_proceso;
    else
        if (v_id_labores_tipo_proceso is null)then
           INSERT INTO 
                wf.tlabores_tipo_proceso
              (
                id_usuario_reg,                
                id_tipo_proceso,
                nombre,
                codigo,
                descripcion,
                modificado
              ) 
              VALUES (
                1,
                v_id_tipo_proceso,
                p_nombre,
                p_codigo,
                p_descripcion,
                1
              );
        else            
            UPDATE wf.tlabores_tipo_proceso  
            SET              
              nombre = p_nombre,
              codigo = p_codigo,
              descripcion = p_descripcion,
              modificado = 1             
            WHERE id_labores_tipo_proceso = v_id_labores_tipo_proceso;
        end if;
    
	end if; 
    
    ALTER TABLE wf.tlabores_tipo_proceso ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

