CREATE OR REPLACE FUNCTION pxp.f_get_record (
  tabla character varying
)
RETURNS record
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_record
 DESCRIPCION:   Obtiene el record de la tabla temporal insertada en la funcion
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

v_parametros                record;
v_consulta                  varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

BEGIN
     v_nombre_funcion:='pxp.f_get_record';

    v_consulta:= 'select * from '||tabla||' limit 1';
    
    execute v_consulta into v_parametros;
    return v_parametros;
    
EXCEPTION

       WHEN OTHERS THEN

         v_mensaje_error:=pxp.f_get_mensaje_err(SQLSTATE::varchar,SQLERRM::text,v_nombre_funcion,null);
         raise exception '%', v_mensaje_error;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_get_variable_global (OID = 304233) : 
--
