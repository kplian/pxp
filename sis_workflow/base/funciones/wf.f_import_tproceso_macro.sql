CREATE OR REPLACE FUNCTION wf.f_import_tproceso_macro (
  p_accion varchar,	
  p_codigo varchar,	
  p_codigo_subsistema varchar,
  p_nombre varchar,
  p_inicio varchar

)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema 		integer;
    v_id_rol				integer;
    v_id_proceso_macro		integer;
BEGIN
	    
    select id_proceso_macro into v_id_proceso_macro
    from wf.tproceso_macro pm    
    where pm.codigo = p_codigo;
    
    select id_subsistema into v_id_subsistema
    from segu.tsubsistema sub    
    where sub.codigo = p_codigo_subsistema;
    
    ALTER TABLE wf.tproceso_macro DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tproceso_macro set estado_reg = 'inactivo',modificado = 1 
    	where id_proceso_macro = v_id_proceso_macro;
    else
        if (v_id_proceso_macro is null)then
            INSERT INTO wf.tproceso_macro
            (id_usuario_reg,             
              id_subsistema,
              codigo,
              nombre,
              inicio,
              modificado
            ) 
            VALUES (
              1,              
              v_id_subsistema,
              p_codigo,
              p_nombre,
              p_inicio,
              1
            );       
        else            
            UPDATE wf.tproceso_macro  
            SET id_subsistema = v_id_subsistema,              
              nombre = p_nombre,
              inicio = p_inicio,
              modificado = 1             
            WHERE id_proceso_macro = v_id_proceso_macro;       	
        end if;
    
	end if; 
    
    ALTER TABLE wf.tproceso_macro ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;