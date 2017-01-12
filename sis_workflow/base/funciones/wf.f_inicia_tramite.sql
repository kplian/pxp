--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_inicia_tramite (
  p_id_usuario_reg integer,
  p_id_usuario_ai integer,
  p_usuario_ai varchar,
  p_id_gestion integer,
  p_codigo_tipo_proceso varchar,
  p_id_funcionario integer,
  p_id_depto integer = NULL::integer,
  p_descripcion varchar = ' ---'::character varying,
  p_codigo_proceso varchar = NULL::character varying,
  p_nro_tramite_custom varchar = ''::character varying,
  out ps_num_tramite varchar,
  out ps_id_proceso_wf integer,
  out ps_id_estado_wf integer,
  out ps_codigo_estado varchar
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_inicia_tramite
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

  v_num_siguiente INTEGER;
  v_gestion varchar;
  v_id_gestion integer;
  v_cont_gestion integer;
  v_codigo_siguiente VARCHAR(30);
  v_codigo_proceso_macro varchar;
  v_id_proceso_macro integer;
  
  v_num_tramite varchar;
  v_id_tipo_proceso integer;
  v_id_tipo_estado integer;
  v_inicio varchar;
  v_resp_doc boolean;
  
BEGIN

     v_nombre_funcion = 'wf.f_inicia_tramite';

         -- si el tipo_proceso es de inicio genera numero de tramite
         
         select    tp.id_proceso_macro, tp.inicio, tp.id_tipo_proceso
         into      v_id_proceso_macro, v_inicio, v_id_tipo_proceso
         from wf.ttipo_proceso  tp 
         where  
                tp.codigo = p_codigo_tipo_proceso 
            and tp.estado_reg ='activo';
            

         select pm.codigo into v_codigo_proceso_macro
         from wf.tproceso_macro pm 
         where pm.id_proceso_macro = v_id_proceso_macro; 
         
         
         
         
         IF p_nro_tramite_custom != '' THEN
             ps_num_tramite = p_nro_tramite_custom;
         ELSE
             IF v_inicio = 'si' THEN
                ps_num_tramite = wf.f_get_numero_tramite(v_codigo_proceso_macro, p_id_gestion, p_id_usuario_reg);
             END IF ;
         END IF;
         
         
         
         -- inserta el proceso con el numero de tramite
         INSERT INTO 
          wf.tproceso_wf
        (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_tipo_proceso,
          nro_tramite,
          descripcion,
          codigo_proceso,
          id_usuario_ai,
          usuario_ai
        ) 
        VALUES (
          p_id_usuario_reg,
          now(),
          'activo',
          v_id_tipo_proceso,
          ps_num_tramite,
          p_descripcion,
          p_codigo_proceso,
          p_id_usuario_ai,
          p_usuario_ai
        ) RETURNING id_proceso_wf into ps_id_proceso_wf;
        
   -- recupera el tipo_estado_inicial    
    select 
    te.id_tipo_estado, te.codigo
    into 
      v_id_tipo_estado, ps_codigo_estado
    from wf.ttipo_estado te
    where te.id_tipo_proceso = v_id_tipo_proceso 
    and te.inicio ='si' and te.estado_reg='activo';
 
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
        id_depto,
        id_usuario_ai,
        usuario_ai
       
      ) 
      VALUES (
        p_id_usuario_reg,
        now(),
        'activo',
        NULL,
        v_id_tipo_estado,
        ps_id_proceso_wf,
        p_id_funcionario,
        p_id_depto,
        p_id_usuario_ai,
        p_usuario_ai
      
      )RETURNING id_estado_wf into ps_id_estado_wf;
            
   -- inserta documentos en estado borrador si estan configurados
   v_resp_doc =  wf.f_inserta_documento_wf(p_id_usuario_reg, ps_id_proceso_wf, ps_id_estado_wf);
   
   -- verificar documentos
   v_resp_doc = wf.f_verifica_documento(p_id_usuario_reg, ps_id_estado_wf);
 
      
    
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