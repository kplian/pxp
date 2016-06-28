CREATE OR REPLACE FUNCTION pxp.f_valida_numero_tarjeta_credito (
  p_numero varchar,
  p_tipo varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_valida_numero_tarjeta_credito
 DESCRIPCION:   Valida si el numero de tarjeta de credito es valido
 AUTOR: 		 (jrivera)
 FECHA:	        05-11-2014 21:58:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

-----------------------------------------
-- CUERPO DE LA FUNCIÓN --
-----------------------------------------

DECLARE

    
    v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    

BEGIN
	v_nombre_funcion = 'pxp.f_valida_numero_tarjeta_credito';
   			IF p_tipo = 'VI' THEN --VISA 
            
                --validamos el codigo
                if (Select substring(p_numero from 1 for 1) <> '4')then
                    raise exception 'El número de tarjeta no corresponde a una tarjeta VISA. Revise el número y el tipo de tarjeta.';
                end if;
                
                --validamos la cantidad de digitos
                if( select char_length(p_numero) <> 16)then
                    raise exception 'El número de tarjeta VISA debe tener 16 digitos.  Revise los datos.';
                end if;
                
            ELSIF p_tipo = 'AX' THEN --AMERICAN EXPRESS
            
                --validamos el codigo
                if (Select substring(p_numero from 1 for 2) <> '37')then
                    raise exception 'El número de tarjeta no corresponde a una tarjeta AMERICAN EXPRESS. Revise el número y el tipo de tarjeta.';
                end if;
                
                --validamos la cantidad de digitos
                if( select char_length(p_numero) <> 15)then
                    raise exception 'El número de tarjeta AMERICAN EXPRESS debe tener 15 digitos. Revise los datos.';
                end if;
                
            ELSIF p_tipo = 'DC' THEN --DINERS CLUB
            
                --validamos el codigo
                if (Select substring(p_numero from 1 for 2) <> '36')then
                    raise exception 'El número de tarjeta no corresponde a una tarjeta DINERS CLUB. Revise el número y el tipo de tarjeta.';
                end if;
                
                --validamos la cantidad de digitos
                if( select char_length(p_numero) <> 14)then
                    raise exception 'El número de tarjeta DINERS CLUB debe tener 14 digitos. Revise los datos.';
                end if;
                
            ELSIF p_tipo = 'CA' THEN --MASTER CARD
            
                --validamos el codigo
                if (Select substring(p_numero from 1 for 1) <> '5' AND 
                            substring(p_numero from 1 for 2) <> '60' AND
                            substring(p_numero from 1 for 2) <> '62' AND
                            substring(p_numero from 1 for 2) <> '63' AND
                            substring(p_numero from 1 for 2) <> '67' )then
                	
                    raise exception 'El número de tarjeta no corresponde a una tarjeta MASTER CARD. Revise el número y el tipo de tarjeta.';
                end if;
                
                --validamos la cantidad de digitos
                if (Select substring(p_numero from 1 for 2) = '67')then
                
                    if( (select char_length(p_numero) < 16) or (select char_length(p_numero) > 19) )then
                        raise exception 'El número de tarjeta MASTER CARD debe tener 16, 17, 18 o 19 digitos. Revise los datos.';
                    end if;
                    
                else
                
                    if( select char_length(p_numero) <> 16)then
                        raise exception 'El número de tarjeta MASTER CARD debe tener 16 digitos. Revise los datos.';
                    end if;
                    
                end if;
                    
                
            ELSIF p_tipo = 'RE' THEN --RED ENLACE BOLIVIA
            
                --validamos el codigo
                if (Select substring(p_numero from 1 for 2) <> '89')then
                    raise exception 'El número de tarjeta no corresponde a una tarjeta RED ENLACE BOLIVIA. Revise el número y el tipo de tarjeta.';
                end if;
                
                --validamos la cantidad de digitos
                if( select char_length(p_numero) <> 16)then
                    raise exception 'El número de tarjeta debe tener 16 digitos. Revise los datos.';
                end if;
                
            
            ELSE
                raise exception 'El tipo de tarjeta de credito no es valido. Ingrese un tipo de tarjeta valido';
            END IF;
  
     return 'exito';
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