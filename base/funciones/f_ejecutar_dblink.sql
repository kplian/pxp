CREATE OR REPLACE FUNCTION pxp.f_ejecutar_dblink (
  p_cadena character varying,
  p_opcion character varying
)
RETURNS record
AS 
$body$
/**************************************************************************
 FUNCION: pxp.f_ejecutar_dblink
 DESCRIPCIÓN: Guarda la sesion o el log mediante un dblink, la cadena
                indica los parametros que se van a guardar
 AUTOR:         KPLIAN(jrr)
 FECHA:
 COMENTARIOS:


***************************************************************************
 HISTORIA DE MODIFICACIONES:
 DESCRIPCION: se vuelve dinámico el usuario de base de datos con el que se conecta el dblink (linea 31 a la 34)
 AUTOR: KPLIAN(rcm)
 FECHA: 24-03-2011
***************************************************************************
*/

DECLARE
    v_resp      record;
    v_res_cone  varchar;
    v_database  varchar;
    v_respuesta varchar;
    v_nombre_funcion   text;
    v_mensaje_error    text;
    v_usr_bd 		varchar;
BEGIN
    v_nombre_funcion='f_ejecutar_dblink';
    v_database=current_database();
    v_usr_bd=v_database||'_conexion';
    
    --RCM 24-03-2011: modificación a usuario de bd dinámico
    --v_res_cone=(select dblink_connect('user=bdweb_conexion dbname='||v_database));
    v_res_cone=(select dblink_connect('user=' || v_usr_bd ||' dbname='||v_database));
    --FIN RCM
	
    if(p_opcion='log')then
    	
        SELECT * FROM
            dblink(
                'select * from pxp.f_registrar_log'||p_cadena,true)
            AS t1(id_log integer)
            into v_resp;
            
         
        v_res_cone=(select dblink_disconnect());
    elsif(p_opcion='sesion')then
    	
        SELECT * FROM
            dblink(
                'select * from segu.f_actualizar_sesion'||p_cadena,true)
            AS t1(res varchar)
            into v_resp;
        
        v_res_cone=(select dblink_disconnect());
    end if;
    
    return v_resp;
EXCEPTION

      WHEN OTHERS THEN
      
    	v_respuesta = '';
		v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
    	v_respuesta = pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
  		v_respuesta = pxp.f_agrega_clave(v_respuesta,'tipo_respuesta','ERROR'::varchar);
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);

        --raise exception '%',v_respuesta;
        
        --RCM 31/01/2012: Cuando la llamada a esta funcion devuelve error, el manejador de excepciones de esa función da el resultado,
        --por lo que se modifica para que devuelva un json direcamente
		raise exception '%',pxp.f_resp_to_json(v_respuesta);
      
END;
$body$
    LANGUAGE plpgsql STRICT SECURITY DEFINER;
--
-- Definition for function f_excel (OID = 304225) : 
--
