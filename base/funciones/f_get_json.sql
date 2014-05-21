CREATE OR REPLACE FUNCTION pxp.f_get_json (
  tabla varchar
)
RETURNS pg_catalog.json AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_json
 DESCRIPCION:   Obtiene el json de la tabla temporal insertada en la funcion
                DBIntermediario
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE

v_parametros                json;
v_consulta                  varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

BEGIN
     v_nombre_funcion:='pxp.f_get_json';

    v_consulta:= 'select row_to_json(t.*) from '||tabla||' t limit 1';
    
    execute v_consulta into v_parametros;
    return v_parametros;
    
EXCEPTION

       WHEN OTHERS THEN

         v_mensaje_error:=pxp.f_get_mensaje_err(SQLSTATE::varchar,SQLERRM::text,v_nombre_funcion,null);
         raise exception '%', v_mensaje_error;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;