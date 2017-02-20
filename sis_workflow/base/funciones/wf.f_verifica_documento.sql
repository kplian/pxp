--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_verifica_documento (
  p_id_usuario_reg integer,
  p_id_estado_wf integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_verifica_documento
 DESCRIPCION: 	Verifica que tipos de coumentos estan relacionados con el estado indicado, y controla si debe ser exigido
 AUTOR: 		KPLIAN(RAC)
 FECHA:			20/01/2014
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
  v_resp_cadena_firma varchar;
  v_resp_fisico varchar;
  v_registro_estado  record;
  
BEGIN

       v_nombre_funcion = 'wf.f_verifica_documento';
       
       
       select
        ewf.id_estado_anterior,
        ewf.id_tipo_estado,
        ewf.id_proceso_wf
       into
        v_registro_estado
       from wf.testado_wf ewf
       where ewf.id_estado_wf = p_id_estado_wf;
       
       v_id_tipo_estado = v_registro_estado.id_tipo_estado;
       
       
       
       
       
       v_sw = FALSE;
       v_resp_cadena = '';
       v_resp_cadena_firma = '';
       v_resp_fisico = '';
       
       
       
       -- obtener los tipos de documentos del momento  verificar o exigir o hacer_exigible,  relacionados con este estado
       --  y  los tipo_proceso_wf a verificar
       FOR v_registros in (
                             SELECT 
                                    td.id_tipo_documento,
                                    td.id_tipo_proceso,
                                    td.nombre,
                                    td.codigo,
                                    td.descripcion,
                                    tde.momento,
                                    tde.tipo_busqueda,
                                    tde.regla,
                                    td.action,
                                    td.tipo
                                  FROM  wf.ttipo_documento_estado tde 
                                  INNER JOIN  wf.ttipo_documento  td 
                                    on td.id_tipo_documento  = tde.id_tipo_documento 
                                    and td.estado_reg = 'activo' and tde.estado_reg = 'activo'
                                    and (tde.momento = 'exigir'  or tde.momento = 'verificar' or 
                                        tde.momento = 'hacer_exigible' or 
                                        tde.momento = 'verificar_fisico' or 
                                        tde.momento = 'exigir_fisico' or 
                                        tde.momento = 'firmar' or
                                        tde.momento = 'eliminar_firma')
                                    and tde.id_tipo_estado = v_id_tipo_estado
                                    ) LOOP
       
       
               --si la regla es verdadera ...
                IF  (wf.f_evaluar_regla_wf ( p_id_usuario_reg,
                                             v_registro_estado.id_proceso_wf,
                                             v_registros.regla,
                                             v_registro_estado.id_tipo_estado,
                                             v_registro_estado.id_estado_anterior))  THEN
               
                       -- recuriva mente encontra el proceso_wf correspondiente a los tipo_proceso identificados
                        
                       v_id_proceso_wf_ini = wf.f_encontrar_proceso_wf(v_registros.id_tipo_proceso, p_id_estado_wf,v_registros.tipo_busqueda);
                        
                      
                      
                      --raise exception 'looop  %, %',v_registros.id_tipo_proceso,p_id_estado_wf;
                        
                      
                      -- preguntar si el documento fue escaneado
                        FOR v_registros_doc  in( 
                            select 
                               dwf.id_documento_wf,  
                               dwf.momento,
                               dwf.chequeado,
                               dwf.chequeado_fisico,
                               pwf.codigo_proceso,
                               pwf.descripcion,
                               dwf.fecha_firma
                            from wf.tdocumento_wf dwf
                            inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = dwf.id_proceso_wf
                            
                            where  dwf.id_proceso_wf = ANY(v_id_proceso_wf_ini) 
                              and  dwf.id_tipo_documento = v_registros.id_tipo_documento) LOOP
                              
                              
                              
                           
                          --  si el momento del tipo documento es exigir 
                          --  verificar si fue escaneado
                         
                        
                          -- raise exception '----   %',v_registros_doc;
                        
                           IF v_registros.momento = 'exigir' and  v_registros_doc.chequeado = 'no'  THEN
                           
                               --marcamos el documento como no escaneado
                               v_sw=TRUE;
                               if v_registros.action is not null and v_registros.tipo = 'generado' then
                               		
                               		v_resp_cadena_firma=v_resp_cadena_firma||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br>';   
                               else
                               		v_resp_cadena=v_resp_cadena||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br>';   
                           	   end if;
                           
                           ELSEIF v_registros.momento = 'verificar' and  v_registros_doc.momento = 'exigir' and  v_registros_doc.chequeado = 'no'  THEN
                               --marcamos el documento como no escaneado
                               v_sw=TRUE;
                               if v_registros.action is not null and v_registros.tipo = 'generado' then
                               		v_resp_cadena_firma=v_resp_cadena_firma||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br>';   
                               else
                               		v_resp_cadena=v_resp_cadena||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br>';   
                           	   end if;
                           
                           ELSEIF v_registros.momento = 'hacer_exigible' and  v_registros_doc.momento = 'verificar'  THEN
                              
                               update wf.tdocumento_wf dwf set
                                 momento = 'exigir'
                               where dwf.id_documento_wf = v_registros_doc.id_documento_wf;
                               
                               
                           END IF;
                           --REVISION DE MOMENTOS DE FIRMA
                           IF v_registros.momento = 'firmar' and  v_registros_doc.fecha_firma is null  THEN
                              
                               update wf.tdocumento_wf dwf set
                                 fecha_firma = to_char(now(), 'DD-MM-YYYY HH24:MI:SS'),
                                 usuario_firma = (select u.cuenta from segu.tusuario u where id_usuario = p_id_usuario_reg),
                                 accion_pendiente = 'firmar'
                               where dwf.id_documento_wf = v_registros_doc.id_documento_wf;
                           
                           ELSIF v_registros.momento = 'eliminar_firma' and  v_registros_doc.fecha_firma is not null  THEN
                              
                               update wf.tdocumento_wf dwf set                                 
                                 accion_pendiente = 'eliminar_firma'
                               where dwf.id_documento_wf = v_registros_doc.id_documento_wf;
                               
                               
                           END IF;
                           
                           --REVISION DE LA BANDERA DE DOCUMENTOS FISICOS
                           IF v_registros.momento = 'exigir_fisico' and  v_registros_doc.chequeado_fisico = 'no'  THEN
                              --marcamos que el documento no tiene el respaldo fiscico
                               v_sw=TRUE;
                               v_resp_fisico=v_resp_fisico||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br> ';   
                           
                           ELSEIF v_registros.momento = 'verificar_fisico' and  v_registros_doc.momento = 'exigir' and  v_registros_doc.chequeado_fisico = 'no'  THEN
                               --marcamos el documento como no escaneado
                               v_sw=TRUE;
                               v_resp_fisico=v_resp_fisico||'Doc. ["'||COALESCE(v_registros.nombre,'S/N')  ||'"] del proc. '||COALESCE(v_registros_doc.codigo_proceso,'NaN')||'(' ||COALESCE(v_registros_doc.descripcion,'NaN')||')<br> ';   
                           
                           END IF; 
                           
                          
                           
                           
                           
                       END LOOP; 
               
               END IF;
               
                
        END LOOP;
       
       
      -- raise exception '... %,%,%',v_sw,v_resp_cadena,v_resp_fisico;
       
       --mostramos errores si existen
        IF v_sw THEN
        
        
       
            IF v_resp_cadena != '' THEN
               
               v_resp_cadena = 'Documentos no escaneados:<br>'||v_resp_cadena;
            
            END IF;
            
            IF v_resp_fisico != '' THEN
               
               v_resp_cadena = v_resp_cadena||'No se verificiaron los documentos físicos de:<br>' ||v_resp_fisico;
            
            END IF;
            
            IF v_resp_cadena_firma != '' THEN
               
               v_resp_cadena = v_resp_cadena||'No se firmaron los documentos:<br>' ||v_resp_cadena_firma;
            
            END IF;
        
        
            raise exception '%', v_resp_cadena;
        
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