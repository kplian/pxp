--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_periodo_subsistema_abierto (
  p_fecha date,
  p_codigo_subsistema varchar
)
RETURNS boolean AS
$body$
/*
	Autor: Rensi (kplian)
    Fecha: 07/08/2015
    Descripción: Verifica si el periodo del susbisitema esta abierto o cerrado, 
*/

DECLARE
   v_id_periodo  	integer;
   v_id_gestion 	integer;
   v_id_subsistema	integer;
   v_estado			varchar;
   v_resp			varchar;
   v_nombre_funcion	varchar;
BEGIN
    
     v_nombre_funcion = 'param.f_periodo_subsistema_abierto';
	--Verifica la fecha recibida
    if p_fecha is null then
    	raise exception 'Error al encontrar periodo: la fecha no debe estar vacía.';
    end if;
    
    --Obtiene los datos
    select
      id_periodo, 
      id_gestion
    into 
       v_id_periodo, 
       v_id_gestion
    from param.tperiodo per
    where p_fecha between per.fecha_ini and per.fecha_fin;
    
    
    --obtiene el id del sistema
    select
     s.id_subsistema
    into 
      v_id_subsistema
    from segu.tsubsistema s 
    where s.codigo = p_codigo_subsistema;
    
    IF v_id_subsistema  is null THEN
       raise exception 'no se encontro un sistema para el código %', p_codigo_subsistema;
    END IF;
    
    select 
         ps.estado
      into 
         v_estado
    from param.tperiodo_subsistema ps
    where     id_periodo = v_id_periodo
          and id_subsistema = v_id_subsistema;
    
    IF v_estado = 'abierto' THEN
       return TRUE;
    ELSE
       return FALSE;
    END IF;
    
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