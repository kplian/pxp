CREATE OR REPLACE FUNCTION pxp.f_array_ubicar_clave (
  p_array character varying[],
  p_clave character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_ubicar_clave
 DESCRIPCION:   
 AUTOR: 	    KPLIAN (rcm)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE
	i integer;
  	v_valor varchar;
  	v_array varchar[];
    v_tam integer;
BEGIN
	v_valor='_false';
    v_array=p_array;
    v_tam=COALESCE(array_upper(p_array,1),0);
    
	for i in 1..v_tam loop
       	if p_array[i][1]=p_clave then
        	v_valor=p_array[i][2];
            return v_valor;
        end if;
    end loop;
	return v_valor;
/*EXCEPTION
WHEN OTHERS THEN
  return '_false';*/
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_array_ubicar_clave_posicion (OID = 304219) : 
--
