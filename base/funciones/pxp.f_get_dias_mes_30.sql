CREATE OR REPLACE FUNCTION pxp.f_get_dias_mes_30 (
  p_fecha_ini date,
  p_fecha_fin date
)
  RETURNS integer AS
  $body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_get_dias_mes_30
 DESCRIPCION:   Devuelve la cantidad de dias entre  dos fechas considerando un
 				maximo de 30 dias por mes
 AUTOR: 		jrr
 FECHA:	        18-06-2016 16:45:50
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/
DECLARE
  v_dias	 	integer;
  v_meses		integer;
  v_anos		integer;
  v_fecha_ini	date;
  v_fecha_fin	date;
BEGIN
  	if (p_fecha_fin < p_fecha_ini) then
    	raise exception 'La fecha inicio no puede ser mayor que la fecha fin';
    end if;
    v_dias = 0;
    v_meses = 0;
    v_anos = 0;
    v_fecha_fin = p_fecha_fin;
    v_fecha_ini = p_fecha_ini;

    --Si la fecha fin no es el ultimo dia del mes obtenemos el ultimo dia del mes del mes anterior
    -- y contamos los dias de la fecha fin
    if (pxp.f_obtener_ultimo_dia_mes(extract (month from p_fecha_fin)::integer, extract (year from p_fecha_fin)::integer) != p_fecha_fin) then
    	v_dias =  v_dias + extract(days from p_fecha_fin);
        v_fecha_fin = date_trunc('month',p_fecha_fin) - interval '1 day';
    end IF;

    --Si la fecha ini no es el primier dia del mes obtenemos el primer dia del mes del mes siguiente
    -- y contamos los dias de la fecha ini
    if (pxp.f_obtener_primer_dia_mes(extract (month from p_fecha_ini)::integer, extract (year from p_fecha_ini)::integer) != p_fecha_ini) then
    	v_dias =  v_dias + (30 - extract(days from p_fecha_ini) + 1);
        v_fecha_ini = date_trunc('month',p_fecha_ini + interval '1 month');
    end IF;

    --si la fecha_fin es mayor a la fecha_ini quiere decir q hay por lo menos 1 mes completo de diferencia
    --entre ambas
    if (v_fecha_fin > v_fecha_ini) then
    --obtenemos meses completos
    	v_meses = EXTRACT(month from age(v_fecha_fin , v_fecha_ini)) + 1 ;
    --obtenemos anos completos
        v_anos = EXTRACT(year from age(v_fecha_fin , v_fecha_ini));

    --si no es mayor quiere decir q no alcanza para un mes completo
    --hay q verificar por dias
    ELSE
    	--si la fecha_fin es mayor o igual al ultimo dia de la fech aini se resta los 30 dias menos
        --la fecha ini
    	if (p_fecha_fin >= pxp.f_obtener_ultimo_dia_mes(extract (month from p_fecha_ini)::integer, extract (year from p_fecha_ini)::integer)) then
    		v_dias = 30 - extract(days from p_fecha_ini) + 1;
            --si la fecha fin es mayor al ultimo dia de la fecha ini entonces tb sumamos los
            --dias correspondientes al siguiente mes
            if (p_fecha_fin > pxp.f_obtener_ultimo_dia_mes(extract (month from p_fecha_ini)::integer, extract (year from p_fecha_ini)::integer)) then
            	v_dias = v_dias + extract(days from p_fecha_fin);
            end if;
        --sino quiere decir q todo esta en el mismo mes simplemente restamos la fecha_fin menos la ini
        else
        	v_dias = p_fecha_fin - p_fecha_ini + 1;
    	end if;
    end if;
    --se retorna los anos por 360 los meses por 30 y los dias
    return (v_anos*360) + (v_meses*30) + v_dias;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;