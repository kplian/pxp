CREATE OR REPLACE FUNCTION wf.f_import_testructura_estado (
  p_accion varchar,
  p_codigo_estado_padre varchar,
  p_codigo_estado_hijo varchar,
  p_codigo_tipo_proceso varchar,
  p_prioridad integer,
  p_regla varchar
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_estado_padre			integer;    
    v_id_tipo_proceso			integer;
    v_id_estado_hijo			integer;
    v_id_estructura_estado		integer;   
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;    
        
    select id_tipo_estado into v_id_estado_padre
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_estado_padre and
    	te.id_tipo_proceso = v_id_tipo_proceso;   
        
    select id_tipo_estado into v_id_estado_hijo
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_estado_hijo and
    	te.id_tipo_proceso = v_id_tipo_proceso;
        
    select ee.id_estructura_estado into v_id_estructura_estado
    from wf.testructura_estado ee
    where ee.id_tipo_estado_padre = v_id_estado_padre and ee.id_tipo_estado_hijo = v_id_estado_hijo;      
        
    ALTER TABLE wf.testructura_estado DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.testructura_estado set estado_reg = 'inactivo',modificado = 1 
    	where id_estructura_estado = v_id_estructura_estado;
    else
        if (v_id_estructura_estado is null)then
           INSERT INTO 
              wf.testructura_estado
            (
              id_usuario_reg,              
              id_tipo_estado_padre,
              id_tipo_estado_hijo,
              prioridad,
              regla,
              modificado
            ) 
            VALUES (
              1,              
              v_id_estado_padre,
              v_id_estado_hijo,
              p_prioridad,
              p_regla,
              1
            );
        else            
           UPDATE wf.testructura_estado  
            SET               
              id_tipo_estado_hijo = v_id_estado_hijo,
              prioridad = p_prioridad,
              regla = p_regla,
              modificado = 1             
            WHERE id_estructura_estado = v_id_estructura_estado;
        end if;
    
	end if; 
    
    ALTER TABLE wf.testructura_estado ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;