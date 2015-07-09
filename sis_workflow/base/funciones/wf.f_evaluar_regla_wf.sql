--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_evaluar_regla_wf (
  p_id_usuario integer,
  p_id_proceso_wf integer,
  p_plantilla text,
  p_id_tipo_estado_actual integer,
  p_id_estado_anterior integer,
  p_obs text = ''::text
)
RETURNS boolean AS
$body$
/*
Autor:  Rensi Arteaga Copari  KPLIAN
Fecha 04/06/2014
Descripcion:  procesa la regla de la arista,  regresa como resultado FALSE or TRUE
*/

DECLARE

v_registros			 record;


v_nombre_funcion 		varchar;
v_nombre_funcion_exe 	varchar;
v_resp 					varchar;
v_i     				integer;

v_template_evaluado    	varchar;
v_retorno 				boolean;
v_prefijo				varchar;
 
BEGIN
            v_nombre_funcion = 'f_evaluar_regla_wf';
            
                 
            
            v_retorno = FALSE;
            
            IF p_plantilla is NULL or p_plantilla = '' THEN
            
             return TRUE;
             
            END IF;
            
            --para determina si es funcion (primero suponemos que lo es)
            --si es funcion obtenmos el nombre
            v_nombre_funcion_exe = split_part(p_plantilla, '.', 2);
            
             
            
            IF EXISTS( SELECT proname FROM pg_proc WHERE proname = v_nombre_funcion_exe) THEN
               
               v_prefijo =  SUBSTRING(p_plantilla, 1, 4);
               
               IF upper(v_prefijo) =  'NOT!' THEN
                 p_plantilla=replace(p_plantilla,'NOT!','');
               END IF;
               
               --si es funcion la ejecutamos y retornamos el valor  falso o verdadero
               EXECUTE ('select ' || p_plantilla  ||'('||p_id_usuario::varchar||','|| p_id_proceso_wf::varchar||','||p_id_estado_anterior::varchar||','||p_id_tipo_estado_actual::varchar||')') into v_retorno;
               
               IF upper(v_prefijo) =  'NOT!' THEN
                 v_retorno = not v_retorno;
               END IF;            
		    ELSE
            
                
               
            
                   --si es una regla procesamos la plantilla para replazar los valroes correspondientes
                   v_template_evaluado =  wf.f_procesar_plantilla( 
                                                     p_id_usuario, 
                                                     p_id_proceso_wf, 
                                                     p_plantilla, 
                                                     p_id_tipo_estado_actual, 
                                                     p_id_estado_anterior, 
                                                     p_obs);
                   
                  
                                                     
                   --evaluamos la plantilla  y retornamos el resutlado
                   v_template_evaluado = replace('select '||v_template_evaluado, '"', '''');
                   
                  
                   --OJO,  las reglas pueden ser nulas en los procesos iniciales
                   --   ejm solicitud de compra, en ese caso no se tiene datos apra procesar la regla
                   --   hay es conveniente llamar a las funciones de evaluacion de documentos e insercion de documentos
                   --   depues de insertado el tramite y la tabla correpondientes (ejm adq.tsolicitud_compra)
                   
                   IF v_template_evaluado is not NULL THEN
                   
                       execute (v_template_evaluado) into v_retorno;
                   END IF;
                   
                  
                  
            
            END IF;
            
           
            
           return  v_retorno;
           
           
           
EXCEPTION
WHEN OTHERS THEN
              

           select   
              pwf.codigo_proceso,
              tp.codigo
           into 
             v_registros
           from wf.tproceso_wf pwf 
           inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
           where pwf.id_proceso_wf = p_id_proceso_wf;
    

			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','AL EVALUAR LA REGLA '||COALESCE(p_plantilla,'NULA')||' en proceso '||COALESCE(v_registros.codigo,'S/P'));
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM,'unir');
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