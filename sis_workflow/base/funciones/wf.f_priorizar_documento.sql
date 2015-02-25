CREATE OR REPLACE FUNCTION wf.f_priorizar_documento (
  p_cantidad integer,
  p_id_tipo_estado integer,
  p_id_estado_actual integer,
  p_id_proceso_wf integer,
  p_id_usuario integer,
  p_id_tipo_documento integer,
  p_direccion varchar
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_priorizar_documento
 DESCRIPCION: 	Devuelve 0 sis e pririza ascendentemente y corresponde priorizar 
 				1 si se prioriza ascendentemente y no corresponde priorizar
                9 si se prioriza descendentemente y corresponde priorizar
                8 si se prioriza descendentemente y no corresponde priorizar 
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


v_parametros  		record;
v_nombre_funcion   	text;
v_resp				varchar;
v_pririzacion		integer;
v_registros			record;
v_registros_doc		record;
v_id_proceso_wf_ini integer[]; 

BEGIN


    v_nombre_funcion = 'wf.f_priorizar_documento';
    --si no corresponde priorizar
    if (p_cantidad != 1) then
    	if (p_direccion = 'ASC') then
           	return 1;
        else 
        	return 8;
        end if;
    end if;
    
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
                                    and (tde.momento = 'exigir'  or tde.momento = 'verificar')
                                    and tde.id_tipo_estado = p_id_tipo_estado and 
                                    td.id_tipo_documento = p_id_tipo_documento
                                    ) LOOP
       
       			
               --si la regla es verdadera ...
                IF  (wf.f_evaluar_regla_wf ( p_id_usuario,
                                             p_id_proceso_wf,
                                             v_registros.regla,
                                             p_id_tipo_estado,
                                             p_id_estado_actual))  THEN
               
                       -- recuriva mente encontra el proceso_wf correspondiente a los tipo_proceso identificados
                        
                       v_id_proceso_wf_ini = wf.f_encontrar_proceso_wf(v_registros.id_tipo_proceso, p_id_estado_actual,v_registros.tipo_busqueda);
                       
                      
                      
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
                           
                              if (p_direccion = 'ASC') then
                                  return 0;
                              else 
                                  return 9;
                              end if;
                           
                           ELSEIF v_registros.momento = 'verificar' and  v_registros_doc.momento = 'exigir' and  v_registros_doc.chequeado = 'no'  THEN
                               if (p_direccion = 'ASC') then
                                  return 0;
                              else 
                                  return 9;
                              end if;
                           end if;
                        end loop;
                    end if;
                end loop;  
      
      
      
    if (p_direccion = 'ASC') then
        return 1;
    else 
        return 8;
    end if;


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