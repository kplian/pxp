CREATE OR REPLACE FUNCTION wf.f_import_tcolumna_estado (
p_accion varchar,	
p_nombre_tipo_columna varchar,	
p_codigo_tabla varchar,		
p_codigo_tipo_proceso varchar,	
p_codigo_tipo_estado varchar,	
p_momento varchar,	
p_regla varchar
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_columna			integer;    
    v_id_tipo_proceso			integer;
    v_id_tipo_estado			integer;
    v_id_columna_estado			integer;
    v_id_tabla					integer;    
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;
    
    select id_tabla into v_id_tabla
    from wf.ttabla ta    
    where ta.bd_codigo_tabla = p_codigo_tabla and
    	ta.id_tipo_proceso = v_id_tipo_proceso;
        
    select id_tipo_columna into v_id_tipo_columna
    from wf.ttipo_columna tc    
    where tc.bd_nombre_columna = p_nombre_tipo_columna and
    	tc.id_tabla = v_id_tabla;
        
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
    	te.id_tipo_proceso = v_id_tipo_proceso;   
        
    select ce.id_columna_estado into v_id_columna_estado
    from wf.tcolumna_estado ce
    where ce.id_tipo_columna = v_id_tipo_columna and ce.id_tipo_estado = v_id_tipo_estado;      
        
    ALTER TABLE wf.tcolumna_estado DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tcolumna_estado set estado_reg = 'inactivo',modificado = 1 
    	where id_columna_estado = v_id_columna_estado;
    else
        if (v_id_columna_estado is null)then
           INSERT INTO wf.tcolumna_estado
            (
              id_usuario_reg,              
              id_tipo_columna,
              id_tipo_estado,
              momento,
              modificado,
              regla
            ) 
            VALUES (
              1,              
              v_id_tipo_columna,
              v_id_tipo_estado,
              p_momento,
              1,
              p_regla
            );
        else            
           UPDATE wf.tcolumna_estado  
            SET               
              id_tipo_estado = v_id_tipo_estado,
              momento = p_momento,
              modificado = 1,
              regla = p_regla             
            WHERE id_columna_estado = v_id_columna_estado;
        end if;
    
	end if; 
    
    ALTER TABLE wf.tcolumna_estado ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

