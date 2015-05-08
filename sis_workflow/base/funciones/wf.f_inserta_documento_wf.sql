--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_inserta_documento_wf (
  p_id_usuario_reg integer,
  p_id_proceso_wf integer,
  p_id_estado_wf integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_inserta_documento_wf
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
  v_nro_tramite varchar;
  v_registros  record;
  
  v_registro_estado record;
  
  v_check boolean;
  v_ultimo_codigo varchar;
  
BEGIN
  
     v_nombre_funcion = 'wf.f_inserta_documento_wf';
     v_ultimo_codigo = 'NO SE PROCESARON DOCUMENTOS';
    
      select
        ewf.id_estado_anterior,
        ewf.id_tipo_estado
      into
        v_registro_estado
      from wf.testado_wf ewf
      where ewf.id_estado_wf = p_id_estado_wf;


        --obtener tipos
        
        select    
          pr.id_tipo_proceso,
          pr.nro_tramite
        into
         v_id_tipo_proceso,
         v_nro_tramite
        from  wf.tproceso_wf pr
        inner join  wf.ttipo_proceso tp on tp.id_tipo_proceso = pr.id_tipo_proceso
        where pr.id_proceso_wf = p_id_proceso_wf;  
              
       
        -- recupero los documento condifurados para el tipo de estado
      
        
         
         
        FOR  v_registros in (
                         select
                               tdo.id_tipo_documento,
                               tdo.codigo,
                               tdo.nombre,
                               ted.momento,
                               ted.regla
                          from  wf.testado_wf ew 
                              inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado and te.estado_reg = 'activo'
                              inner join wf.ttipo_documento_estado ted 
                                    on  ted.id_tipo_estado   = te.id_tipo_estado and ted.momento = 'crear' and ted.estado_reg = 'activo'
                              inner join wf.ttipo_documento tdo  
                                    on  tdo.id_tipo_documento = ted.id_tipo_documento and tdo.estado_reg = 'activo' 
                              where ew.id_estado_wf =  p_id_estado_wf) LOOP
                  
            --0)  verifica si no existe un documento del mismo tipo para el tipo proceso
            /****considerando el caso de que el flujo ya paso por este estado***/ 
               v_ultimo_codigo = v_registros.codigo;
            
               IF exists( select 1 
                          from wf.tdocumento_wf dw 
                          where dw.id_proceso_wf = p_id_proceso_wf and  dw.id_tipo_documento =  v_registros.id_tipo_documento)   THEN
                          
                       	raise notice 'el documento ya existe para proceso' ;   
                           
               ELSE
               
              
           
                       v_check  = wf.f_evaluar_regla_wf (p_id_usuario_reg,
                                                  p_id_proceso_wf,
                                                  v_registros.regla,
                                                  v_registro_estado.id_tipo_estado,
                                                  v_registro_estado.id_estado_anterior);
               
                
                         
                       IF  (v_check)  THEN
                   
                       --crea el documento para este proceso y estado especifico
                         
                         INSERT INTO 
                                wf.tdocumento_wf
                              (
                                id_usuario_reg,
                                fecha_reg,
                                estado_reg,
                                id_tipo_documento,
                                id_proceso_wf,
                                num_tramite,
                                momento,
                                chequeado,
                                id_estado_ini
                              ) 
                              VALUES (
                                p_id_usuario_reg,
                                now(),
                               'activo',
                                v_registros.id_tipo_documento,
                                p_id_proceso_wf,
                                v_num_tramite,
                                'verificar',
                                'no',
                                p_id_estado_wf
                              );
                        
                        
                      END IF; 
        
             END IF;
        
        END LOOP;
     
     --raise exception 'check %',v_check;
     
     
       RETURN TRUE;
    
 EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje', 'en el documento '|| COALESCE(v_ultimo_codigo,'S/D'),'unir' );
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