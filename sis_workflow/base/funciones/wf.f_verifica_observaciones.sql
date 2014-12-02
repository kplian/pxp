--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_verifica_observaciones (
  p_id_usuario_reg integer,
  p_id_estado_wf integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_verifica_observaciones
 DESCRIPCION: 	verifica si el estado del wf del que quiere salir tiene observaciones pendientes no cerradas y activas
 AUTOR: 		KPLIAN(RAC)
 FECHA:			25/11/2014
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
  v_nro_tramite varchar;
  v_registros  record;
  v_registros_doc   record;
  
  v_id_proceso_wf_ini integer[];
  
  v_sw boolean;
  
  v_resp_cadena varchar;
  v_resp_fisico varchar;
  v_registro_estado  record;
  
BEGIN

       v_nombre_funcion = 'wf.f_verifica_observaciones';
       
       
       select
        ewf.id_estado_anterior,
        ewf.id_tipo_estado,
        ewf.id_proceso_wf
       into
        v_registro_estado
       from wf.testado_wf ewf
       where ewf.id_estado_wf = p_id_estado_wf;
       
       v_id_tipo_estado = v_registro_estado.id_tipo_estado;
       
       
       
       IF EXISTS( select
                  o.id_obs
                 from wf.tobs o
                  where      o.id_estado_wf = p_id_estado_wf
                       and  o.estado_reg = 'activo'
                       and  o.estado = 'abierto') THEN
             
             raise exception 'El estado tiene observaciones abiertas sin resolver ... ';
             
       END IF;
       
    
     
       RETURN TRUE;
    
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