--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_get_moneda_actualizacion (
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		param.f_get_moneda_actualizacion
 DESCRIPCION:   Devuelve la moneda de actualizacion de la empresa
 AUTOR: 	    KPLIAN (rac)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE

    
    v_resp                      varchar;
    v_nombre_funcion            text;
    v_mensaje_error             text;
    v_id_moneda                 integer;
BEGIN
    v_nombre_funcion:='param.f_get_moneda_actualizacion';
    
    select id_moneda
    into v_id_moneda
    from param.tmoneda
    where actualizacion = 'si';
    
    if(v_id_moneda is null)then
        raise exception 'No se ha definido una moneda de actualizacion en el sistema';
    end if;
    return v_id_moneda;

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