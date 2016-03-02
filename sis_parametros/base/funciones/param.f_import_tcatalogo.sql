--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tcatalogo (
  p_accion varchar,
  p_codigo_subsistema varchar,
  p_descripcion varchar,
  p_codigo varchar,
  p_desc_catalogo_tipo varchar
)
RETURNS varchar AS
$body$
DECLARE
	
    v_id_catalogo_tipo		integer;
    v_id_subsistema			integer;
    v_id_catalogo			integer;
BEGIN
	 


    select ct.id_catalogo_tipo into v_id_catalogo_tipo
    from param.tcatalogo_tipo ct    
    where trim(lower(ct.nombre)) = trim(lower(p_desc_catalogo_tipo));
    
    
    select c.id_catalogo into v_id_catalogo
    from param.tcatalogo c    
    where trim(lower(c.descripcion)) = trim(lower(p_descripcion))
          and c.id_catalogo_tipo = v_id_catalogo_tipo;
          
    
    if (p_accion = 'delete') then
    	
       -- TODO
    
    else
            if (v_id_catalogo is null)then
            		
                   INSERT INTO param.tcatalogo
                              (
                                id_usuario_reg,
                                fecha_reg,
                                estado_reg,
                                codigo,
                                descripcion,
                                id_catalogo_tipo
                              )
                              VALUES (
                                1,
                                now(),
                                'activo',
                                p_codigo,
                                p_descripcion,
                                v_id_catalogo_tipo
                              );
               
                    
            else            
                
                 UPDATE  param.tcatalogo 
                        SET 
                          id_usuario_mod = 1,
                          fecha_mod = now(),
                          codigo = p_codigo,
                          descripcion = p_descripcion,
                          id_catalogo_tipo = v_id_catalogo_tipo
                        WHERE 
                          id_catalogo = v_id_catalogo;
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