--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_estado_wf (
  p_id_proceso_wf integer,
  p_id_estado_wf integer,
  p_operacion varchar,
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

***************************************************************************/
DECLARE

v_id_tipo_proceso integer;
v_id_tipo_estado integer;
	
BEGIN

    --estable el tipo de proceso actual
    
    select 
     pw.id_tipo_proceso
    INTO
    v_id_tipo_proceso
   from wf.tproceso_wf  pw
   where pw.id_proceso_wf = p_id_proceso_wf;

  --establece el tipo estado actual
    
    select 
      ew.id_tipo_estado 
     into 
      v_id_tipo_estado
    from wf.testado_wf ew
    where ew.id_estado_wf = p_id_estado_wf;
  

 -- raise exception '% %  %',v_id_tipo_estado, p_id_proceso_wf,p_id_estado_wf;

   -- recuperar siguiente estado
   
   IF p_operacion = 'siguiente' THEN
   
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
        inner join  wf.testructura_estado ee on ee.id_tipo_estado_hijo = te.id_tipo_estado
        where te.id_tipo_proceso = v_id_tipo_proceso  
        and  ee.id_tipo_estado_padre = v_id_tipo_estado;
  
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
               on ee.id_tipo_estado_padre = te.id_tipo_estado
        where te.id_tipo_proceso = v_id_tipo_proceso  
          and  ee.id_tipo_estado_hijo = v_id_tipo_estado;
   END IF;
return;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;