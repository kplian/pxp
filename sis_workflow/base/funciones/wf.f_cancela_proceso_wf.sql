--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_cancela_proceso_wf (
  p_codigo_anulado varchar,
  p_id_proceso_wf integer,
  p_id_usuario integer,
  p_obs text = ''::text
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_cancela_proceso_wf
 DESCRIPCION: 	Anula procesos de WF, cambi al estado solicitado y verifica 
               si los procesos disparados si existen esten anualdos
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			25/04/2014
 COMENTARIOS:	
***************************************************************************/
DECLARE	

    v_nombre_funcion varchar;
    v_resp varchar;

    v_registros	       		record; 
    v_r	 		      		record; 
    v_registros_pwf         record; 
    v_id_estado_actual      integer;
    
    va_id_proceso_wf        integer[];
    va_id_estado_actual     integer[];
    va_codigo_estado        varchar[];
    va_nombre_proceso       varchar[];
    
    v_sw_no_anulado           boolean;
    v_mensaje_error           varchar;
    
	
    
BEGIN

      v_nombre_funcion ='f_cancela_proceso_wf';
     
      -- obtenemos el tipo del estado anulado
      
      select 
         te.id_tipo_estado
      into
         v_registros
     from wf.tproceso_wf pw 
     inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
     inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = p_codigo_anulado               
     where pw.id_proceso_wf = p_id_proceso_wf;
     
     
      IF v_registros is NULL THEN
         raise exception 'No se encontro el estado  % para este proceso', p_codigo_anulado;
      END IF;
     
     
      -- obtenemos datos del estado actual
      select 
         ewf.id_estado_wf,
         ewf.id_funcionario,
         ewf.id_depto
      into
         v_registros_pwf
      from wf.tproceso_wf pw 
      inner join wf.testado_wf ewf on  
               ewf.id_proceso_wf = pw.id_proceso_wf  
         and   ewf.estado_reg = 'activo'            
      where pw.id_proceso_wf = p_id_proceso_wf;
     
     --   revisar recusivamente los procesos disparados a partir del proeso actual
     --       si existen proceso no anulados saca una alerta 
     
     /* select  
          tmp.ps_id_proceso_wf,
          tmp.ps_id_estado_actual,
          tmp.ps_codigo_estado,
          tmp.ps_nombre_proceso 
        INTO
          va_id_proceso_wf,
          va_id_estado_actual,
          va_codigo_estado,
          va_nombre_proceso   
        FROM wf.f_buscar_estado_procesos_disparados (p_id_proceso_wf,v_registros_pwf.id_estado_wf) tmp;*/
     
    --alternatica con manejo de array 
    /*
     IF va_codigo_estado <@ ARRAY['anulado','anulada','eliminado','eliminada','cancelado','cancelada','desierto','desierta'] THEN
        raise notice 'todo esta cancelado';
     ELSE 
        raise exception 'Revise los procesos anexos derivados, todos deben estar anulados, cancelados o eliminados';
     END IF;
     */
     
     v_sw_no_anulado = FALSE;
     v_mensaje_error = '';
     --revis alos array en busca de estados no diferentes de anulado o similar
     FOR v_r in ( SELECT * FROM  (  
     
                  SELECT 
                    ps_id_proceso_wf,
                    ps_id_estado_actual,
                    ps_codigo_estado,
                    ps_nombre_proceso,
                  generate_subscripts(ps_id_proceso_wf, 1) AS s
         FROM wf.f_buscar_estado_procesos_disparados(p_id_proceso_wf,v_registros_pwf.id_estado_wf)) AS foo
         WHERE ps_codigo_estado[s] not in ('anulado','anulada','eliminado','eliminada','cancelado','cancelada','desierto','desierta')
      ) LOOP
      
      
          v_sw_no_anulado = TRUE;
          v_mensaje_error=  v_mensaje_error||'<BR>'|| v_r.ps_nombre_proceso[v_r.s]||' ('||v_r.ps_codigo_estado[v_r.s]||')';
      
      END LOOP;
      
      IF v_sw_no_anulado THEN
      
         raise exception 'Revise los procesos anexos derivados, todos deben estar anulados, cancelados o eliminados: %',v_mensaje_error;
      
      END IF;
      
     
     
     --cambio al estado indicado
     return  wf.f_registra_estado_wf(v_registros.id_tipo_estado,
                                            v_registros_pwf.id_funcionario,
                                            v_registros_pwf.id_estado_wf, --estado anterior
                                            p_id_proceso_wf,
                                            p_id_usuario,
                                            v_registros_pwf.id_depto,
                                            p_obs);
                                                    
                                                    
      
  
    
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