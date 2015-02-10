CREATE OR REPLACE FUNCTION pxp.f_resp_to_json (
  p_xml character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_resp_to_json
 DESCRIPCION:   Convierte la cadena de respuesta a una cadena json
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

	v_cad varchar;
    i integer;
    v_tam integer;
    v_array_claves varchar[];
    v_sub_cad varchar;
    v_pos_ini integer;
    v_pos_fin integer;
    v_clave varchar;
    v_cad_ini varchar;
    v_cad_fin varchar;
    v_cad_ini_fin varchar;
    v_cad_fin_fin varchar;
    v_nom_clave_ini varchar;
    v_nom_clave_fin varchar;
    v_aux varchar;
    v_resp varchar;

BEGIN
	--Inicialización de constantes
	v_cad_ini = '<';
    v_cad_fin = '>';
    v_cad_ini_fin = '</';
    v_cad_fin_fin = '>';

	v_cad=p_xml;
    v_tam=length(v_cad);
    
    loop
    	v_sub_cad='';
    	--Obtener la posicion del primer <
        v_pos_ini=strpos(v_cad,'<');
        --Obtener la posicion del primer >
        v_pos_fin=strpos(v_cad,'>');
        --Obtener la cadena siguiente del < hasta el >
        v_clave=substr(v_cad,v_pos_ini+1,v_pos_fin-2);
        --raise notice 'clave: %',v_clave;
        --Obtiene los nombres de las claves serializadas
        v_nom_clave_ini=v_cad_ini||v_clave||v_cad_fin;
        v_nom_clave_fin=v_cad_ini_fin||v_clave||v_cad_fin_fin;                
        --Obtiene el valor a partir de la clave
        v_sub_cad=pxp.f_obtiene_clave_valor(v_cad,v_clave,'','','valor');
        --Borrar de la cadena grande la cadena encontrada
        v_pos_fin=strpos(v_cad,v_nom_clave_fin);
        
        v_cad=substr(v_cad,v_pos_fin+length(v_nom_clave_fin),length(v_cad));
        --Guarda la subcadena en un array
        v_aux='"'||v_clave||'"'||':'||'"'||v_sub_cad||'"';
        v_array_claves=array_append(v_array_claves,v_aux);
        --raise exception '%',v_aux;
        exit when length(v_cad)=0;
    end loop;
    
    for i in 1..array_upper(v_array_claves,1) loop
    	--raise notice '%',v_array_claves[i];
        if i=1 then
        	v_resp = '{'||v_array_claves[i]||',';
        elsif i=array_upper(v_array_claves,1) then
        	v_resp = v_resp || v_array_claves[i] ||'}';
        else
        	v_resp = v_resp || v_array_claves[i]||',';
        end if;
    end loop;
    
    return v_resp;
    

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_runtime_config (OID = 304249) : 
--
