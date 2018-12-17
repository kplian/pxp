CREATE OR REPLACE FUNCTION pxp.f_add_dias_fecha (
  p_fecha date,
  p_cant_dias integer,
  p_tipo varchar = 'calendario'::character varying
)
RETURNS date AS
$body$
/**************************************************************************
 SISTEMA:   	PXP
 FUNCION:     	pxp.f_add_dias_fecha
 DESCRIPCION:   Agrega la cantidad de días especificado a una fecha, pudiendo considerar días calendario o sólo días hábiles en función del p_tipo
 AUTOR:      	RCM
 FECHA:         16/11/2017
 COMENTARIOS: 
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/
DECLARE

	v_nombre_funcion    text;
    v_resp              varchar;
    v_fecha				date;
    v_fecha_ant			date;
    v_sql				varchar;
    v_cant_dias_habiles integer;
    v_cant_dias_no_habiles integer;
    v_cont integer;

BEGIN

	v_nombre_funcion = 'pxp.f_add_dias_fecha';
    
    --Verificación de p_tipo
    if p_tipo not in ('calendario','habiles') then
    	raise exception 'Tipo desconocido (%)',coalesce(p_tipo,'null');
    end if;
--    raise notice '-----Iniciando: %   aumentar % dias',p_fecha,p_cant_dias;
    --Adición de los días en función del p_tipo
    if p_tipo = 'calendario' then
        v_fecha = p_fecha + (p_cant_dias||' day')::interval;
    else
    
    	v_fecha = p_fecha + (p_cant_dias||' day')::interval;
        v_cant_dias_habiles = pxp.f_get_dias_habiles(p_fecha,v_fecha);
        v_cant_dias_no_habiles = p_cant_dias - v_cant_dias_habiles;
        
  --      raise notice '@@@@fecha inicial: %, dias habiles: %, dias no habiles: % ',v_fecha,v_cant_dias_habiles,v_cant_dias_no_habiles;
        v_cont=0;
        while v_cant_dias_no_habiles > 0 and v_cont<10 loop
	        --Reinicializa variable
            v_fecha_ant = v_fecha;
        	--Incremento de días hábiles
        	v_fecha = v_fecha_ant + (v_cant_dias_no_habiles||' day')::interval;
            v_cant_dias_habiles = pxp.f_get_dias_habiles(v_fecha_ant,v_fecha);
	        v_cant_dias_no_habiles = v_cant_dias_no_habiles - v_cant_dias_habiles;
    --        raise notice 'fecha_ant: %, fecha: %, dias habiles: %, dias no habiles: %',v_fecha_ant, v_fecha,v_cant_dias_habiles,v_cant_dias_no_habiles;
            v_cont=v_cont+1;
        end loop;
    
    end if;
    
    --Respuesta
    return v_fecha;

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

