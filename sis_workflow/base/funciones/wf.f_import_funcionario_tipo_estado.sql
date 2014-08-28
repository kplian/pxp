CREATE OR REPLACE FUNCTION wf.f_import_tfuncionario_tipo_estado (
  p_accion varchar,
  p_codigo_tipo_estado varchar,
  p_codigo_tipo_proceso varchar,
  p_ci varchar,
  p_codigo_depto varchar,
  p_regla varchar
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_estado			integer;    
    v_id_tipo_proceso			integer;
    v_id_funcionario			integer;
    v_id_depto					integer;
    v_id_funcionario_tipo_estado	integer;   
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;    
        
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
    	te.id_tipo_proceso = v_id_tipo_proceso; 
        
    select id_funcionario into v_id_funcionario
    from orga.vfuncionario fun    
    where fun.ci = p_ci;
    
    select id_depto into v_id_depto
    from param.tdepto dep
    where dep.codigo = p_codigo_depto; 
    
    select fte.id_funcionario_tipo_estado into v_id_funcionario_tipo_estado
    from wf.tfuncionario_tipo_estado fte
    where fte.id_tipo_estado = v_id_tipo_estado and fte.id_funcionario = v_id_funcionario and
    fte.id_depto = v_id_depto;     
        
    ALTER TABLE wf.tfuncionario_tipo_estado DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tfuncionario_tipo_estado set estado_reg = 'inactivo',modificado = 1 
    	where id_funcionario_tipo_estado = v_id_funcionario_tipo_estado;
    else
        if (v_id_funcionario_tipo_estado is null)then
           INSERT INTO 
              wf.tfuncionario_tipo_estado
            (
              id_usuario_reg,              
              id_tipo_estado,
              id_funcionario,
              id_depto,
              regla,
              modificado
            ) 
            VALUES (
              1,              
              v_id_tipo_estado,
              v_id_funcionario,
              v_id_depto,
              p_regla,
              1
            );
        else            
           UPDATE wf.tfuncionario_tipo_estado  
            SET               
              id_funcionario = v_id_funcionario,
              id_depto = v_id_depto,
              regla = p_regla,
              modificado = 1             
            WHERE id_funcionario_tipo_estado = v_id_funcionario_tipo_estado;
        end if;
    
	end if; 
    
    ALTER TABLE wf.tfuncionario_tipo_estado ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;