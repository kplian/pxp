CREATE OR REPLACE FUNCTION pxp.f_registrar_log (
  par_id_usuario integer,
  par_ip varchar,
  par_mac varchar,
  par_tipo_log varchar,
  par_descripcion text,
  par_procedimientos text,
  par_transaccion varchar,
  par_consulta varchar,
  par_tiempo_ejecucion integer,
  par_usuario_base varchar,
  par_codigo_error varchar,
  par_pid_db integer,
  par_sid_web varchar,
  par_pid_web integer,
  par_id_subsistema integer,
  par_log integer,
  par_id_usuario_ai integer = NULL::integer,
  par_nom_usuario_ai varchar = NULL::character varying
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_intermediario_ime
 DESCRIPCIÓN: 	Inserta registro de bitacora
 AUTOR: 		KPLIAN(jrr)
 FECHA:			26/07/2010

***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	 returning id_log
 AUTOR:			 KPLIAN(rac)
 FECHA:			 29-11-10
***************************************************************************
HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	 se anade el parametro par_log si es 1 se muestra en el
                log sino(0) solo en el monitor
 AUTOR:			 KPLIAN(jrr)
 FECHA:			 03-03-2011
***************************************************************************/

declare
       g_separador_error     varchar;
       g_separador_inicial   varchar;
       g_separador_funcion   varchar;
       g_mensaje_nuevo       text;
       g_descripcion         text;
       g_procedimientos      text;
       g_transaccion         varchar;
       g_tipo_log            varchar;
       v_id_log				 integer;
       v_resp                varchar;
       v_pid_db             integer;
       v_cuenta             varchar;
       v_subsistema         varchar;
       v_desc_transaccion   varchar;
       v_registro           record;
       v_interval           interval;
       v_registrar_log		varchar;

begin
    v_resp=pxp.f_runtime_config('LOG_STATEMENT','LOCAL','none');
    
     select valor into g_separador_inicial from pxp.variable_global vg where vg.variable='separador_inicial';
     select valor into g_separador_error from pxp.variable_global vg where vg.variable='separador_error';
    if(par_pid_db is null)then
        v_pid_db=pg_backend_pid();
    else
        v_pid_db=par_pid_db;
    end if;
    if(par_id_subsistema is not null)then
        select codigo
        into v_subsistema
        from segu.tsubsistema
        where id_subsistema=par_id_subsistema;
    end if;
    if(par_id_usuario is not null) then
        select cuenta
        into v_cuenta
        from segu.tusuario
        where id_usuario=par_id_usuario;
    end if;
    v_registrar_log = 'si';
    if(par_transaccion is not null)then
        select descripcion,p.habilita_log
        into v_desc_transaccion ,v_registrar_log
        from segu.tprocedimiento p
        where codigo=par_transaccion;
        
    end if;
    v_id_log = 0;
    if ((v_registrar_log = 'si' and par_transaccion not like '%_CONT') or par_tipo_log like 'ERROR_%' or par_transaccion is null ) then
        v_id_log=(select nextval('segu.tlog_id_log_seq'));
        --RAC, RCM: cambios para qe devuelva el id_log
         
         insert into segu.tlog(
         id_log,
         id_usuario,mac_maquina,ip_maquina,tipo_log,descripcion,fecha_reg,
         estado_reg,procedimientos,transaccion,consulta,tiempo_ejecucion,
         usuario_base,codigo_error,dia_semana,pid_db,pid_web,sid_web,cuenta_usuario,
         descripcion_transaccion,codigo_subsistema,id_subsistema,si_log,id_usuario_ai,usuario_ai
         ) values(
         v_id_log,
         par_id_usuario,par_mac,par_ip,par_tipo_log,par_descripcion,now(),'activo',
         par_procedimientos,par_transaccion,par_consulta,par_tiempo_ejecucion,
         par_usuario_base,par_codigo_error,to_char(now(),'D')::integer,
         v_pid_db,par_pid_web,par_sid_web,v_cuenta,
         v_desc_transaccion,v_subsistema,par_id_subsistema,par_log,par_id_usuario_ai, par_nom_usuario_ai
         ) ;
	end if;
    
    IF(par_tipo_log in('ERROR_WEB','ERROR_CONTROLADO_PHP','INYECCION','SESION',
                        'ERROR_TRANSACCION_BD','ERROR_CONTROLADO_BD',
                        'ERROR_PERMISOS','ERROR_BLOQUEO','ERROR_ACCESO'))THEN
                        
        for v_registro in
            (   select * from segu.tpatron_evento
                where estado_reg='activo' and tipo_evento=par_tipo_log)loop
            
            if((select count(*)
                from segu.vlog
                where tipo_log=par_tipo_log and
                    fecha_reg>(now() - (v_registro.periodo_intentos||' minutes')::interval) AND
                    ((v_registro.aplicacion='ip' and ip_maquina=par_ip) or (v_registro.aplicacion='usuario' and id_usuario=par_id_usuario)))
                    >=v_registro.cantidad_intentos)then
                

                if(not exists ( select 1
                                from segu.tbloqueo_notificacion
                                where id_patron_evento=v_registro.id_patron_evento and
                                        estado_reg='activo' and
                                        fecha_hora_fin > now() and
                                   ((aplicacion='ip' and ip=par_ip) or
                                   (aplicacion='usuario' and id_usuario=par_id_usuario))))THEN
                                   
                       insert into segu.tbloqueo_notificacion
                       (id_patron_evento,           nombre_patron,              fecha_hora_ini,
                       fecha_hora_fin,              estado_reg,                 id_usuario,
                       usuario,                     ip,                         tipo,
                       aplicacion,                  tipo_evento)
                       values(
                       v_registro.id_patron_evento, v_registro.nombre_patron,   now(),
                       (now()+ (v_registro.tiempo_bloqueo||' minutes')::interval),'activo',par_id_usuario,
                       v_cuenta,                    par_ip,                     v_registro.operacion,
                       v_registro.aplicacion,       v_registro.tipo_evento
                       );
                       
                end if;
                    
            end if;
        end loop;

    END IF;

     return v_id_log;
     
     

end;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;