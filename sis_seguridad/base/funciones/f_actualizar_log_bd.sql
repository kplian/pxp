CREATE OR REPLACE FUNCTION segu.f_actualizar_log_bd (
  par_url_log varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.f_actualizar_log_bd
 DESCRIPCION: 	Actualiza la tabla log a partir de los logs del
                motor de bd
 AUTOR: 		KPLIAN(jrr)
 FECHA:			08/03/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
    v_registros       record;
    v_nombre_funcion  varchar;
    v_resp            varchar;
    v_fecha_actual    date;
    v_fecha_max_log   timestamp;
    v_fecha_tope	  date;
    v_fecha_archivo	  date;
    v_fecha_min_tt    timestamp;
    v_tipo_log        varchar;
    v_consulta        varchar;
BEGIN
    v_nombre_funcion:='segu.f_actualizar_log_bd';

    select max(l.fecha_reg), max(l.fecha_reg)::date
    into v_fecha_max_log, v_fecha_tope
    from segu.tlog l
    where l.tipo_log='LOG_BD' or l.tipo_log='ERROR_BD';
    
    execute ('
    create temporary table tt_log_bd(
        fecha_hora timestamp(3) with time zone, usuario text, bd text,  pid integer,
        ip_puerto text, id_sesion text, numero_accion bigint,
        etiqueta_comando text,fecha_hora_sesion timestamp with time zone,
        id_transaccion_vir text, id_transaccion_regu bigint,tipo_log varchar,
        codigo_error varchar, mensaje text, detalle_mensaje text,
        sugerencia text, consulta_interna_error text,
        carac_pos_error integer, error_context text,
        consulta_error text, cantidad_carac_pos_error integer,
        ubicacion text,
        nombre_aplicacion text) on commit drop');
        
    if (v_fecha_tope is null) then
    	v_fecha_tope = now()::date;
    end if;
    v_fecha_archivo = now()::date;
          
    while(v_fecha_archivo >= v_fecha_tope)loop
    
        if (pxp.file_exists(par_url_log||'-'||
        					to_char(v_fecha_archivo,'YYYY-MM-DD')||'.csv') = 1) then
    		
            execute ('
            COPY tt_log_bd
            FROM '''||par_url_log||'-'||to_char(v_fecha_archivo,'YYYY-MM-DD')||'.csv''
            WITH csv;');
        end if;
        
        v_fecha_archivo = v_fecha_archivo - interval '1 day';
        
        
    end loop;
    
    for v_registros in
    (select *
    from tt_log_bd
    where v_fecha_max_log is null or date_trunc('second',fecha_hora)>v_fecha_max_log)loop
    
    if(current_database()::text=v_registros.bd and v_registros.codigo_error!='P0001')then
        if(v_registros.tipo_log='ERROR')then
            v_tipo_log='ERROR_BD';
            v_consulta=v_registros.consulta_error;
        else
            v_tipo_log='LOG_BD';
            v_consulta=v_registros.mensaje;
        end if;
    
    
        insert into segu.tlog(
            ip_maquina,tipo_log,descripcion,
            fecha_reg,estado_reg,procedimientos,
            transaccion,consulta,tiempo_ejecucion,
            usuario_base,codigo_error,
            dia_semana,
            pid_db,pid_web,sid_web,si_log
        ) values(
            v_registros.ip_puerto,v_tipo_log,v_registros.mensaje,
            v_registros.fecha_hora,'activo','base de datos',
            'ninguna',v_consulta,0,
            v_registros.usuario,v_registros.codigo_error,
            to_char(v_registros.fecha_hora,'D')::integer,
            v_registros.pid,0,v_registros.id_sesion,1
        );
    end if;
     
    
    
    end loop;

    return 'exito';

EXCEPTION

       WHEN OTHERS THEN

       	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%,%',v_resp,v_consulta;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;