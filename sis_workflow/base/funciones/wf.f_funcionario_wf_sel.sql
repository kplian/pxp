--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_funcionario_wf_sel (
  p_id_usuario integer,
  p_id_tipo_estado integer,
  p_fecha date = now(),
  p_id_estado_wf integer = NULL::integer,
  p_count boolean = false,
  p_limit integer = 1,
  p_start integer = 0,
  p_filtro varchar = '0=0'::character varying,
  p_id_depto_wf integer = 0
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		PARAM.f_aprobadores_sel
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
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*
pm_id_usuario                               integer (si))

*/

DECLARE
	g_registros  		record;
    v_tipo_asignacion    varchar;
    v_nombre_func_list   varchar;
    
    v_consulta varchar;
    v_nombre_funcion varchar;
    v_resp varchar;
    v_id_proceso_wf integer;
    v_campos varchar;
    v_as varchar;

BEGIN

      v_nombre_funcion = 'wf.f_funcionario_wf_sel';


   --raise exception 'LLEGA .......';

    --recupera el tipo de listado:   todos, listado, funcion_listado  
    
    --no son  admitidos  las asignacion de dapartamento en esta funcion
    
    
    select 
      te.tipo_asignacion,
      te.nombre_func_list
     into 
      v_tipo_asignacion,
      v_nombre_func_list
    from wf.ttipo_estado te 
    where te.id_tipo_estado = p_id_tipo_estado;
    
    

    if v_tipo_asignacion = 'depto_listado' or v_tipo_asignacion = 'depto_fun_list'  then
    
       raise exception 'No se admiten en esta funcion  listados por departamentos, solo son validos listados de funcionarios';  
    
    end if;
    
  
  if v_tipo_asignacion = 'ninguno' then
  
       -- 'Se fuerza el retorno registro vacios para que la consulta no de error'; 
       -- cuando el estado sea ninguno se ve convenieto bloquear el combo 
       
       IF p_count=FALSE then
           
           v_consulta= 'select 
                         0 as id_funcionario,
                         ''---''::text as  desc_funcionario,
                         ''---''::text  as desc_funcionario_cargo,
                         1 as prioridad
                         FROM
                             wf.testado_wf ew
                         WHERE ew.id_estado_wf=0';
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP;    
           
           
           ELSE
           
               --retorna 0
                v_consulta= 'select 
                             0
                            FROM
                             wf.testado_wf ew
                           WHERE ew.id_estado_wf=0';
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP; 
            
           END IF;
       
       
       
  elseif  v_tipo_asignacion = 'anterior' then
  
           IF p_count=FALSE then
           
            v_consulta= 'select 
                         fun.id_funcionario,
                         fun.desc_funcionario1 as  desc_funcionario,
                         ''---''::text  as desc_funcionario_cargo,
                         1 as prioridad
                         FROM
                         wf.testado_wf ew
                         inner join orga.vfuncionario fun on fun.id_funcionario = ew.id_funcionario
                         WHERE ew.id_estado_wf='||p_id_estado_wf;
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP;    
           
           
           ELSE
                v_consulta= 'select 
                          COUNT(DISTINCT(fun.id_funcionario))
                         FROM
                         wf.testado_wf ew
                         inner join orga.vfuncionario fun on fun.id_funcionario = ew.id_funcionario
                         WHERE ew.id_estado_wf='||p_id_estado_wf;
                         
                       FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                       END LOOP; 
            
           END IF;    
  
         elseif v_tipo_asignacion = 'todos' then
  
  
           IF p_count=FALSE then
           
           
                 v_consulta= 'select 
                            DISTINCT(fun.id_funcionario),
                            fun.desc_funcionario1 as desc_funcionario,
                            fun.nombre_cargo::text  as desc_funcionario_cargo,
                            1 as prioridad
                            
                           from orga.vfuncionario_cargo fun
                           where 
                            (fun.fecha_asignacion::date  < '''||p_fecha ||''' and  ( fun.fecha_finalizacion >= '''||p_fecha||''' or fun.fecha_finalizacion is NULL))
                            and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;
                 
              
                      -- listado de todos los funcionarios en la tabla 
                          FOR g_registros in execute(v_consulta) LOOP     
                           RETURN NEXT g_registros;
                         END LOOP;
                   
              ELSE
                   
                   
                    v_consulta= 'select 
                                   COUNT(DISTINCT(fun.id_funcionario))
                                 from orga.vfuncionario_cargo fun
                                 where 
                                   (fun.fecha_asignacion::date  < '''|| p_fecha::varchar ||''' and ( fun.fecha_finalizacion >= '''||p_fecha||''' or fun.fecha_finalizacion is NULL))
                                    and '||p_filtro;
                  
                         FOR g_registros in execute(v_consulta) LOOP              
                           RETURN NEXT g_registros;
                         END LOOP;
            
            
            END IF ;
            
            
            
    elseif v_tipo_asignacion = 'listado' then
    
        select 
        e.id_proceso_wf
        into
        v_id_proceso_wf
        from wf.testado_wf e
        where e.id_estado_wf = p_id_estado_wf;
    
          
           IF p_count=FALSE then
           
                 v_consulta='select 
                    DISTINCT(fun.id_funcionario),
                    fun.desc_funcionario1 as desc_funcionario,
                    ''---''::text  as desc_funcionario_cargo,
                    1 as prioridad
                    
                   from orga.vfuncionario fun
                   inner join wf.tfuncionario_tipo_estado fte 
                       on fte.id_funcionario = fun.id_funcionario 
                       and fte.id_tipo_estado = '||p_id_tipo_estado||'
                   where  '||p_filtro||'
                           and (wf.f_evaluar_regla_wf (
                                                     '||COALESCE(p_id_usuario::varchar,'NULL')||', 
                                                     '||COALESCE(v_id_proceso_wf::varchar,'NULL')||', 
                                                     fte.regla,
                                                     '||COALESCE(p_id_tipo_estado::varchar,'NULL')||', 
                                                     '||COALESCE(p_id_estado_wf::varchar,'NULL')||'))
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;
                  
    
                 -- listado de todos los funcionarios en la tabla 
                 FOR g_registros in execute (v_consulta)LOOP     
                   RETURN NEXT g_registros;
                 END LOOP;
       
          ELSE
          
            	v_consulta='select 
                    COUNT(DISTINCT(fun.id_funcionario))
                    from orga.vfuncionario fun
                    inner join wf.tfuncionario_tipo_estado fte 
                       on fte.id_funcionario = fun.id_funcionario 
                       and fte.id_tipo_estado = '||p_id_tipo_estado||'
                    where '||p_filtro||'
                           and (wf.f_evaluar_regla_wf (
                                                     '||COALESCE(p_id_usuario::varchar,'NULL')||', 
                                                     '||COALESCE(v_id_proceso_wf::varchar,'NULL')||', 
                                                     fte.regla,
                                                     '||COALESCE(p_id_tipo_estado::varchar,'NULL')||', 
                                                     '||COALESCE(p_id_estado_wf::varchar,'NULL')||'))';
                  
                
                  
                 -- listado de todos los funcionarios en la tabla 
                 FOR g_registros in execute (v_consulta)LOOP     
                   RETURN NEXT g_registros;
                 END LOOP;
          
          
          END IF;
  
    elseif v_tipo_asignacion = 'segun_depto' then
          
          IF p_id_depto_wf = 0 THEN
              RAISE exception 'El tipo de aginacion segun depto necesita de referencia un depto';
          END IF;
          
          IF p_count=FALSE then
           
                 v_consulta='select
                            fun.id_funcionario,
                            fun.desc_funcionario1 as desc_funcionario,
                            ''---''::text  as desc_funcionario_cargo,
                            1 as prioridad
                            
                          from param.tdepto_usuario du
                          inner join segu.tusuario  usu on usu.id_usuario = du.id_usuario
                          inner join orga.vfuncionario_persona fun on usu.id_persona = fun.id_persona

                          where   du.id_depto = '||COALESCE(p_id_depto_wf,0)::varchar ||'  and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;
                  
    
                 -- listado de todos los funcionarios en la tabla 
                 FOR g_registros in execute (v_consulta)LOOP     
                   RETURN NEXT g_registros;
                 END LOOP;
       
          ELSE
          
            	v_consulta='select 
                    COUNT(DISTINCT(fun.id_funcionario))
                    from param.tdepto_usuario du
                          inner join segu.tusuario  usu on usu.id_usuario = du.id_usuario
                          inner join orga.vfuncionario_persona fun on usu.id_persona = fun.id_persona

                          where   du.id_depto = '||COALESCE(p_id_depto_wf,0)::varchar ||' and ('||p_filtro||')';
                  
                 -- listado de todos los funcionarios en la tabla 
                 FOR g_registros in execute (v_consulta)LOOP     
                   RETURN NEXT g_registros;
                 END LOOP;
          
          
          END IF;
     
     
     
     elseif v_tipo_asignacion = 'funcion_listado' then  
      
      -----------------------------------------------------------------------------------
      --  aqui se agregan funciones de listado especiales segune el sistema que se integre
      ------------------------------------------------------------------------------------
     
     
      ------------------------------
      --ADQUISICIONES
      -----------------------------
      
      IF v_nombre_func_list ='ADQ_RPC_SOL_COMPRA'  THEN
      
                 IF p_count=FALSE then
             
                      --recuperamos el RPC de la solicitud de COMPRA
                      v_consulta='select
                            fun.id_funcionario,
                            fun.desc_funcionario1 as desc_funcionario,
                            ''RPC''::text  as desc_funcionario_cargo,
                            1 as prioridad
                          from adq.tsolicitud sol
                          inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_rpc
                          where sol.id_estado_wf = '||p_id_estado_wf||'  
                          and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;   
                                    
                         FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                
                 ELSE
                 
                        v_consulta='select
                            COUNT(fun.id_funcionario)
                          from adq.tsolicitud sol
                          inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_rpc
                          where sol.id_estado_wf = '||p_id_estado_wf||'  
                          and '||p_filtro;   
                                    
                         FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                 
                 
                 END IF;
       /*
         Recuperamos el RPC de la cotizacion
       
       */
       
       ELSEIF v_nombre_func_list ='ADQ_RPC_COT_COMPRA'  THEN
      
                 IF p_count=FALSE then
             
                      --recuperamos el RPC de la solicitud de COMPRA
                      v_consulta='select
                            fun.id_funcionario,
                            fun.desc_funcionario1 as desc_funcionario,
                            ''RPC''::text  as desc_funcionario_cargo,
                            1 as prioridad
                          from adq.tsolicitud sol
                          inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_rpc
                          inner join  adq.tproceso_compra pro on pro.id_solicitud = sol.id_solicitud
                          inner join adq.tcotizacion cot on cot.id_proceso_compra = pro.id_proceso_compra 
                          
                          where cot.id_estado_wf = '||p_id_estado_wf||'   
                          and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;   
                                    
                         FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                
                 ELSE
                 
                        v_consulta='select
                            COUNT(fun.id_funcionario)
                             from adq.tsolicitud sol
                          inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_rpc
                          inner join  adq.tproceso_compra pro on pro.id_solicitud = sol.id_solicitud
                          inner join adq.tcotizacion cot on cot.id_proceso_compra = pro.id_proceso_compra 
                          
                          where cot.id_estado_wf = '||p_id_estado_wf||'  
                          and '||p_filtro;   
                                    
                         FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                 
                 
                 END IF;
       /*
         Recuperamos  el funcionario solicitante de la solicitud partiendo del plan de pago
       
       */
      
       ELSEIF v_nombre_func_list ='ADQ_SOL_COMPRA'  THEN
       
               IF p_count=FALSE then
                 -- sabemos que p_id_estado_wf  corresponde al estado del plan de pagos
                    
                    v_consulta='select
                          fun.id_funcionario,
                          fun.desc_funcionario1 as desc_funcionario,
                          ''Solicitante''::text  as desc_funcionario_cargo,
                          1 as prioridad
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario
                        inner join adq.tproceso_compra p on p.id_solicitud = sol.id_solicitud
                        inner join adq.tcotizacion c on c.id_proceso_compra = p.id_proceso_compra
                        inner join tes.tplan_pago pp on pp.id_obligacion_pago = c.id_obligacion_pago  
                        where pp.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;
                        
                          FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                 ELSE
                       v_consulta='select
                          COUNT(fun.id_funcionario)
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario
                        inner join adq.tproceso_compra p on p.id_solicitud = sol.id_solicitud
                        inner join adq.tcotizacion c on c.id_proceso_compra = p.id_proceso_compra
                        inner join tes.tplan_pago pp on pp.id_obligacion_pago = c.id_obligacion_pago  
                        where pp.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro;
                        
                          FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		  END LOOP;
                 
                 
                 END IF;
       --Adquisiciones aprobacion del funcionario aprobador
       ELSEIF v_nombre_func_list ='ADQ_APR_SOL_COMPRA'  THEN
       
               IF p_count=FALSE then
                 --recuperamos el aprobador de la solictud de compra
                 --recuperamos el RPC de la solicitud de COMPRA
                    v_consulta='select
                          fun.id_funcionario,
                          fun.desc_funcionario1 as desc_funcionario,
                          ''Gerente''::text  as desc_funcionario_cargo,
                          1 as prioridad
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_aprobador
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro||'
                            order by fun.desc_funcionario1
                            limit '|| p_limit::varchar||' offset '||p_start::varchar;
                        
                          FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		 END LOOP;
                 ELSE
                       v_consulta='select
                          COUNT(fun.id_funcionario)
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_aprobador
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro;
                        
                          FOR g_registros in execute (v_consulta)LOOP     
                  		   RETURN NEXT g_registros;
                		  END LOOP;
                 
                 
                 END IF;
      --Adquisiciones aprobacion del funcionario supervisor
      ELSEIF v_nombre_func_list ='ADQ_SUP_SOL_COMPRA'  THEN
                 IF p_count=FALSE then
                     --recuperamos el supervidor  de la solictud de compra
                     v_consulta='select
                          fun.id_funcionario,
                          fun.desc_funcionario1 as desc_funcionario,
                          ''Supervisor''::text  as desc_funcionario_cargo,
                          1 as prioridad
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_supervisor
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro||'
                        order by fun.desc_funcionario1
                        limit '|| p_limit::varchar||' offset '||p_start::varchar;
                        FOR g_registros in execute (v_consulta)LOOP     
                  		  RETURN NEXT g_registros;
                		END LOOP;
                 ELSE
                     v_consulta='select
                          COUNT(fun.id_funcionario)
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_supervisor
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro;
                        FOR g_registros in execute (v_consulta)LOOP     
                  		  RETURN NEXT g_registros;
                		END LOOP;
                 END IF;
      ELSEIF v_nombre_func_list ='ADQ_LIB_SOL_COMPRA'  THEN
      --CALVAREZ: obtenemos el responsable según la solicitud realizada
                 IF p_count=FALSE then
                     --recuperamos el supervidor  de la solictud de compra
                     v_consulta='select
                          fun.id_funcionario,
                          fun.desc_funcionario1 as desc_funcionario,
                          ''Liberación''::text  as desc_funcionario_cargo,
                          1 as prioridad
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_supervisor
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro||'
                        order by fun.desc_funcionario1
                        limit '|| p_limit::varchar||' offset '||p_start::varchar;
                        FOR g_registros in execute (v_consulta)LOOP     
                  		  RETURN NEXT g_registros;
                		END LOOP;
                 ELSE
                     v_consulta='select
                          COUNT(fun.id_funcionario)
                        from adq.tsolicitud sol
                        inner join  orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario_supervisor
                        where sol.id_estado_wf = '||p_id_estado_wf||'
                        and '||p_filtro;
                        FOR g_registros in execute (v_consulta)LOOP     
                  		  RETURN NEXT g_registros;
                		END LOOP;
                 END IF;
      ELSE
                 --  ejecutar funcion de listado 
                 IF p_count=FALSE then
                  
                    v_campos = 'id_funcionario,
                                desc_funcionario,
                                desc_funcionario_cargo,
                                prioridad';
                                
                    v_as = ' (id_funcionario integer,
                                       desc_funcionario text,
                                       desc_funcionario_cargo text,
                                       prioridad integer)';
                 else
                    v_as = ' (total bigint)';
                    v_campos = ' total  ';
                 
                 END IF;
                  
                  v_consulta:='SELECT 
                                '||v_campos||'
                               FROM '||v_nombre_func_list||'(
                                 '||p_id_usuario::varchar||', 
                                 '||p_id_tipo_estado::varchar||', 
                                  '''|| COALESCE(p_fecha,now())::varchar||''',
                                  '||p_id_estado_wf::varchar||',
                                  '||p_count::varchar||',
                                  '||p_limit||',
                                  '||p_start||',
                                  '||quote_literal(p_filtro)||'
                                  
                                 ) AS '||v_as;
                                 
                                 
                   raise notice  'consulta: %',v_consulta;              
                                       
                                      
                  FOR g_registros in execute (v_consulta)LOOP  
                    RETURN NEXT g_registros;
                  END LOOP;
      
      
      
      END IF;
     
     
     
    
    
    else
    
    
      raise exception ' El tipo de Asignacion (%)  no es conocido',v_tipo_asignacion;
    
    end if; 


EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje', 'Error con el tipo de asignacion '||COALESCE(v_tipo_asignacion,'NAN'  )||' y funcion de listado ' ||COALESCE(v_nombre_func_list,'NAN'),'unir' );
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