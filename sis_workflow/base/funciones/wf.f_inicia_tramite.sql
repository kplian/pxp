--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_inicia_tramite (
  p_id_usuario_reg integer,
  p_id_gestion integer,
  p_codigo_tipo_proceso varchar,
  p_id_funcionario integer,
  p_fecha timestamp,
  out ps_num_tramite varchar,
  out ps_id_proceso_wf integer,
  out ps_id_estado_wf integer,
  out ps_nombre_estado varchar
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
  
BEGIN

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
         
         
         IF v_inicio = 'si' THEN
            ps_num_tramite = wf.f_get_numero_tramite(v_codigo_proceso_macro, p_id_gestion, p_id_usuario_reg);
         END IF ;
         
         
         -- inserta el proceso con el numero de tramite
         INSERT INTO 
          wf.tproceso_wf
        (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_tipo_proceso,
          nro_tramite
        ) 
        VALUES (
          p_id_usuario_reg,
          now(),
          'activo',
          v_id_tipo_proceso,
          ps_num_tramite
        ) RETURNING id_proceso_wf into ps_id_proceso_wf;
        
   -- recupera el tipo_estado_inicial 
   
    select 
    te.id_tipo_estado, te.nombre_estado
    into 
      v_id_tipo_estado, ps_nombre_estado
    from wf.ttipo_estado te
    where te.id_tipo_proceso = v_id_tipo_proceso 
    and te.inicio ='si' ;   
        
        
 
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
        fecha
      ) 
      VALUES (
        p_id_usuario_reg,
        now(),
        'activo',
        NULL,
        v_id_tipo_estado,
        ps_id_proceso_wf,
        p_id_funcionario,
        p_fecha
      )RETURNING id_estado_wf into ps_id_estado_wf;
 
 


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;