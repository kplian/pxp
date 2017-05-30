CREATE OR REPLACE FUNCTION pxp.f_existe_parametro (
  p_tabla varchar,
  p_parametro varchar
)
RETURNS boolean AS
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
    v_oid				bigint;
 BEGIN
    v_nombre_funcion:='pxp.f_existe_parametro';
    v_respuesta=false;
    
    select c.oid into v_oid
    from pg_class c  
    where c.relname=p_tabla;
    
    if(exists ( select 1
                from pg_catalog.pg_attribute a                    
                where a.attrelid = v_oid and a.attname ilike p_parametro))then
                
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;