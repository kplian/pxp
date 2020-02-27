--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_get_variable_global_defecto (
  p_parametro varchar,
  p_defecto varchar = NULL::character varying
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_variable_global_defecto
 DESCRIPCION:   devuelve el en varchar de la variable señalada 
 				en la tabla de varialbes globales
 				
                Web
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        09/08/2011
 COMENTARIOS:	
***************************************************************************

 

    HISTORIAL DE MODIFICACIONES:
       
 ISSUE            FECHA:              AUTOR                 DESCRIPCION
   
 #113              09/08/2011      jrr     KPLIAN     creacion
 ***************************************************************************/
 
 
 DECLARE
    v_nombre_funcion   	text;
    v_resp              varchar;
    v_respuesta         varchar;
    v_record record;
    v_consulta varchar;
 BEGIN
    v_nombre_funcion:='pxp.f_get_variable_global';
    v_respuesta='NULL';
    
  v_consulta='select valor as resp from pxp.variable_global v where v.variable='''||p_parametro||''' limit 1';
  
   raise notice 'get_parametro %',v_consulta;
                
      FOR  v_record in execute(v_consulta) LOOP
        
        v_respuesta = (v_record.resp);
        
      END LOOP;
      
     IF  v_respuesta is NULL and p_defecto IS NULL THEN      
      raise exception  'NO EXISTE UN VALOR PARA LA VARIABLE GLOBAL %',p_parametro;     
     END IF;

   
    
    return coalesce(v_respuesta,p_defecto);
    
    
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