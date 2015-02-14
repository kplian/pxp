CREATE OR REPLACE FUNCTION wf.f_import_ttipo_estado_rol (
  p_accion varchar,
  p_codigo_tipo_proceso varchar,
  p_codigo_tipo_estado varchar,
  p_codigo_rol varchar
)
RETURNS varchar AS
$body$
DECLARE	   
       
    v_id_tipo_proceso			integer;
    v_id_tipo_estado			integer;
    v_id_rol					integer; 
    v_id_tipo_estado_rol		integer;
       
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;    
    
            
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
    	te.id_tipo_proceso = v_id_tipo_proceso; 
    	
    select id_rol into v_id_rol
    from segu.trol r
    where  r.rol = p_codigo_rol; 
        
    select tesrol.id_tipo_estado_rol into v_id_tipo_estado_rol
    from wf.ttipo_estado_rol tesrol
    where tesrol.id_rol = v_id_rol and tesrol.id_tipo_estado = v_id_tipo_estado;
      
        
    ALTER TABLE wf.ttipo_estado_rol DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttipo_estado_rol set estado_reg = 'inactivo',modificado = 1 
    	where id_tipo_estado_rol = v_id_tipo_estado_rol;
    else
        if (v_id_tipo_estado_rol is null)then
        	if (v_id_rol is not null) then
               INSERT INTO wf.ttipo_estado_rol
                (
                  id_usuario_reg,              
                  id_tipo_estado,
                  id_rol,              
                  modificado
                ) 
                VALUES (
                  1,              
                  v_id_tipo_estado,
                  v_id_rol,              
                  1
                );
            end if;
        else            
           UPDATE wf.ttipo_estado_rol  
            SET               
              id_tipo_estado = v_id_tipo_estado,
              id_rol = v_id_rol,
              modificado = 1             
            WHERE id_tipo_estado_rol = v_id_tipo_estado_rol;
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_estado_rol ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;