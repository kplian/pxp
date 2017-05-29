--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tcatalogo_tipo (
  p_accion varchar,
  p_nombre varchar,
  p_codigo_subsistema varchar,
  p_tabla varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_catalogo_tipo		integer;
    v_id_subsistema			integer;
BEGIN
	    
    
    select ct.id_catalogo_tipo into v_id_catalogo_tipo
    from param.tcatalogo_tipo ct    
    where trim(lower(ct.nombre)) = trim(lower(p_nombre));
    
    
    select 
      s.id_subsistema into  v_id_subsistema
    from segu.tsubsistema s 
    where  trim(lower(s.codigo)) = trim(lower(p_codigo_subsistema));
    
   
    if (p_accion = 'delete') then
    	
        -------------------------- TODO
        
    else
        if (v_id_catalogo_tipo is null)then
            
              INSERT INTO param.tcatalogo_tipo
                        (
                          id_usuario_reg,
                          fecha_reg,
                          estado_reg,
                          id_subsistema,
                          nombre,
                          tabla
                        )
                        VALUES (
                          1,
                          now(),
                          'activo',
                          v_id_subsistema,
                          p_nombre,
                          p_tabla
                        );
        else            
            
                UPDATE param.tcatalogo_tipo SET 
                  id_usuario_mod = 1,
                  fecha_mod = now(),
                  id_subsistema = v_id_subsistema,
                  nombre = p_nombre,
                  tabla = p_tabla
                WHERE id_catalogo_tipo = v_id_catalogo_tipo;     	
        end if;
    
	end if; 
      
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;