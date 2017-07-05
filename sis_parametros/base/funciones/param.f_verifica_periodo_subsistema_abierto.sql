CREATE OR REPLACE FUNCTION param.f_verifica_periodo_subsistema_abierto (
p_id_periodo_subsistema integer,
p_lanzar_exception boolean = true
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		param.f_verifica_periodo_subsistema_abierto
 DESCRIPCION:   Verifica si un periodo subsistema esta abierto
 AUTOR: 	    rcm
 FECHA:			03/09/2013
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
    v_mensaje_error             varchar;
    v_id_moneda                 integer;
    v_estado					varchar;
    v_periodo					varchar;
    v_sistema					varchar;

BEGIN

    v_mensaje_error = 'exito';

	--Obtiene los datos del sistema y periodo
    select
    to_char(per.fecha_ini,'mm/yyyy'),sis.nombre
    into
    v_periodo, v_sistema
    from param.tperiodo_subsistema psis
    inner join param.tperiodo per
    on per.id_periodo = psis.id_periodo
    inner join segu.tsubsistema sis
    on sis.id_subsistema = psis.id_subsistema
    where psis.id_periodo_subsistema = p_id_periodo_subsistema;

	--Se obtiene el estado del periodo subsistema	
	select
    estado
    into v_estado
    from param.tperiodo_subsistema
    where id_periodo_subsistema = p_id_periodo_subsistema;
    
    --Verfica si está abierto
    if v_estado != 'abierto' then
        if p_lanzar_exception = false then
            v_mensaje_error = 'El periodo '||v_periodo||' del sistema '||v_sistema||' no está Abierto';
        else
            raise exception 'El periodo % del sistema % no está Abierto',v_periodo, v_sistema;
        end if;
    	
    end if;
    
    return v_mensaje_error;

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