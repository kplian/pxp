--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_registra_proceso_disparado_wf (
  p_id_usuario_reg integer,
  p_id_estado_wf_dis integer,
  p_id_funcionario integer,
  p_id_depto integer,
  p_descripcion varchar = '---'::character varying,
  out ps_id_proceso_wf integer,
  out ps_id_estado_wf integer,
  out ps_codigo_estado varchar
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_registra_proceso_disparado_wf
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
 AUTOR: 		KPLIAN(RAC)
 FECHA:			25/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE

   v_resp varchar;
   v_nombre_funcion varchar;
   
   v_id_tipo_estado_prev integer;
   v_disparador varchar;
   v_id_tipo_proceso_next integer;
   v_codigo_prev varchar;
   v_id_tipo_estado_next integer;
   v_codigo_estado_next varchar;
   v_id_proceso_wf_prev integer;
   v_nro_tramite varchar;
 
  
BEGIN

    v_nombre_funcion='wf.f_registra_proceso_disparado_wf';
    
    --verificamos si el estado previo es un disparador
    
    select 
      te.codigo,
      ew.id_proceso_wf,
      te.id_tipo_estado,
      te.disparador
      
    into 
       v_codigo_prev,
       v_id_proceso_wf_prev,
       v_id_tipo_estado_prev,
       v_disparador
    
    from wf.ttipo_estado te 
    inner join wf.testado_wf ew  on ew.id_tipo_estado = te.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf_dis;
    
    ---raise exception 'rrrrrrrrrrr  %',v_id_tipo_estado_prev;
        
    select
     tp.id_tipo_proceso
    into 
      v_id_tipo_proceso_next
    from wf.ttipo_proceso tp 
    where   tp.id_tipo_estado=v_id_tipo_estado_prev;
    
    
    IF v_id_tipo_proceso_next is NULL THEN 
    
      raise exception 'El estado (- % -) no apunta a ningun proceso ',v_codigo_prev;
    
    END IF;

     --recupera datos del primer estado del siguiente proceso
     select 
       te.id_tipo_estado,
       te.codigo
     into
       v_id_tipo_estado_next,
       v_codigo_estado_next
     from wf.ttipo_estado te
     where te.id_tipo_proceso = v_id_tipo_proceso_next and te.inicio ='si'; 
     
     if v_id_tipo_estado_next is NULL THEN
           raise exception 'El WF esta mal parametrizado verifique a que tipo_proceso apunto el tipo_estado previo';
     END IF;
     --recupera el numero de tramite
    
      select 
        pw.nro_tramite
      into
        v_nro_tramite
      from wf.tproceso_wf pw
      where pw.id_proceso_wf = v_id_proceso_wf_prev;
     
     
     
     --inserta el nuevo proceso
     
     -- inserta el proceso con el numero de tramite
         INSERT INTO 
          wf.tproceso_wf
        (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_tipo_proceso,
          nro_tramite,
          id_estado_wf_prev,
          descripcion
          
        ) 
        VALUES (
          p_id_usuario_reg,
          now(),
          'activo',
          v_id_tipo_proceso_next,
          v_nro_tramite,
          p_id_estado_wf_dis,
          p_descripcion
        ) RETURNING id_proceso_wf into ps_id_proceso_wf;
        
  
      
      -- inserta el primer estado del proceso 
         INSERT INTO 
          wf.testado_wf
        (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_estado_anterior,
          id_tipo_estado,
          id_proceso_wf,
          id_funcionario,
          id_depto
        ) 
        VALUES (
          p_id_usuario_reg,
          now(),
          'activo',
          NULL,
          v_id_tipo_estado_next,
          ps_id_proceso_wf,
          p_id_funcionario,
          p_id_depto
        )RETURNING id_estado_wf into ps_id_estado_wf;  
        
      
      
      
        ps_codigo_estado  = v_codigo_estado_next;
      
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
SECURITY DEFINER
COST 100;