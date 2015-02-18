CREATE OR REPLACE FUNCTION wf.f_import_ttipo_columna (
  p_accion varchar,
  p_nombre_columna varchar,
  p_codigo_tabla varchar,
  p_codigo_tipo_proceso varchar,
  p_tipo_columna varchar,
  p_descripcion text,
  p_tamano varchar,
  p_campos_adicionales text,
  p_joins_adicionales text,
  p_formula_calculo text,
  p_grid_sobreescribe_filtro text,
  p_grid_campos_adicionales text,
  p_form_tipo_columna varchar,
  p_form_label varchar,
  p_form_es_combo varchar,
  p_form_combo_rec varchar,
  p_form_sobreescribe_config text,
  p_bd_prioridad	integer,
  p_form_grupo		integer
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_proceso			integer;
    v_id_tabla					integer;
    v_id_tipo_columna			integer;
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
    where tc.bd_nombre_columna = p_nombre_columna 
    and tc.id_tabla = v_id_tabla;    
        
    ALTER TABLE wf.ttipo_columna DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.ttipo_columna set estado_reg = 'inactivo',modificado = 1 
    	where id_tipo_columna = v_id_tipo_columna;
    else
        if (v_id_tipo_columna is null)then
           INSERT INTO  wf.ttipo_columna
            ( id_usuario_reg,              
              id_tabla,
              bd_nombre_columna,
              bd_tipo_columna,
              bd_descripcion_columna,
              bd_tamano_columna,
              bd_campos_adicionales,
              bd_joins_adicionales,
              bd_formula_calculo,
              grid_sobreescribe_filtro,
              grid_campos_adicionales,
              form_tipo_columna,
              form_label,
              form_es_combo,
              form_combo_rec,
              form_sobreescribe_config,
              ejecutado,
              modificado,
              bd_prioridad,
              form_grupo
            ) 
            VALUES (
              1,              
              v_id_tabla,
              p_nombre_columna,
              p_tipo_columna,
              p_descripcion,
              p_tamano,
              p_campos_adicionales,
              p_joins_adicionales,
              p_formula_calculo,
              p_grid_sobreescribe_filtro,
              p_grid_campos_adicionales,
              p_form_tipo_columna,
              p_form_label,
              p_form_es_combo,
              p_form_combo_rec,
              p_form_sobreescribe_config,
              'no',
              1,
              p_bd_prioridad,
              p_form_grupo
            );
        else            
            UPDATE wf.ttipo_columna  
            SET               
              bd_nombre_columna = p_nombre_columna,
              bd_tipo_columna = p_tipo_columna,
              bd_descripcion_columna = p_descripcion,
              bd_tamano_columna = p_tamano,
              bd_campos_adicionales = p_campos_adicionales,
              bd_joins_adicionales = p_joins_adicionales,
              bd_formula_calculo = p_formula_calculo,
              grid_sobreescribe_filtro = p_grid_sobreescribe_filtro,
              grid_campos_adicionales = p_grid_campos_adicionales,
              form_tipo_columna = p_form_tipo_columna,
              form_label = p_form_label,
              form_es_combo = p_form_es_combo,
              form_combo_rec = p_form_combo_rec,
              form_sobreescribe_config = p_form_sobreescribe_config,              
              modificado = 1,
              bd_prioridad = p_bd_prioridad,
              form_grupo = p_form_grupo             
            WHERE id_tipo_columna = v_id_tipo_columna;
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_columna ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;