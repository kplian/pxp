--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_diparador_predecesor_proceso (
  p_codigo_tipo_proceso varchar,
  p_nombre_estado varchar,
  p_bandera varchar,
  out p_proceso varchar [],
  out p_estado varchar []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_tipo_proceso
 DESCRIPCION: 	Devuelve:
 				array varchar PROCESO, con listado de codigos de proceso
				array varchar ESTADO,  con lisatdo de nombres de estado
				
                Recibe:
 				nombre_estado
                código del tipo_proceso
                bandera -> predecesor o disparador
 AUTOR: 		KPLIAN(FRH)
 FECHA:			25/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE	
    g_registros			record;   
    v_consulta			varchar;
    v_id_tipo_estado 	integer;
    v_id_tipo_proceso  integer;
    v_nombre_tipo_estado varchar;
    i	integer;
    
BEGIN

	BEGIN   
      
    if(p_codigo_tipo_proceso is null OR  rtrim(p_codigo_tipo_proceso,' ') = '')then
    	return;
    end if;
    
 
    SELECT id_tipo_proceso FROM wf.ttipo_proceso tp
    INTO v_id_tipo_proceso
    WHERE codigo ilike p_codigo_tipo_proceso;
    
    IF( p_bandera ilike 'disparador') THEN          
      	--Obtener procesos hijos     	
    	v_consulta = 'SELECT array_agg(te.id_tipo_proceso) AS id_tipo_proceso_padre, 
                      array_agg(tp.id_tipo_proceso::varchar) AS id_tipo_proceso, 
                      array_agg(te.nombre_estado) AS nombre_estado, 
                      array_agg(tp.codigo) AS codigo_proceso 
                      FROM wf.ttipo_estado te
                      INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_estado = te.id_tipo_estado and te.estado_reg = ''activo'' 
                      WHERE te.nombre_estado ilike '''||p_nombre_estado||''' and te.id_tipo_proceso='||v_id_tipo_proceso;
                  
    ELSEIF( p_bandera ilike 'predecesor') THEN
    	--Obtener todos los procesos padres (predecesor)      
    	v_consulta = 'SELECT array_agg(tp.id_tipo_proceso::varchar) AS id_tipo_proceso, 
                      array_agg(te.id_tipo_proceso) AS id_tipo_proceso_hijo, 
                      array_agg(tp.codigo) as codigo_proceso
                      from wf.ttipo_proceso tp
                      INNER JOIN wf.ttipo_estado te ON te.id_tipo_estado = tp.id_tipo_estado and te.estado_reg = ''activo'' 
                      WHERE te.nombre_estado ilike '''||p_nombre_estado||''' and te.id_tipo_proceso ='||v_id_tipo_proceso;
    ELSE
    	return;
    END IF;
                
	FOR g_registros in  execute(v_consulta) LOOP
    	
    	FOR i IN SELECT generate_subscripts(g_registros.id_tipo_proceso, 1 ) LOOP
        	    	
            IF( p_bandera ilike 'disparador') THEN
                SELECT te.nombre_estado 
                INTO v_nombre_tipo_estado
                FROM wf.ttipo_proceso tp		
                LEFT JOIN wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso  and te.estado_reg = 'activo'      
                WHERE tp.id_tipo_proceso::varchar ilike g_registros.id_tipo_proceso[i] and te.inicio ilike 'SI';
                
                p_estado = array_append(p_estado, v_nombre_tipo_estado); 
                
            ELSEIF ( p_bandera ilike 'predecesor') THEN
            	SELECT te.nombre_estado 
                INTO v_nombre_tipo_estado
                FROM wf.ttipo_proceso tp		
                LEFT JOIN wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso     and te.estado_reg = 'activo'    
                WHERE tp.id_tipo_proceso::varchar ilike g_registros.id_tipo_proceso[i] and te.disparador ilike 'SI'; 
                
                p_estado = array_append(p_estado, v_nombre_tipo_estado);
            END IF;  
              
            p_proceso = g_registros.codigo_proceso;     
    	END LOOP;
    END LOOP;
        
    return;
    END;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;