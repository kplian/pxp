CREATE OR REPLACE FUNCTION pxp.f_dblink (
  p_host character varying,
  p_puerto character varying,
  p_dbname character varying,
  p_user character varying,
  p_password character varying,
  p_sql character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA ENDESIS 
***************************************************************************
 SCRIPT: 		f_dblink
 DESCRIPCIÓN: 	Permite ejecutar una instrucción sql en otro servidor de base de datos con dblink
 AUTOR: 		RCM
 FECHA:			23/03/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------


--**** DECLARACION DE VARIABLES DE LA FUNCIÓN (LOCALES) ****---
DECLARE

	v_respuesta varchar;
    v_cadena_cnx varchar;

BEGIN

	--Verifica que los parámetros enviados ninguno sea nulo
    if coalesce(p_host,'')='' or coalesce(p_puerto,'')='' or coalesce(p_dbname,'')='' or coalesce(p_password,'')='' or coalesce(p_sql,'')='' then
    	raise exception 'No se puede realizar la conexión con el host destino: parámetros inválidos, ningún parámetro debe ser nulo o vacío';
    end if;
    
	--Forma la cadena de conexión
    v_cadena_cnx = 'hostaddr='||p_host||' port='||p_puerto||' dbname='||p_dbname||' user='||p_user||' password='||p_password;
      -- raise exception 'cadena%',p_sql;
    --Ejecuta el dblink
    v_respuesta = dblink_exec(v_cadena_cnx,p_sql);
     
	--Devuelve la respuesta
    return v_respuesta;    

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_ejecutar_dblink (OID = 304224) : 
--
