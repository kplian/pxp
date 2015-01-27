CREATE OR REPLACE FUNCTION wf.f_obtener_tipos_procesos (
  p_nombre_tipo_estado varchar
)
RETURNS varchar [] AS
$body$
DECLARE
  v_tipos_procesos 	record;
  var_id_tipo_estado 	integer;
  v_res				varchar[];
  
BEGIN
	select te.id_tipo_estado into var_id_tipo_estado from wf.ttipo_estado te
    where te.nombre_estado=p_nombre_tipo_estado;
	
    FOR v_tipos_procesos IN select tp.codigo from wf.ttipo_proceso tp 
    				  	  where tp.id_tipo_estado=var_id_tipo_estado
    LOOP
    	v_res=array_append(v_res,v_tipos_procesos.codigo);
    END LOOP;
    return v_res;    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;