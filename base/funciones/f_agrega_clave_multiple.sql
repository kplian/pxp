CREATE OR REPLACE FUNCTION pxp.f_agrega_clave_multiple (
  p_cad character varying,
  p_claves character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_agrega_clave_multiple
 DESCRIPCION:   Anade varios parametros de respuesta a la cadena que se va a devolver al servidor
                Web
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
	v_cad_ini varchar;
    v_cad_fin varchar;
    v_cad_ini_fin varchar;
    v_cad_fin_fin varchar;
    v_resp varchar;
    v_cadena varchar;
    v_aux varchar;
    v_claves varchar;
    v_sw boolean;
    v_pos_ini integer;
    v_pos_fin integer;
    v_clave varchar;
    v_pos_aux integer;
BEGIN
	--Inicializa variables
	v_cad_ini = '<';
	v_cad_fin = '>';
	v_cad_ini_fin = '</';
	v_cad_fin_fin = '>';
	v_sw=true;

	--Inicializa la cadena
	v_cadena = p_cad;
	v_claves = p_claves;
	--raise exception 'HOLA: %',v_claves;

	--Recorre todas las claves 
	LOOP
		if substr(ltrim(v_claves),1,1) = v_cad_ini then
			v_pos_ini=1;
			--Ubica el primer v_cad_fin
			v_pos_fin=position(v_cad_fin in v_claves);
			--Obtiene la cadena entre v_cad_ini y v_cad_fin
			v_clave = substr(v_claves,v_pos_ini+1,v_pos_fin-v_pos_ini-1);
			--raise exception 'FFF:%',v_clave;
			--Obtiene el valor de la clave
			v_cadena = pxp.f_agrega_clave(v_cadena,v_clave,pxp.f_obtiene_clave_valor(p_claves,v_clave,'','','valor'));
			--Corta la cadena de claves
			v_aux=v_cad_ini_fin||v_clave||v_cad_fin_fin;
			v_pos_aux = position(v_aux in v_claves);
			--raise exception '%',v_pos_aux;
			
			v_claves = substr(v_claves,v_pos_aux+length(v_aux),length(v_claves));
			--raise exception '%',v_claves;
		else
			exit;
		end if;

	END LOOP;
    --Devolver respuesta    
    return v_cadena;
  
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_array_p (OID = 304217) : 
--
