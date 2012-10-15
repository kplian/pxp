CREATE OR REPLACE FUNCTION pxp.f_obtiene_clave_valor (
  p_cad character varying,
  p_clave character varying,
  p_valor character varying,
  p_accion character varying,
  p_respuesta character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_obtiene_clave_valor
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

	v_cad_ini varchar; --SEPARADOR INICIAL DE LA CLAVE
    v_cad_fin varchar; --SEPARADOR FINAL DE LA CLAVE
    v_cad_ini_fin varchar; --SEPARADOR INICIAL DEL CIERRE DE LA CLAVE
    v_cad_fin_fin varchar; --SEPARADOR FINAL DEL CIERRE DE LA CLAVE

	v_ini integer; --POSICION INICIAL DE LA CLAVE INICIAL
    v_fin integer; --POSICION INICIAL DE LA CLAVE FINAL
    
    v_clave_ini varchar; --CLAVE INICIAL CON LOS SEPARADORES INCLUIDOS
    v_clave_fin varchar; --CLAVE FINAL CON LOS SEPARADORES INCLUIDOS
    v_tam integer; --TAMAÑO DE LA CLAVE BUSCADA
    v_valor varchar; --VALOR ACTUAL DE LA CLAVE UBICADA
    
    v_valor_nuevo varchar;
    v_cad_ant varchar;
    v_cad_post varchar;
    v_cadena_accion varchar;
    
BEGIN
	--Inicialización de constantes
	v_cad_ini = '<';
    v_cad_fin = '>';
    v_cad_ini_fin = '</'||p_clave;
    v_cad_fin_fin = '>';
    
    /*v_cad_ini = '[';
    v_cad_fin = ':';
    v_cad_ini_fin = '';
    v_cad_fin_fin = '],';*/
    
	--Forma claves de busqueda
    v_clave_ini = v_cad_ini || p_clave || v_cad_fin;
    v_clave_fin = v_cad_ini_fin || v_cad_fin_fin;
    
	--Ubica la posicion inicial de la clave
	v_ini = strpos(p_cad,v_clave_ini);
    --raise notice 'clave_ini %  v_clave_fin %  ini %',v_clave_ini,v_clave_fin,v_ini;
    
    --Si no se ubica la clave
    if v_ini=0 then
    	return '';
    end if;
    
    --Obtiene el tamaño de la clave
    v_tam = length(v_clave_ini);
    
    --Suma al inicio el tamaño de la clave
    v_ini = v_tam + v_ini;
    
    --Ubica la posicion del cierre de clave
    v_fin = strpos(p_cad,v_clave_fin); --25=B
    --raise notice 'tam %  ini %  fin %',v_tam,v_ini,v_fin;
    
    if v_fin = 0 then
    	return '';
    end if;
    
    --Se obtiene el valor de la clave ubicada
    v_valor = substr(p_cad,v_ini,v_fin-v_ini);
    v_cadena_accion = p_cad;
    
    --Obtiene toda la cadena anterior
    v_cad_ant=substr(p_cad,1,v_ini-1);
    
    --Obtiene toda la cadena posterior
	v_cad_post=substr(p_cad,v_fin,length(p_cad)-v_fin+1);
    
    -- Verfica si la accion es cambiar, unir o nada
    if p_accion = 'cambiar' then
    	v_valor = p_valor;
    	v_cadena_accion = v_cad_ant || p_valor ||v_cad_post;	
    elsif p_accion = 'unir' then
    	v_valor = p_valor || ' - ' || v_valor;
    	v_cadena_accion = v_cad_ant || v_valor ||v_cad_post;	
    end if;

	if p_respuesta = 'valor' then
    	return v_valor;
    elsif p_respuesta = 'cadena' then
    	return v_cadena_accion;
    else
    	return v_cadena_accion;
    end if;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_registrar_log (OID = 304245) : 
--
