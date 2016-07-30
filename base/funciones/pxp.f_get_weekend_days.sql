-- Function: pxp.f_get_weekend_days(date, date)

-- DROP FUNCTION pxp.f_get_weekend_days(date, date);

CREATE OR REPLACE FUNCTION pxp.f_get_weekend_days(p_ini date, p_fin date)
  RETURNS integer AS
$BODY$
/**************************************************************************
 FUNCION: 		pxp.f_get_weekend_days
 DESCRIPCION:   devuelve la cantidad de dias sabados y domingos en un rango de fechas
                Web
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        09/08/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
 
 
 DECLARE
    v_nombre_funcion   	text;
    v_resp              varchar;
    v_respuesta         integer;
    v_fecha		date;
    
 BEGIN
    v_nombre_funcion:='pxp.f_get_weekend_days';
    v_respuesta=0;
    v_fecha = p_ini;	
    while v_fecha <= p_fin loop
	if date_part( 'dow', v_fecha ) in (0,6) then
	    v_respuesta = v_respuesta + 1;
	end if;
	v_fecha = v_fecha + interval '1 day';
    end loop;
    
    
    return v_respuesta;
    
 EXCEPTION

	WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION pxp.f_get_weekend_days(date, date)
  OWNER TO jaime;
