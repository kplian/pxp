--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_agrega_clave (
  p_cad varchar,
  p_clave varchar,
  p_valor varchar,
  p_tipo varchar = 'cambiar'::character varying
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_agrega_clave
 DESCRIPCION:   Anade un parametro de respuesta a la cadena que se va a devolver al servidor
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
    v_clave varchar;
    v_valor varchar;
BEGIN

--RCM: 22/03/2011 Verifica los parámetros para prevenir que vengan nulos. Si es así se hace un coalesce para evitar problemas en concatenación
    v_clave = COALESCE(p_clave,'indefinido');
    v_valor = COALESCE(p_valor,'');
    
    --Para hacer el trim se verifica que no sea cadena vacía porque hay un bug que al aplicar trim sobre la cadena vacía aparentemente lo vuelve null
    if v_valor != '' then
        v_valor = trim(p_valor);
    end if;


--Inicialización de constantes
v_cad_ini = '<';
    v_cad_fin = '>';
    v_cad_ini_fin = '</'||v_clave;
    v_cad_fin_fin = '>';
    
    /*v_cad_ini = '';
    v_cad_fin = ':';
    v_cad_ini_fin = '';
    v_cad_fin_fin = ',';*/
    
    --Se vacía la cadena en variables locales
    v_cadena=COALESCE(p_cad,'');

    --Verifica si la clave es mensaje y si ya fue serializada para no volver a serializar
    if v_clave = 'mensaje' then
    
      IF p_tipo = 'cambiar'  then
          --raise notice 'substr: %     v_cad_ini: %  v_valor: %',substr(ltrim(v_cadena),1,1),v_cad_ini,v_valor;
         if substr(ltrim(v_valor),1,1) = v_cad_ini then
            return v_valor;
          end if;
      ELSE
         if pxp.f_obtiene_clave_valor(v_cadena,v_clave,'','','valor') <> '' then
           v_aux =pxp.f_obtiene_clave_valor(v_cadena,v_clave,v_valor,'unir','');
           return v_aux;
        end if;
        
      END IF;
    end if;
    
    --Verifica si ya esta registrado el 'codigo_error'
    if v_clave = 'codigo_error' then
     if pxp.f_obtiene_clave_valor(v_cadena,v_clave,'','','valor') <> '' then
         return p_cad;
        end if;
    end if;
    
    --Verifica si ya se registro el codigo procedimiento
    if v_clave = 'procedimientos' then
         if pxp.f_obtiene_clave_valor(v_cadena,v_clave,'','','valor') <> '' then
           v_aux =pxp.f_obtiene_clave_valor(v_cadena,v_clave,v_valor,'unir','');
           return v_aux;
        end if;
    end if;
    
    --Arma la rama
    v_aux = v_cad_ini || v_clave ||v_cad_fin || replace(v_valor,'"','#*#') || v_cad_ini_fin || v_cad_fin_fin;
    
    --Agregar la rama
    v_cadena = v_cadena || v_aux;
    --Devolver respuesta    
    return v_cadena;
  
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;