CREATE OR REPLACE FUNCTION param.f_get_moneda_base (
)
RETURNS integer
AS 
$body$
/**************************************************************************
 FUNCION: 		param.f_get_moneda_base
 DESCRIPCION:   Devuelve la moneda base de la empresa
 AUTOR: 	    KPLIAN (jrr)	
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
    v_nombre_funcion:='param.f_get_moneda_base';
    
    select id_moneda
    into v_id_moneda
    from param.tmoneda
    where tipo_moneda='base';
    
    if(v_id_moneda is null)then
        raise exception 'No se ha definido una moneda base en el sistema';
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
    LANGUAGE plpgsql;
--
-- Definition for function f_inserta_alarma (OID = 304012) : 
--
