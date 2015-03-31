CREATE OR REPLACE FUNCTION wf.f_import_tcategoria_documento (
  p_accion varchar,
  p_codigo varchar,
  p_nombre varchar
)
RETURNS varchar AS
$body$
DECLARE
	
    v_id_categoria_documento		integer;
BEGIN
	    
    select id_categoria_documento into v_id_categoria_documento
    from wf.tcategoria_documento cd    
    where cd.codigo = p_codigo;
    
        
    ALTER TABLE wf.tcategoria_documento DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tcategoria_documento set estado_reg = 'inactivo',modificado = 1 
    	where id_categoria_documento = v_id_categoria_documento;
    else
        if (v_id_categoria_documento is null)then
            INSERT INTO wf.tcategoria_documento
            (id_usuario_reg,            
              codigo,
              nombre,
              modificado
            ) 
            VALUES (
              1,  
              p_codigo,
              p_nombre,
              1
            );       
        else            
            UPDATE wf.tcategoria_documento  
            SET             
              nombre = p_nombre,
              modificado = 1             
            WHERE id_categoria_documento = v_id_categoria_documento;       	
        end if;
    
	end if; 
    
    ALTER TABLE wf.tcategoria_documento ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;