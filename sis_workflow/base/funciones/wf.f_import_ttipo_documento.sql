CREATE OR REPLACE FUNCTION wf.f_import_ttipo_documento (
  p_accion varchar,
  p_codigo varchar,
  p_codigo_tipo_proceso varchar,
  p_nombre varchar,
  p_descripcion text,
  p_action varchar,
  p_tipo_documento varchar,
  p_orden numeric,
  p_categoria_documento varchar []
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_documento			integer;    
    v_id_tipo_proceso			integer;
    v_id_proceso_macro			integer;
BEGIN	 
	
    select id_tipo_proceso,id_proceso_macro into v_id_tipo_proceso,v_id_proceso_macro
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso ;
    
    select id_tipo_documento into v_id_tipo_documento
    from wf.ttipo_documento td    
    where td.codigo = p_codigo and
    	td.id_tipo_proceso = v_id_tipo_proceso;    
        
    ALTER TABLE wf.ttipo_documento DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttipo_documento set estado_reg = 'inactivo',modificado = 1 
    	where id_tipo_documento = v_id_tipo_documento;
    else
        if (v_id_tipo_documento is null)then
           INSERT INTO 
              wf.ttipo_documento
            (
              id_usuario_reg,              
              id_tipo_proceso,
              id_proceso_macro,
              codigo,
              nombre,
              descripcion,
              action,
              tipo,
              modificado,
              orden,
              categoria_documento
            ) 
            VALUES (
              1,              
              v_id_tipo_proceso,
              v_id_proceso_macro,
              p_codigo,
              p_nombre,
              p_descripcion,
              p_action,
              p_tipo_documento,
              1,
              p_orden,
              p_categoria_documento
            );
        else            
            UPDATE wf.ttipo_documento  
            SET  
              id_tipo_proceso = v_id_tipo_proceso,
              id_proceso_macro = v_id_proceso_macro,
              codigo = p_codigo,
              nombre = p_nombre,
              descripcion = p_descripcion,
              action = p_action,
              tipo = p_tipo_documento,
              modificado = 1,
              orden = p_orden,
              categoria_documento = p_categoria_documento             
            WHERE 
              id_tipo_documento = v_id_tipo_documento;
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_documento ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;