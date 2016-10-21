CREATE OR REPLACE FUNCTION pxp.f_resp_array (
  p_array character varying[],
  p_clave character varying,
  p_valor character varying,
  p_accion character varying
)
RETURNS varchar[]
AS 
$body$
/*
Autor: KPLIAN(rcm)
Fecha: 19/08/2010
Propósito: FOrmar la respuesta en forma de array en formato clave-valor
Dominio: p_accion: 'unico','unir',otros
*/
DECLARE

	v_ini varchar;
    v_fin varchar;
    v_cad varchar;
    v_array varchar[];
    v_valor varchar;
    v_procede boolean;
    v_fila integer;

BEGIN

	--Definición de constantes para el formato del arrray
	v_ini='{';
    v_fin='}';
    v_procede=false;
        
    --Verifica la acción a realizar con el array
    --return '{claveZZ,'||p_clave||'}';
    v_valor = pxp.f_array_ubicar_clave(p_array,p_clave);
    if p_accion = 'unico' then
    	--Verifica si en el array enviado ya existe registrada la clave enviada. Si no existe la crea. Si existe no hace nada
        if v_valor = '_false' then
        	--No Existe, entonces crea la clave valor
            v_valor = p_valor;
            v_procede=true;
        end if;
    elsif p_accion = 'unir' then
    	--Verifica si ya existe la clave enviada. Si hay concatena por delante el valor. Si no existe lo crea.
        if v_valor = '_false' then
        	--Crea
            v_valor = p_valor;
            v_procede=true;
        else
        	--Concatena el valor con lo obtenido
            v_valor = p_valor||'|'||v_valor;
            v_fila = pxp.f_array_ubicar_clave_posicion(p_array);
            v_array = p_array;
            v_array[v_fila][2]=v_valor;
        end if;
    else
    	--Cualquier caso. Siempre crea la clave
        v_valor = p_valor;
        v_procede=true;
    end if;
    
    --Preparación de la cadena para agregar al array
    v_cad = v_ini||p_clave||','||v_valor||v_fin;
    
    --Append de la cadena procesada si la bandera esta encendida
    if v_procede then
    	v_array=array_append(p_array,v_cad);
    end if;
    
    --Envío de respuesta
	RETURN v_array;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_resp_to_json (OID = 304248) : 
--
