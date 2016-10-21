CREATE OR REPLACE FUNCTION pxp.f_array_ubicar_clave_posicion (
  p_array character varying[],
  p_clave character varying
)
RETURNS integer
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_ubicar_clave_posicion
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
  	v_valor integer;
  	v_array varchar[];
    v_tam integer;
BEGIN
	v_valor=-1;
    v_array=p_array;
    v_tam=COALESCE(array_upper(p_array,1),0);
    
	for i in 1..v_tam loop
       	if p_array[i][1]=p_clave then
        	v_valor=i;
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
-- Definition for function f_campo_constraint (OID = 304220) : 
--
