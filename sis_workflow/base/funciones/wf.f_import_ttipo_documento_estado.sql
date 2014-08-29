CREATE OR REPLACE FUNCTION wf.f_import_ttipo_documento_estado (
p_accion varchar,	
p_codigo_tipo_documento varchar,	
p_codigo_tipo_proceso varchar,	
p_codigo_tipo_estado varchar,	
p_codigo_tipo_proceso_externo varchar,	
p_momento varchar,		
p_tipo_busqueda varchar,		
p_regla varchar	

)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_documento			integer;    
    v_id_tipo_proceso			integer;
    v_id_tipo_estado			integer;
    v_id_tipo_documento_estado	integer; 
    v_id_tipo_proceso_externo	integer;   
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;
    
    select id_tipo_proceso into v_id_tipo_proceso_externo
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso_externo;
    
    select id_tipo_documento into v_id_tipo_documento
    from wf.ttipo_documento td    
    where td.codigo = p_codigo_tipo_documento and
    	td.id_tipo_proceso = v_id_tipo_proceso;
        
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
    	te.id_tipo_proceso = v_id_tipo_proceso_externo;   
        
    select tde.id_tipo_documento_estado into v_id_tipo_documento_estado
    from wf.ttipo_documento_estado tde
    where tde.id_tipo_documento = v_id_tipo_documento and tde.id_tipo_estado = v_id_tipo_estado ;
      
        
    ALTER TABLE wf.ttipo_documento_estado DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttipo_documento_estado set estado_reg = 'inactivo',modificado = 1 
    	where id_tipo_documento_estado = v_id_tipo_documento_estado;
    else
        if (v_id_tipo_documento_estado is null)then
           INSERT INTO wf.ttipo_documento_estado
            (
              id_usuario_reg,              
              id_tipo_documento,
              id_tipo_proceso,
              id_tipo_estado,
              momento,
              tipo_busqueda,
              regla,
              modificado
            ) 
            VALUES (
              1,              
              v_id_tipo_documento,
              v_id_tipo_proceso,
              v_id_tipo_estado,
              p_momento,
              p_tipo_busqueda,
              p_regla,
              1
            );
        else            
           UPDATE wf.ttipo_documento_estado  
            SET               
              id_tipo_estado = v_id_tipo_estado,
              momento = p_momento,
              tipo_busqueda = p_tipo_busqueda,
              regla = p_regla,
              modificado = 1
             
            WHERE id_tipo_documento_estado = v_id_tipo_documento_estado;
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_documento_estado ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

