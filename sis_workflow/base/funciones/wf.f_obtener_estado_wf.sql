CREATE OR REPLACE FUNCTION wf.f_obtener_estado_wf (
  p_id_proceso_wf integer,
  p_id_estado_wf integer,
  p_id_tipo_estado integer,
  p_operacion varchar,
  p_id_usuario integer = NULL::integer,
  out ps_id_tipo_estado integer [],
  out ps_codigo_estado varchar [],
  out ps_disparador varchar [],
  out ps_regla varchar [],
  out ps_prioridad integer []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_wf
 DESCRIPCION: 	esta funcion permite obtener el siguiente estado o  el anterior dentro del WF
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			21/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
 ********************************
  p_id_proceso_wf integer,   ->   identificador del proceso WF obligatorio
  p_id_estado_wf integer,    ->   identificador del estado del WF, se utiliza si id_tipo_estado es NULL
  p_id_tipo_estado integer,  ->   OPCIONAL
  p_operacion varchar,       ->   siguiente o anterior
 

***************************************************************************/
DECLARE

v_nombre_funcion varchar;
v_resp varchar;

v_id_tipo_proceso integer;
v_id_tipo_estado integer;
v_consulta       varchar;
v_registros_prioridades record;
v_registros    record;
sw_insercion  varchar;
v_id_estado_wf  integer;

BEGIN

v_nombre_funcion = 'wf.f_obtener_estado_wf';

    --estable el tipo de proceso actual
    
    select 
     pw.id_tipo_proceso
    INTO
    v_id_tipo_proceso
   from wf.tproceso_wf  pw
   where pw.id_proceso_wf = p_id_proceso_wf;

  --establece el tipo estado actual
    
  if p_id_tipo_estado is null then
  
      select 
        ew.id_tipo_estado 
       into 
        v_id_tipo_estado
      from wf.testado_wf ew
      where ew.id_estado_wf = p_id_estado_wf;
      
  else
  
 	 v_id_tipo_estado=p_id_tipo_estado;
  
  end if;
  
  
  IF p_id_estado_wf is NULL THEN
  --si nos mandan el id_estado_wd atual o recuperamos a partir del id_proceso_wf
  
          select
            ew.id_estado_wf
          into 
            v_id_estado_wf
            
          from wf.tproceso_wf pw
          inner join wf.testado_wf ew  on ew.id_proceso_wf = pw.id_proceso_wf and ew.estado_reg = 'activo'
          inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado and te.estado_reg = 'activo'
          where pw.id_proceso_wf =  p_id_proceso_wf;
  ELSE
  
       v_id_estado_wf = p_id_estado_wf;
  
  
  END IF;
  
  
  

 

   -- recuperar siguiente estado
   
   IF p_operacion = 'siguiente' THEN
   
        --Creación de tabla temporal
		v_consulta = '
        DROP TABLE IF EXISTS tt_tipo_estado;
        create temp table tt_tipo_estado(
                 id_tipo_estado  integer,
                 codigo varchar,
			     disparador varchar,
			     regla text,
                 prioridad integer
			)on commit drop;';
        
         execute(v_consulta);
         
         
         sw_insercion = 'no';
         
        --FOR recorre primero las prioridades de menor a mayor
        
        FOR v_registros_prioridades in (select 
                           DISTINCT(ee.prioridad) as prioridad
                        from  wf.ttipo_estado te 
                        inner join  wf.testructura_estado ee 
                              on ee.id_tipo_estado_hijo = te.id_tipo_estado
                        where      te.id_tipo_proceso = v_id_tipo_proceso  
                              and  ee.id_tipo_estado_padre = v_id_tipo_estado and te.estado_reg = 'activo' and ee.estado_reg = 'activo'
                        order by prioridad asc) LOOP
                        
                        
                   -- raise exception '%',v_registros_prioridades.prioridad;
                        
                
        
                  --  FOR  recorre la aristas con la prioridad indicada
                  FOR v_registros in  (select
                                           te.id_tipo_estado,
                                           te.codigo,
                                           te.disparador,
                                           ee.regla,
                                           ee.prioridad
                                      from  wf.ttipo_estado te 
                                      inner join  wf.testructura_estado ee on ee.id_tipo_estado_hijo = te.id_tipo_estado
                                      where      te.id_tipo_proceso = v_id_tipo_proceso  
                                            and  ee.id_tipo_estado_padre = v_id_tipo_estado and ee.estado_reg = 'activo' 
                                            and  ee.prioridad = v_registros_prioridades.prioridad and te.estado_reg = 'activo'
                                      order by ee.prioridad asc) LOOP        
                        
                           IF v_registros.regla is NULL or v_registros.regla = '' THEN
                              --  si no hay regla apra evaluar se inserta directo en la tabla
                              v_consulta=  'INSERT INTO  tt_tipo_estado(
                                           id_tipo_estado ,
                                           codigo,
                                           disparador,
                                           prioridad
                                      )
                                      VALUES
                                      (
                                      '||v_registros.id_tipo_estado::varchar||',
                                      '||COALESCE(''''||v_registros.codigo::VARCHAR||'''','NULL')||',
                                      '||COALESCE(''''||v_registros.disparador::VARCHAR||'''','NULL')||',
                                      '||v_registros.prioridad::varchar||'
                                     );';
                
               
                                    execute(v_consulta);
                           
                              
                              -- se marca en una bandera que hubo insercion
                              sw_insercion = 'si';
                           ELSE   
                               --  si tiene regla se evalua
                               -- si la el resutlado es positivo se inserta en la tabla 
                               IF wf.f_evaluar_regla_wf (
                                                     p_id_usuario, 
                                                     p_id_proceso_wf, 
                                                     v_registros.regla, --pantilla o funcion de evaluacion
                                                     v_registros.id_tipo_estado, 
                                                     v_id_estado_wf) THEN  
                                
                                  --  si no hay regla apra evaluar se inserta directo en la tabla
                                   v_consulta=  'INSERT INTO  tt_tipo_estado(
                                                       id_tipo_estado ,
                                                       codigo,
                                                       disparador,
                                                       prioridad
                                                  )
                                                  VALUES
                                                  (
                                                  '||v_registros.id_tipo_estado::varchar||',
                                                  '||COALESCE(''''||v_registros.codigo::VARCHAR||'''','NULL')||',
                                                  '||COALESCE(''''||v_registros.disparador::VARCHAR||'''','NULL')||',
                                                  '||v_registros.prioridad::varchar||'
                                                 );';
                
               
                                    execute(v_consulta);
                              
                                -- se marca en una bandera que hubo insercion
                                
                                sw_insercion = 'si';
                              
                              
                              END IF;  
                                
                           END IF; 
                   END LOOP;
                   
                    -- si la bandera muestra que hubo una insercion se rompe el FOR 
                    IF  sw_insercion = 'si' THEN
                    
                      EXIT;
                    
                    END IF;
           
       
        
        
        END LOOP;
        
         -- se retorna el resultado de la tabla temporal
        
        
        select 
           pxp.aggarray(id_tipo_estado),
           pxp.aggarray(codigo),
           pxp.aggarray(disparador),
           pxp.aggarray(regla),
           pxp.aggarray(prioridad)
        into
          ps_id_tipo_estado,
          ps_codigo_estado,
          ps_disparador,
          ps_regla,
          ps_prioridad
          
        from  tt_tipo_estado;
  
    ELSEIF p_operacion = 'anterior' THEN
   
         select 
                 pxp.aggarray(te.id_tipo_estado),
                 pxp.aggarray(te.codigo),
                 pxp.aggarray(te.disparador),
                 pxp.aggarray(ee.regla),
                 pxp.aggarray(ee.prioridad)
              into
                ps_id_tipo_estado,
                ps_codigo_estado,
                ps_disparador,
                ps_regla,
                ps_prioridad
                
             from  wf.ttipo_estado te 
             
        inner join  wf.testructura_estado ee 
               on ee.id_tipo_estado_padre = te.id_tipo_estado and ee.estado_reg = 'activo'
        where te.id_tipo_proceso = v_id_tipo_proceso  
          and  ee.id_tipo_estado_hijo = v_id_tipo_estado;
   END IF;
return;
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
COST 100;