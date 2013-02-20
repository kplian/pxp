CREATE OR REPLACE FUNCTION wf.f_obtener_estado_tipo_proceso (
  in p_codigo_subsistema varchar,
  in p_codigo_tipo_proceso varchar,
  in p_estado_actual VARCHAR,
  in p_nodo VARCHAR,
  out p_estado VARCHAR[],
  out p_bandera VARCHAR[],
  out p_prioridad varchar[],
  out p_reglas VARCHAR[]
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_tipo_proceso
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
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
    g_registros2		record;
    v_consulta			varchar;
    v_consulta2			varchar;
    v_puntero			varchar;
    vv_bandera			integer;
    v_bandera			varchar;
    p_estadox  varchar[];
  	p_banderax varchar[];
  	p_prioridadx varchar[];
  	p_reglasx varchar[];
    p_iniciox varchar[];
    v_id_final_hijo integer;
    i			integer;
    j			integer;
    
BEGIN

	BEGIN   
    /*p_estado = ARRAY[null];
  	p_bandera = ARRAY[null];
  	p_prioridad = ARRAY[null];
  	p_reglas = ARRAY[null];*/
    vv_bandera = 0;
    
    if(p_codigo_tipo_proceso is null OR  rtrim(p_codigo_tipo_proceso,' ') = '')then
    	return;
    end if;
    
    --Obtener ID del tipo_estado inicio
    SELECT te.id_tipo_estado 
    INTO v_id_tipo_estado
    FROM wf.ttipo_proceso tp		
    LEFT JOIN wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso        
    WHERE tp.codigo ilike p_codigo_tipo_proceso and te.inicio ilike 'SI';
    
    --Para el caso que estado_actual sea nuelo                       
	if(p_estado_actual is null)then    	        
    	p_estado = array[v_id_tipo_estado];
    	return;
    end if;
        
    --Obtener todos los hijos del nodo inicio    
    v_consulta= 'WITH RECURSIVE sub_estados(id_tipo_estado_hijo, id_tipo_estado_padre, prioridad, regla) 
                          AS (
                              SELECT id_tipo_estado_hijo, id_tipo_estado_padre, prioridad, regla 
                              FROM wf.testructura_estado WHERE id_tipo_estado_padre ='||v_id_tipo_estado||'
                                UNION ALL
                              SELECT ee.id_tipo_estado_hijo, ee.id_tipo_estado_padre, ee.prioridad, ee.regla
                              FROM sub_estados sube, wf.testructura_estado ee
                              WHERE ee.id_tipo_estado_padre = sube.id_tipo_estado_hijo 
                             )     
                           SELECT array_agg(se.id_tipo_estado_padre) AS id_tipo_estado_padre, 
                           array_agg(se.id_tipo_estado_hijo) AS id_tipo_estado_hijo, 
                           array_agg(te.nombre_estado) AS nombre_estado, 
                           array_agg(te.disparador) AS disparador, 
                           array_agg(se.prioridad) AS prioridad, 
                           array_agg(se.regla) AS regla,
                           array_agg(te.inicio) AS inicio
                           FROM wf.ttipo_estado te 
                           INNER JOIN sub_estados se on se.id_tipo_estado_padre = te.id_tipo_estado';

	FOR g_registros in  execute(v_consulta) LOOP
    	
    	--Llenado de arrays       
        FOR i IN SELECT generate_subscripts( g_registros.id_tipo_estado_padre, 1 ) LOOP
        	
        	p_estadox = array_append(p_estadox, g_registros.nombre_estado[i]);
            p_banderax = array_append(p_banderax, g_registros.disparador[i]);
            p_prioridadx = array_append(p_prioridadx, g_registros.prioridad[i]::varchar);
            p_reglasx = array_append(p_reglasx, g_registros.regla[i]);  
            p_iniciox = array_append(p_iniciox, g_registros.inicio[i]);             
        END LOOP;
        v_id_final_hijo = g_registros.id_tipo_estado_hijo[array_length(g_registros.id_tipo_estado_hijo, 1)];
        v_consulta2 = 'SELECT ee.id_tipo_estado_padre, ee.id_tipo_estado_hijo, te.nombre_estado, te.disparador, ee.prioridad, ee.regla, te.inicio
                      FROM wf.ttipo_estado te 
                      INNER JOIN wf.testructura_estado ee on ee.id_tipo_estado_hijo = te.id_tipo_estado
                      WHERE te.id_tipo_estado ='||v_id_final_hijo;
            
        FOR g_registros2 in  execute(v_consulta2) LOOP
            p_estadox = array_append(p_estadox, g_registros2.nombre_estado);
            p_banderax = array_append(p_banderax, g_registros2.disparador);
            p_prioridadx = array_append(p_prioridadx, g_registros2.prioridad::varchar);
            p_reglasx = array_append(p_reglasx, g_registros2.regla);
            p_iniciox = array_append(p_reglasx, g_registros2.inicio);                
        END LOOP;
        --Fin llenado            
    END LOOP;
    
    IF( p_nodo ilike 'siguiente') THEN
        FOR j IN SELECT generate_subscripts(p_estadox, 1 ) LOOP    
            IF (p_estado_actual ilike p_estadox[j]) THEN
                vv_bandera = 1;
            END IF;
            IF(vv_bandera = 1) THEN
            
            	p_estado = array_append(p_estado, p_estadox[j]);
                
                IF (p_banderax[j] ilike 'si' and p_iniciox[j] ilike 'si') THEN
                	v_bandera = 'predecesor_disparador';
                ELSEIF (p_banderax[j] ilike 'si') THEN
                	v_bandera = 'disparador';
                ELSEIF (p_iniciox[j] ilike 'si') THEN
                	v_bandera = 'tiene_predecedor';               
                END IF;
                p_bandera = array_append(p_bandera, v_bandera);
                
                p_prioridad = array_append(p_prioridad, p_prioridadx[j]::varchar);
                
                p_reglas = array_append(p_reglas, p_reglasx[j]);
            END IF;            
        END LOOP;
    ELSEIF ( p_nodo ilike 'anterior') THEN
    	v_bandera = 0;
        FOR j IN SELECT generate_subscripts(p_estadox, 1 ) LOOP    
            IF (p_estado_actual ilike p_estadox[j]) THEN
                vv_bandera = 1;
            END IF;
            IF(vv_bandera = 1) THEN
            
            	p_estado = array_append(p_estado, p_estadox[j]);
                
                IF (p_banderax[j] ilike 'si' and p_inicio ilike 'si') THEN
                	v_bandera = 'predecesor_disparador';
                ELSEIF (p_banderax[j] ilike 'si') THEN
                	v_bandera = 'disparador';
                ELSEIF (p_iniciox[j] ilike 'si') THEN
                	v_bandera = 'tiene_predecedor';               
                END IF;
                p_bandera = array_append(p_bandera, v_bandera);
                
                p_prioridad = array_append(p_prioridad, p_prioridadx[j]::varchar);
                
                p_reglas = array_append(p_reglas, p_reglasx[j]);
            END IF;            
        END LOOP;     
            
    END IF; 
    
    return;
    END;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;