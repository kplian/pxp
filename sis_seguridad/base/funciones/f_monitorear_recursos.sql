CREATE OR REPLACE FUNCTION segu.f_monitorear_recursos (
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.f_monitorear_recursos
 DESCRIPCION: 	Monitorea el uso de recursos en el servidor de base de datos
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
    v_res       integer;
    v_curdb     varchar;
    v_resp          varchar;
    v_nombre_funcion   text;
    v_pa_pid		varchar;
    v_pa_query		varchar;
    
BEGIN
    v_nombre_funcion='segu.f_monitorear_recursos';
    v_curdb=current_database();
    v_res=pxp.monitor_phx(1);
    execute ('
    create temporary table tt_procesos_so(
        pid integer, proceso varchar, usuario varchar,  pcpu numeric,
        pmem numeric, vmstat varchar) on commit drop');
        
    COPY tt_procesos_so
    FROM '/tmp/procesos.csv'
    WITH csv;
    
    if (split_part(version(),' ',2) >= '9.3.0') then
    	v_pa_pid = 'pa.pid';
        v_pa_query = 'pa.query';
    else
    	v_pa_pid = 'pa.procpid';
        v_pa_query = 'pa.current_query';
    end if;
    
    execute ('CREATE TEMPORARY TABLE tt_monitor_recursos ON COMMIT DROP AS
                select pa.usename::varchar as usuario_bd,
                s.transaccion_actual,s.funcion_actual,
                ' || v_pa_query || '::text as consulta,to_char(s.inicio_proceso,''DD/MM/YYYY HH24:MI:SS'') as hora_inicio_proceso,
                to_char(query_start,''DD/MM/YYYY HH24:MI:SS'') as hora_inicio_consulta,
                mbd.pid as pid_bd,
                mbd.proceso as proceso_bd,
                mbd.usuario as usuario_pbd,
                mbd.pcpu as pcpu_bd,
                mbd.pmem as pmem_bd,
                mbd.vmstat as vmstat_bd,
                mweb.pid as pid_web,
                mweb.proceso as proceso_web,
                mweb.usuario as usuario_web,
                mweb.pcpu as pcpu_web,
                mweb.pmem as pmem_web,
                mweb.vmstat as vmstat_web,
                s.variable as sid_web
                from segu.tsesion s
                inner join tt_procesos_so mbd
                on(mbd.pid=s.pid_bd)
                inner join pg_stat_activity pa
                on(' || v_pa_pid || '=mbd.pid)
                inner join tt_procesos_so mweb
                on(mweb.pid=s.pid_web)
                where datname='''||v_curdb||'''');
    return 'exito';
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