CREATE OR REPLACE FUNCTION pxp.f_existe_parametro (
  p_tabla character varying,
  p_parametro character varying
)
RETURNS boolean
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_existe_parametro
 DESCRIPCION:   devuelve true si existe el parametro en la tabla indicada y false si no existe
                Web
 AUTOR: 	    KPLIAN (jrr)	
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
    v_respuesta         boolean;
 BEGIN
    v_nombre_funcion:='pxp.f_existe_parametro';
    v_respuesta=false;
    
    if(exists ( select 1
                from pg_class c
                inner join pg_catalog.pg_attribute a
                    on c.oid = a.attrelid
                where c.relname=p_tabla and a.attname ilike p_parametro))then
                
        v_respuesta=true;
    end if;
    
    return v_respuesta;
    
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
-- Definition for function f_get_mensaje_err (OID = 304227) : 
--
