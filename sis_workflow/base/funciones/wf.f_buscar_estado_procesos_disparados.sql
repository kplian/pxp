--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_buscar_estado_procesos_disparados (
  p_id_proceso_wf integer,
  p_id_estado_wf_act integer,
  out ps_id_proceso_wf integer [],
  out ps_id_estado_actual integer [],
  out ps_codigo_estado varchar [],
  out ps_nombre_proceso varchar []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_buscar_estado_procesos_disparados
 DESCRIPCION: 	busca recursivamente los estados indicados dentro de los procesos disparados
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			25/04/2014
 COMENTARIOS:	

***************************************************************************/
DECLARE

v_nombre_funcion varchar;
v_resp varchar;

v_id_tipo_proceso integer;
v_id_tipo_estado integer; 

va_id_estado_wf  integer[];
va_id_proceso_wf integer[];
va_id_estado_actual integer[];
va_codigo_estado    varchar[];
va_nombre_proceso   varchar[];
v_registros      record;
	
BEGIN

         v_nombre_funcion = 'wf.f_buscar_estado_procesos_disparados';
         
         
         -- obtiene estado de proceso wf
         WITH RECURSIVE estados (id_estado_wf,id_estado_anterior, codigo, id_tipo_estado) AS (  
                                      select ew.id_estado_wf,
                                             ew.id_estado_anterior,
                                             te.codigo,
                                             te.id_tipo_estado
                                      from wf.testado_wf ew
                                      inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado and te.estado_reg = 'activo'
                                      where ew.id_estado_wf = p_id_estado_wf_act
                                      UNION ALL
                                      SELECT ewp.id_estado_wf,
                                             ewp.id_estado_anterior,
                                             tep.codigo,
                                             tep.id_tipo_estado
                                      FROM estados a
                                           INNER JOIN wf.testado_wf ewp on
                                            ewp.id_estado_wf = a.id_estado_anterior
                                           INNER JOIN wf.ttipo_estado tep on tep.id_tipo_estado = ewp.id_tipo_estado  and tep.estado_reg = 'activo')  
                                       
                                       SELECT 
                                         pxp.aggarray(id_estado_wf)
                                        into
                                        va_id_estado_wf
                                       FROM estados;  
         
         --  indentificamos los procesos disparados desde algunos de los estados de anterior en el proceso especifico actual
          
          FOR v_registros in (
          
                 SELECT  
                  pwf.id_proceso_wf,
                  pwf.id_estado_wf_prev,
                  pwf.codigo_proceso,
                  pwf.descripcion,
                  ewf.id_estado_wf,
                  te.codigo,
                  tp.nombre
                 FROM   wf.tproceso_wf pwf   
                 inner join wf.testado_wf ewf  on  ewf.id_proceso_wf = pwf.id_proceso_wf and  ewf.estado_reg = 'activo'
           		 inner join  wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                 inner join  wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado and te.estado_reg = 'activo'
                 where   pwf.id_estado_wf_prev = ANY(va_id_estado_wf)) LOOP
                 
                 
                       
                         
                        -- llamada recursiva sobre los procesos disparados
                        select  
                          tmp.ps_id_proceso_wf,
                          tmp.ps_id_estado_actual,
                          tmp.ps_codigo_estado,
                          tmp.ps_nombre_proceso 
                        INTO
                          va_id_proceso_wf,
                          va_id_estado_actual,
                          va_codigo_estado,
                          va_nombre_proceso   
                        FROM wf.f_buscar_estado_procesos_disparados (v_registros.id_proceso_wf,v_registros.id_estado_wf) tmp;
                         
                      ps_id_proceso_wf    = ps_id_proceso_wf||va_id_proceso_wf;
                      ps_id_estado_actual = ps_id_estado_actual||va_id_estado_actual;
                      ps_codigo_estado= ps_codigo_estado||va_codigo_estado;
                      ps_nombre_proceso = ps_nombre_proceso||va_nombre_proceso;
                      
                      ps_id_proceso_wf = array_prepend(v_registros.id_proceso_wf,ps_id_proceso_wf);
                      ps_id_estado_actual = array_prepend(v_registros.id_estado_wf,ps_id_estado_actual);
                      ps_codigo_estado = array_prepend(v_registros.codigo,ps_codigo_estado);
                      ps_nombre_proceso = array_prepend(v_registros.nombre,ps_nombre_proceso);
                 
          END LOOP;
            
            
                                       
       
                                        
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