--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_recupera_clave (
  p_cad varchar,
  p_clave varchar
)
RETURNS text [] AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_recupera_clave
 DESCRIPCION:   Recupera valor de un XML,  recibe como parametro la cadena XML y el nombre de la clomulmna
                retorna una array de texto con los valores
                Web
 AUTOR: 	    KPLIAN (rac)	
 FECHA:	        04/11/2014
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE
   v_resp text[];
   v_xmlcad varchar;
BEGIN
    v_xmlcad = '<?xml version="1.0" ?><response>'||p_cad||'</response>';
    
    WITH x(col) AS (

      SELECT v_xmlcad::xml)
      SELECT xpath('./'||p_clave||'/text()', col) AS status
      into v_resp
      FROM   x;
      
    return v_resp;
  
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;