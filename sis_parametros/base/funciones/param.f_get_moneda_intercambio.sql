--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_get_moneda_intercambio (
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		param.f_get_moneda_intercambio
 DESCRIPCION:   Devuelve la moneda de intercambio de la empresa si la tiene en otro caso devuelve NULL
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
    v_moneda_intercambio        varchar;
BEGIN
    
    v_nombre_funcion:='param.f_get_moneda_intercambio';
    
    v_moneda_intercambio = pxp.f_get_variable_global('moneda_intercambio');
    
    select id_moneda
    into v_id_moneda
    from param.tmoneda
    where tipo_moneda='intercambio';
    
    IF v_moneda_intercambio = 'true' THEN
      if(v_id_moneda is null)then
          raise exception 'No se ha definido una moneda de intercambio y esta definida como obligatoria';
      end if;
    END IF;
    
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