--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_import_ttipo_proceso_origen (
  p_accion varchar,
  p_codigo_tipo_proceso varchar,
  p_codigo_pm varchar,
  p_codigo_tipo_proceso_origen varchar,
  p_codigo_tipo_estado varchar,
  p_tipo_disparo varchar,
  p_funcion_validacion_wf text
)
RETURNS varchar AS
$body$
DECLARE    
    v_id_proceso_macro          integer;    
    v_id_tipo_proceso           integer;
    v_id_tipo_proceso_origen    integer;
    v_identificador             integer;
    v_id_tipo_estado            integer;   
BEGIN    
        
    select id_tipo_proceso into v_id_tipo_proceso_origen
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso_origen;
    
    
    --raise exception '%',v_id_tipo_proceso_origen;
    select id_tipo_proceso,id_proceso_macro into v_id_tipo_proceso,v_id_proceso_macro
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;    
        
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
        te.id_tipo_proceso = v_id_tipo_proceso_origen; 
       
          
    select tpo.id_tipo_proceso_origin into v_identificador
    from wf.ttipo_proceso_origen tpo
    where tpo.id_tipo_proceso = v_id_tipo_proceso and tpo.id_tipo_estado = v_id_tipo_estado;      
        
    ALTER TABLE wf.ttipo_proceso_origen DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
        update wf.ttipo_proceso_origen set estado_reg = 'inactivo',modificado = 1 
        where id_tipo_proceso_origin = v_identificador;
    else
        if (v_identificador is null)then
        
          If v_id_tipo_proceso_origen is not null AND  v_id_tipo_estado is not null  THEN
        
           INSERT INTO 
              wf.ttipo_proceso_origen
            (
              id_usuario_reg,              
              id_tipo_estado,
              id_tipo_proceso,
              tipo_disparo,
              funcion_validacion_wf,
              id_proceso_macro,
              modificado
            ) 
            VALUES (
              1,              
              v_id_tipo_estado,
              v_id_tipo_proceso,
              p_tipo_disparo,
              p_funcion_validacion_wf,
              v_id_proceso_macro,
              1
            );
           ELSE
              raise notice 'ALERTA,.... no existe el v_id_tipo_proceso_origen  %, o el id_tipo_estado %',p_codigo_tipo_proceso_origen, p_codigo_tipo_proceso ;
           END IF;  
            
        else    
        
             If v_id_tipo_proceso_origen is not null AND  v_id_tipo_estado is not null  THEN        
                 UPDATE wf.ttipo_proceso_origen  
                  SET              
                    id_tipo_estado = v_id_tipo_estado,
                    tipo_disparo = p_tipo_disparo,
                    funcion_validacion_wf = p_funcion_validacion_wf,
                    id_proceso_macro = v_id_proceso_macro,
                    modificado = 1             
                  WHERE id_tipo_proceso_origin = v_id_tipo_proceso_origen;
            
             ELSE
              	raise notice 'ALERTA,.... no existe el v_id_tipo_proceso_origen  %, o el id_tipo_estado %',p_codigo_tipo_proceso_origen, p_codigo_tipo_proceso ;
             END IF;
        end if;
    
    end if; 
    
    ALTER TABLE wf.ttipo_proceso_origen ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;