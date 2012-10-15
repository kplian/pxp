CREATE OR REPLACE FUNCTION pxp.f_get_parametro_by_id (
  p_tabla character varying,
  p_parametro character varying,
  p_id character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_parametro_by_id
 DESCRIPCION:   devuelve el en varchar del parametros si existe
 				
                Web
 AUTOR: 	    KPLIAN (rac)	
 FECHA:	        09/08/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
 
 
 DECLARE
    v_nombre_funcion   	text;
    v_resp              varchar;
    v_respuesta         varchar;
    v_record record;
    v_consulta varchar;
 BEGIN
    v_nombre_funcion:='pxp.f_get_parametro_by_id';
    v_respuesta='NULL';
    
  v_consulta='select ('||p_parametro||')::varchar as resp  from '||p_tabla||' WHERE '||p_id;
  
  raise notice 'get_parametro %',v_consulta;
                
      FOR  v_record in execute(v_consulta) LOOP
        
        v_respuesta = (v_record.resp);
        
      END LOOP;

   
    
    return coalesce(v_respuesta,'NULL');
    
    
 EXCEPTION

	WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_get_record (OID = 304232) : 
--
