CREATE OR REPLACE FUNCTION param.f_literal_periodo (
  p_id_periodo integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 documento: 	param.f_literal_periodo
 DESCRIPCION:   Funcion que obtiene el literal de un id_periodo (mes)
 AUTOR: 	    FAVIO FIGUEROA	
 FECHA:	        11/12/2015
 COMENTARIOS:	
***************************************************************************/
DECLARE
  v_fecha_ini DATE;
  v_fecha_fin Date;
  v_literal varchar;
  --save_tz text;
BEGIN

	--SHOW timezone into save_tz;
    

	select fecha_ini,fecha_fin 
    INTO v_fecha_ini,v_fecha_fin
    from param.tperiodo where id_periodo = p_id_periodo;
    
    v_literal:= to_char(v_fecha_ini , 'Month');
    
    v_literal:= TRIM(v_literal);
    
    IF v_literal = 'January' THEN
        v_literal := 'Enero';
    ELSIF v_literal = 'February' THEN
    	v_literal := 'Febrero';
    ELSIF v_literal = 'March' THEN
    	v_literal := 'Marzo';
    ELSIF v_literal = 'April' THEN
    	v_literal := 'Abril';
    ELSIF v_literal = 'May' THEN
    	v_literal := 'Mayo';
    ELSIF v_literal = 'June' THEN
    	v_literal := 'Junio';
	ELSIF v_literal = 'July' THEN
    	v_literal := 'Julio';
	ELSIF v_literal = 'August' THEN
    	v_literal := 'Agosto';
    ELSIF v_literal = 'September' THEN
    	v_literal := 'Septiembre';
    ELSIF v_literal = 'October' THEN
    	v_literal := 'Octubre';
    ELSIF v_literal = 'November' THEN
    	v_literal := 'Noviembre';
   ELSIF v_literal = 'December' THEN
    	v_literal := 'Diciembre';
   END IF;
   
    
   

   return v_literal;
END;
$body$
LANGUAGE 'plpgsql'
IMMUTABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;