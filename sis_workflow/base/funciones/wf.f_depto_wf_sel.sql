--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_depto_wf_sel (
  p_id_usuario integer,
  p_id_tipo_estado integer,
  p_fecha date = now(),
  p_id_estado_wf integer = NULL::integer,
  p_count boolean = false,
  p_limit integer = 1,
  p_start integer = 0,
  p_filtro varchar = '0=0'::character varying
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		wf.f_depto_wf_sel
 DESCRIPCIÓN: 	funcion lista los funcioanriso que correponden al estado del work flow
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			19/03/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/

-------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*


  p_id_usuario integer,                                identificador del actual usuario de sistema
  p_id_tipo_estado integer,                            idnetificador del tipo estado del que se quiere obtener el listado de funcionario  (se correponde con tipo_estado que le sigue a id_estado_wf proporcionado)                       
  p_fecha date = now(),                                fecha  --para verificar asginacion de cargo con organigrama
  p_id_estado_wf integer = NULL::integer,              identificaro de estado_wf actual en el proceso_wf
  p_count boolean = false,                             si queremos obtener numero de funcionario = true por defecto false
  p_limit integer = 1,                                 los siguiente son parametros para filtrar en la consulta
  p_start integer = 0,
  p_filtro varchar = '0=0'::character varying




*/

DECLARE
	g_registros  		record;
    v_depto_asignacion    varchar;
    v_nombre_depto_func_list   varchar;
    
    v_consulta varchar;
    v_nombre_funcion varchar;
    v_resp varchar;

BEGIN
  v_nombre_funcion ='wf.f_depto_wf_sel';

    --recupera el tipo de listado:   todos, listado, funcion_listado  
    
    select 
      te.depto_asignacion,
      te.nombre_depto_func_list
     into 
      v_depto_asignacion,
      v_nombre_depto_func_list
    from wf.ttipo_estado te 
    where te.id_tipo_estado = p_id_tipo_estado;
    
    

    
  
  if v_depto_asignacion = 'ninguno' then
          IF p_count THEN
            -- FOR g_registros in (select 1::bigint from (select 1 ) aa)  LOOP   
             
             FOR g_registros in (select 0::bigint as total)   LOOP   
                           
                            RETURN NEXT g_registros;
             END LOOP;
        
         else
       		  raise exception 'no se admiten departamentos en este estado'; 
         END IF;
       
       
  elseif  v_depto_asignacion = 'anterior' then
  
           IF p_count=FALSE then
           
            v_consulta= 'select 
                         dep.id_depto,
                         dep.codigo as codigo_depto,
                         dep.nombre_corto as nombre_corto_depto,
                         dep.nombre as nombre_depto,
                         1 as prioridad
                         FROM
                         wf.testado_wf ew
                         inner join param.tdepto dep on dep.id_depto = ew.id_depto
                         WHERE ew.id_estado_wf='||p_id_estado_wf;
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP;    
           
           
           ELSE
                v_consulta= 'select 
                          COUNT(DISTINCT( dep.id_depto))
                          FROM
                         wf.testado_wf ew
                         inner join param.tdepto dep on dep.id_depto = ew.id_depto
                         WHERE ew.id_estado_wf='||p_id_estado_wf;
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP; 
            
           END IF;    
  
  
      elseif v_depto_asignacion = 'depto_listado' then
               IF p_count=FALSE then
                      v_consulta='select DISTINCT (dep.id_depto),
                                         dep.codigo as codigo_depto,
                                         dep.nombre_corto as nombre_corto_depto,
                                         dep.nombre as nombre_depto,
                                         1 as prioridad
                                  from param.tdepto dep
                                       inner join wf.tfuncionario_tipo_estado fte on fte.id_depto = dep.id_depto 
                                       and fte.id_tipo_estado = '||p_id_tipo_estado||'
                                   where '||p_filtro||'
                                         order by dep.codigo
                                         limit '|| p_limit::varchar||' offset '||p_start::varchar;
                        
          
                       -- listado de todos los funcionarios en la tabla 
                       FOR g_registros in execute (v_consulta)LOOP     
                         RETURN NEXT g_registros;
                       END LOOP;
             
                ELSE
                
                      v_consulta='select 
                          COUNT(DISTINCT(dep.id_depto))
                          from param.tdepto dep
                                       inner join wf.tfuncionario_tipo_estado fte on fte.id_depto = dep.id_depto 
                                       and fte.id_tipo_estado = '||p_id_tipo_estado||'
                                   where '||p_filtro;
                        
          
                       -- listado de todos los funcionarios en la tabla 
                       FOR g_registros in execute (v_consulta)LOOP     
                         RETURN NEXT g_registros;
                       END LOOP;
                
                
                END IF;
     
     
     
     elseif v_depto_asignacion = 'depto_func_list' then  
      
            -----------------------------------------------------------------------------------
            --  aqui se agregan funciones de listado especiales segun  el sistema que se integre
            ------------------------------------------------------------------------------------
           
           
            ------------------------------
            --ADQUISICIONES
            -----------------------------
            
            IF v_nombre_depto_func_list ='ADQ_DEPTO_SOL'  THEN
            
                       IF p_count=FALSE then
                   
                            --recuperamos el RPC de la solicitud de COMPRA
                            v_consulta='select
                                         DISTINCT (dep.id_depto),
                                         dep.codigo as codigo_depto,
                                         dep.nombre_corto as nombre_corto_depto,
                                         dep.nombre as nombre_depto,
                                         1 as prioridad
                                from adq.tsolicitud sol
                                inner join param.tdepto dep on dep.id_depto = sol.id_depto
                                where sol.id_estado_wf = '||p_id_estado_wf||'  
                                and '||p_filtro||'
                                  order by  dep.codigo
                                  limit '|| p_limit::varchar||' offset '||p_start::varchar;   
                                          
                               FOR g_registros in execute (v_consulta)LOOP     
                                 RETURN NEXT g_registros;
                               END LOOP;
                      
                       ELSE
                       
                              v_consulta='select
                                  COUNT(dep.id_depto) as total
                                from adq.tsolicitud sol
                                inner join param.tdepto dep on dep.id_depto = sol.id_depto
                                where sol.id_estado_wf = '||p_id_estado_wf||'  
                                and '||p_filtro;   
                                          
                               FOR g_registros in execute (v_consulta)LOOP     
                                 RETURN NEXT g_registros;
                               END LOOP;
                       
                       
                       END IF;
               
            
            ELSE
            
              raise exception ' Funcion de listado no identificada (%)',v_nombre_depto_func_list;
            
            END IF;
      else
    
    
      raise exception ' El tipo de Asignacion (%)  no es conocido',v_tipo_asignacion;
    
    end if; 
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;

				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;