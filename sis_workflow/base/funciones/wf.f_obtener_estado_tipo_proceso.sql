--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_estado_tipo_proceso (
  p_codigo_subsistema varchar,
  p_codigo_tipo_proceso varchar,
  p_estado_actual varchar,
  p_nodo varchar,
  out p_estado varchar [],
  out p_bandera varchar [],
  out p_prioridad varchar [],
  out p_reglas varchar []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_tipo_proceso
 DESCRIPCION: 	Devuelve:
 				un array varchar (ESTADO) 
                un array varchar bandera (BANDERA)
                un array prioridad (PRIORIDAD)
                un array reglas (REGLAS)
				Recive:
 				codigo_subsistema,
                codigo_tipo_proceso,
                estado_actual -> NULL o nombre_estado
                nodo -> siguiente o anterior
 AUTOR: 		KPLIAN(FRH)
 FECHA:			21/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
	v_id_tipo_estado 	integer;
    g_registros			record;   
    v_consulta			varchar;    
    v_bandera			varchar;
    p_estadox  varchar[];
  	p_banderax varchar[];
  	p_prioridadx varchar[];
  	p_reglasx varchar[];
    p_iniciox varchar[];
    p_id_tipo_estadox varchar[];
    v_id_tipo_proceso integer;
    i			integer;
    j			integer;
    v_nombre_tipo_estado varchar;
    v_count_procesos_referenciados integer;
    
BEGIN

	BEGIN   
      
    if(p_codigo_tipo_proceso is null OR  rtrim(p_codigo_tipo_proceso,' ') = '')then
    	return;
    end if;
    
    --Obtener nombre del tipo_estado inicio
    SELECT te.nombre_estado 
    INTO v_nombre_tipo_estado
    FROM wf.ttipo_proceso tp		
    LEFT JOIN wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso   and te.estado_reg = 'activo'     
    WHERE tp.codigo ilike p_codigo_tipo_proceso and te.inicio ilike 'SI' and tp.estado_reg = 'activo'; 
    
    --Para el caso que estado_actual sea null, devuelve el nombre del estado inicial del tipo_proceso                    
	if(p_estado_actual is null)then    	        
    	p_estado = array[v_nombre_tipo_estado];
    	return;
    end if;
    
    --Obtener ID del tipo_estado actual
    SELECT te.id_tipo_estado 
    INTO v_id_tipo_estado
    FROM wf.ttipo_proceso tp		
    LEFT JOIN wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso   and te.estado_reg = 'activo'      
    WHERE te.nombre_estado ilike p_estado_actual and tp.codigo ilike p_codigo_tipo_proceso and tp.estado_reg = 'activo';    
    
    --Validar si existe el estado actual enviado como parametro
    if(v_id_tipo_estado is null)then 
    	return;
    end if;
    
    SELECT id_tipo_proceso FROM wf.ttipo_proceso tp
    INTO v_id_tipo_proceso
    WHERE codigo ilike p_codigo_tipo_proceso  and tp.estado_reg = 'activo';
    
    IF( p_nodo ilike 'siguiente') THEN          
      	--Obtener todos los hijos del nodo actual
      	--Buscar nodos siguientes
    	v_consulta = 'SELECT array_agg(ee.id_tipo_estado_hijo::varchar) AS id_tipo_estado, 
                                   array_agg(te.nombre_estado) AS nombre_estado, 
                                   array_agg(te.disparador) AS disparador, 
                                   array_agg(ee.prioridad::varchar) AS prioridad, 
                                   array_agg(ee.regla) AS regla,
                                   array_agg(te.inicio) AS inicio
                  FROM wf.ttipo_estado te 
                  INNER JOIN wf.testructura_estado ee on ee.id_tipo_estado_hijo = te.id_tipo_estado and ee.estado_reg = ''activo''
                  WHERE te.estado_reg = ''activo'' and  ee.id_tipo_estado_padre='||v_id_tipo_estado/*||'and te.id_tipo_proceso='||v_id_tipo_proceso*/;
                  
    ELSEIF( p_nodo ilike 'anterior') THEN
    	--Obtener todos los padres del nodo actual
        --Buscar anteriores
    	v_consulta = 'SELECT array_agg(ee.id_tipo_estado_padre::varchar) AS id_tipo_estado,                            
                                             array_agg(te.nombre_estado) AS nombre_estado, 
                                             array_agg(te.disparador) AS disparador, 
                                             array_agg(ee.prioridad::varchar) AS prioridad, 
                                             array_agg(ee.regla) AS regla,
                                             array_agg(te.inicio) AS inicio
                  FROM wf.ttipo_estado te 
                  INNER JOIN wf.testructura_estado ee on ee.id_tipo_estado_padre = te.id_tipo_estado and ee.estado_reg = ''activo''
                  WHERE  te.estado_reg = ''activo'' and ee.id_tipo_estado_hijo='||v_id_tipo_estado/*||'and te.id_tipo_proceso='||v_id_tipo_proceso*/;
    END IF;
                
	FOR g_registros in  execute(v_consulta) LOOP
    	
    	--Llenado de arrays       
        p_id_tipo_estadox = array_cat(p_estadox, g_registros.id_tipo_estado);
        p_estadox = array_cat(p_estadox, g_registros.nombre_estado);
        p_banderax = array_cat(p_banderax, g_registros.disparador);
        p_prioridadx = array_cat(p_prioridadx, g_registros.prioridad);
        p_reglasx = array_cat(p_reglasx, g_registros.regla);  
        p_iniciox = array_cat(p_iniciox, g_registros.inicio);   
        --Fin llenado            
    END LOOP;
    
    IF( p_nodo ilike 'siguiente') THEN
        FOR i IN SELECT generate_subscripts(p_estadox, 1 ) LOOP               
                     
            	p_estado = array_append(p_estado, p_estadox[i]);
                
                SELECT count(te.id_tipo_proceso) from wf.ttipo_estado te
                INTO v_count_procesos_referenciados
                INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_estado = te.id_tipo_estado and tp.estado_reg = 'activo'
                WHERE    tp.id_tipo_proceso != v_id_tipo_proceso 
                     and tp.id_tipo_estado::varchar ilike p_id_tipo_estadox[i] and te.inicio ilike 'SI';
                
                IF (v_count_procesos_referenciados >= 1 and p_banderax[i] ilike 'si') THEN
                	v_bandera = 'predecesor_disparador';
                ELSEIF (v_count_procesos_referenciados >= 1) THEN
                	v_bandera = 'tiene_predecedor';
                ELSEIF (p_banderax[i] ilike 'si') THEN
                	v_bandera = 'disparador';                               
                END IF;
                p_bandera = array_append(p_bandera, v_bandera);
                
                p_prioridad = array_append(p_prioridad, p_prioridadx[i]);                
                p_reglas = array_append(p_reglas, p_reglasx[i]);
                       
        END LOOP;
    ELSEIF ( p_nodo ilike 'anterior') THEN
    	
        FOR j IN SELECT generate_subscripts(p_estadox, 1 ) LOOP              
                        
            	p_estado = array_append(p_estado, p_estadox[j]);
                
                SELECT count(te.id_tipo_proceso)
                from wf.ttipo_estado te
                INTO v_count_procesos_referenciados
                INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_estado = te.id_tipo_estado and tp.estado_reg = 'activo'
                WHERE    tp.id_tipo_proceso != v_id_tipo_proceso 
                     and te.estado_reg = 'activo'
                     and tp.id_tipo_estado::varchar ilike p_id_tipo_estadox[j] and te.inicio ilike 'SI';
                
                IF (v_count_procesos_referenciados >= 1 and p_banderax[j] ilike 'si') THEN
                	v_bandera = 'predecesor_disparador';
                ELSEIF (v_count_procesos_referenciados >= 1) THEN
                	v_bandera = 'tiene_predecedor';
                ELSEIF (p_banderax[j] ilike 'si') THEN
                	v_bandera = 'disparador';                               
                END IF;
                p_bandera = array_append(p_bandera, v_bandera);
                
                p_prioridad = array_append(p_prioridad, p_prioridadx[j]);                
                p_reglas = array_append(p_reglas, p_reglasx[j]);
                      
        END LOOP;      
            
    END IF;     
    return;
    END;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;