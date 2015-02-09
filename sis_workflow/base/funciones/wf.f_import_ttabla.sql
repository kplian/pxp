CREATE OR REPLACE FUNCTION wf.f_import_ttabla (
  p_accion varchar,
  p_codigo_tabla varchar,
  p_codigo_tipo_proceso varchar,
  p_nombre_tabla varchar,
  p_descripcion text,
  p_scripts_extras text,
  p_vista_tipo varchar,
  p_vista_posicion varchar,
  p_vista_codigo_tabla_maestro varchar,
  p_vista_campo_ordenacion varchar,
  p_vista_dir_ordenacion varchar,
  p_vista_campo_maestro varchar,
  p_vista_scripts_extras text,
  p_menu_nombre varchar,
  p_menu_icono varchar,
  p_menu_codigo varchar,
  p_vista_estados_new text,
  p_vista_estados_delete text
)
RETURNS varchar AS
$body$
DECLARE
	v_vista_id_tabla_maestro 	integer;    
    v_id_tipo_proceso			integer;
    v_id_tabla					integer;
    v_vista_estados_new			varchar[];
    v_vista_estados_delete		varchar[];
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;
    
    select id_tabla into v_id_tabla
    from wf.ttabla ta
    inner join wf.ttipo_proceso tp
    	on tp.id_tipo_proceso = ta.id_tipo_proceso       
    where ta.bd_codigo_tabla = p_codigo_tabla 
    and tp.codigo = p_codigo_tipo_proceso;
    
    select id_tabla into v_vista_id_tabla_maestro
    from wf.ttabla ta
    inner join wf.ttipo_proceso tp
    	on tp.id_tipo_proceso = ta.id_tipo_proceso    
    where ta.bd_codigo_tabla = p_vista_codigo_tabla_maestro 
    and tp.codigo = p_codigo_tipo_proceso;
    
    if (p_vista_estados_new is not null) then
    	v_vista_estados_new = string_to_array(p_vista_estados_new,',')::varchar[];
    end if;
    
    if (p_vista_estados_delete is not null) then
    	v_vista_estados_delete = string_to_array(p_vista_estados_new,',')::varchar[];
    end if;
    
    ALTER TABLE wf.ttabla DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttabla set estado_reg = 'inactivo',modificado = 1 
    	where id_tabla = v_id_tabla;
    else
        if (v_id_tabla is null)then
           INSERT INTO wf.ttabla
            (
              id_usuario_reg,              
              id_tipo_proceso,
              bd_nombre_tabla,
              bd_codigo_tabla,
              bd_descripcion,
              bd_scripts_extras,
              vista_tipo,
              vista_posicion,
              vista_id_tabla_maestro,
              vista_campo_ordenacion,
              vista_dir_ordenacion,
              vista_campo_maestro,
              vista_scripts_extras,
              menu_nombre,
              menu_icono,
              menu_codigo,
              ejecutado,
              script_ejecutado,
              vista_estados_new,
              vista_estados_delete,
              modificado
            ) 
            VALUES (
              1,              
              v_id_tipo_proceso,
              p_nombre_tabla,
              p_codigo_tabla,
              p_descripcion,
              p_scripts_extras,
              p_vista_tipo,
              p_vista_posicion,
              v_vista_id_tabla_maestro,
              p_vista_campo_ordenacion,
              p_vista_dir_ordenacion,
              p_vista_campo_maestro,
              p_vista_scripts_extras,
              p_menu_nombre,
              p_menu_icono,
              p_menu_codigo,
              'no',
              'no',
              v_vista_estados_new,
              v_vista_estados_delete,
              1
            );
        else            
            UPDATE 
              wf.ttabla  
            SET    
              bd_nombre_tabla = p_nombre_tabla,
              bd_codigo_tabla = p_codigo_tabla,
              bd_descripcion = p_descripcion,
              bd_scripts_extras = p_scripts_extras,
              vista_tipo = p_vista_tipo,
              vista_posicion = p_vista_posicion,
              vista_id_tabla_maestro = v_vista_id_tabla_maestro,
              vista_campo_ordenacion = p_vista_campo_ordenacion,
              vista_dir_ordenacion = p_vista_dir_ordenacion,
              vista_campo_maestro = p_vista_campo_maestro,
              vista_scripts_extras = p_vista_scripts_extras,
              menu_nombre = p_menu_nombre,
              menu_icono = p_menu_icono,
              menu_codigo = p_menu_codigo,              
              vista_estados_new = v_vista_estados_new,
              vista_estados_delete = v_vista_estados_delete,
              modificado = 1
             
            WHERE id_tabla = v_id_tabla
;       	
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttabla ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;