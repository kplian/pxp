--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_log_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_log_sel
 DESCRIPCIÓN:   listado de los eventos (log) del sistema
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:		
 FECHA:	
***************************************************************************/

DECLARE                  

v_consulta    varchar;
v_parametros  record;
v_resp          varchar;
v_nombre_funcion   text;
v_mensaje_error    text;
v_res_actualiz    varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(p_tabla);
     v_nombre_funcion:='segu.f_t_log_sel';

/*******************************    
 #TRANSACCION:  SEG_LOGMON_SEL
 #DESCRIPCION:	Listado del monitoreo de eventos del  XPH sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     if(p_transaccion='SEG_LOGMON_SEL')then

          --consulta:=';
          BEGIN
-- to_char(logg.fecha_reg,''dd/mm/yyyy hh24:mi:ss''),


               v_consulta:='select logg.id_log as identificador,
                            logg.id_usuario,
                            logg.cuenta_usuario,
                            logg.mac_maquina,
                            logg.ip_maquina,
                            logg.tipo_log,
                            logg.descripcion,
                            logg.fecha_reg,
                            logg.procedimientos,
                            logg.transaccion,
                            logg.consulta,
                            logg.usuario_base,
                            logg.tiempo_ejecucion,
                            logg.pid_web as pidweb,
                            logg.pid_db as piddb,
                            logg.sid_web as sidweb,
                            logg.codigo_error,
                            logg.descripcion_transaccion,
                            logg.codigo_subsistema,
                            logg.usuario_ai
                            
                        from segu.vlog logg
                        where  ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************    
 #TRANSACCION:  SEG_LOGMON_CONT
 #DESCRIPCION:	Contar registros del monitor de enventos del sistema(Actualiza eventos de BD)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_LOGMON_CONT')then

          --consulta:=';
          BEGIN
                /*Actualiza eventos de BD*/
                v_res_actualiz=segu.f_actualizar_log_bd (v_parametros.archivo_log);
                
               v_consulta:='select count(logg.id_log)
                              from segu.vlog logg
                           where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
     elsif(p_transaccion='SEG_LOG_SEL')then

          --consulta:=';
          BEGIN
-- to_char(logg.fecha_reg,''dd/mm/yyyy hh24:mi:ss''),

            if(not exists (select 1
                FROM pg_namespace n
                INNER JOIN pg_class c ON c.relnamespace = n.oid
                where n.nspname like 'log'
                and c.relkind='r' and
                c.relname='tlog_'||v_parametros.gestion||'_'||v_parametros.periodo))then
                raise exception 'No se tienen registros para la gestion y periodo seleccionados';
            end if;

               v_consulta:='select logg.id_log as identificador,
                            logg.id_usuario,
                            logg.cuenta_usuario,
                            logg.mac_maquina,
                            logg.ip_maquina,
                            logg.tipo_log,
                            logg.descripcion,
                            logg.fecha_reg,
                            logg.procedimientos,
                            logg.transaccion,
                            logg.consulta,
                            logg.usuario_base,
                            logg.tiempo_ejecucion,
                            logg.pid_web as pidweb,
                            logg.pid_db as piddb,
                            logg.sid_web as sidweb,
                            logg.codigo_error,
                            logg.descripcion_transaccion,
                            logg.codigo_subsistema,
                            logg.usuario_ai

                        from log.tlog_'||v_parametros.gestion||'_'||v_parametros.periodo||' logg
                        where  si_log=1 and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_LOG_CONT
 #DESCRIPCION:	Contar  los eventos del sistema registrados
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_LOG_CONT')then

          --consulta:=';
          BEGIN

                if(not exists (select 1
                    FROM pg_namespace n
                    INNER JOIN pg_class c ON c.relnamespace = n.oid
                    where n.nspname like 'log'
                    and c.relkind='r' and
                    c.relname='tlog_'||v_parametros.gestion||'_'||v_parametros.periodo))then
                    raise exception 'No se tienen registros para la gestion y periodo seleccionados';
                end if;
               v_consulta:='select count(logg.id_log)
                              from log.tlog_'||v_parametros.gestion||'_'||v_parametros.periodo||' logg
                           where  si_log=1 and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;

 /*******************************
 #TRANSACCION:  SEG_LOGHOR_SEL
 #DESCRIPCION:	Lista eventos del sistema sucedidos fuera de horarios de trabajo
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
    elsif(p_transaccion='SEG_LOGHOR_SEL')then

          --consulta:=';
          BEGIN
-- to_char(logg.fecha_reg,''dd/mm/yyyy hh24:mi:ss''),

            if(not exists (select 1
                FROM pg_namespace n
                INNER JOIN pg_class c ON c.relnamespace = n.oid
                where n.nspname like 'log'
                and c.relkind='r' and
                c.relname='tlog_'||v_parametros.gestion||'_'||v_parametros.periodo))then
                raise exception 'No se tienen registros para la gestion y periodo seleccionados';
            end if;

               v_consulta:='select logg.id_log,
                            logg.id_usuario,
                            logg.cuenta_usuario,
                            logg.mac_maquina,
                            logg.ip_maquina,
                            logg.tipo_log,
                            logg.descripcion,
                            logg.fecha_reg,
                            logg.procedimientos,
                            logg.transaccion,
                            logg.consulta,
                            logg.usuario_base,
                            logg.tiempo_ejecucion,
                            logg.pid_web,
                            logg.pid_db,
                            logg.sid_web,
                            logg.codigo_error,
                            logg.descripcion_transaccion,
                            logg.codigo_subsistema,
                            logg.usuario_ai,
                            (case when logg.dia_semana=1 then
                                ''domingo''
                            when logg.dia_semana=2 then
                                ''lunes''
                            when logg.dia_semana=3 then
                                ''martes''
                            when logg.dia_semana=4 then
                                ''miercoles''
                            when logg.dia_semana=5 then
                                ''jueves''
                            when logg.dia_semana=6 then
                                ''viernes''
                            else
                                ''sabado''
                            end)::varchar as dia_semana

                        from log.tlog_'||v_parametros.gestion||'_'||v_parametros.periodo||' logg
                        inner join segu.thorario_trabajo hor
                        on(hor.dia_semana=logg.dia_semana and logg.fecha_reg::time between hor.hora_ini and hor.hora_fin)
                        where ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_LOGHOR_CONT
 #DESCRIPCION:	Contar  los eventos fuera de horario de trabajo
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_LOGHOR_CONT')then

          --consulta:=';
          BEGIN

                if(not exists (select 1
                    FROM pg_namespace n
                    INNER JOIN pg_class c ON c.relnamespace = n.oid
                    where n.nspname like 'log'
                    and c.relkind='r' and
                    c.relname='tlog_'||v_parametros.gestion||'_'||v_parametros.periodo))then
                    raise exception 'No se tienen registros para la gestion y periodo seleccionados';
                end if;
               v_consulta:='select count(logg.id_log)
                              from log.tlog_'||v_parametros.gestion||'_'||v_parametros.periodo||' logg
                        inner join segu.thorario_trabajo hor
                        on(hor.dia_semana=logg.dia_semana and logg.fecha_reg::time between hor.hora_ini and hor.hora_fin)
                        where ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;

    /*******************************
     #TRANSACCION:  SEG_WTRANS_SEL
     #DESCRIPCION:  Cantidad de ejecucion de una TRANSACCION por gestion, exitos y errores
     #AUTOR:        RCM
     #FECHA:        11/03/2016
    ***********************************/
     elsif(p_transaccion='SEG_WTRANS_SEL')then

          BEGIN

              v_consulta = 'select distinct to_char(lo.fecha_reg,''yyyy-MM'') as periodo,
                            (select count(1)
                            from segu.tlog lo1
                            where lo1.transaccion = ''' || v_parametros.transaccion || '''
                            and lo1.tipo_log = ''LOG_TRANSACCION''
                            and to_char(lo1.fecha_reg,''yyyy-MM'')= to_char(lo.fecha_reg,''yyyy-MM'')
                            and to_char(lo1.fecha_reg,''yyyy'')::integer = '||v_parametros.gestion||') as exito,
                            (select count(1)
                            from segu.tlog lo1
                            where lo1.transaccion = ''SEG_VALUSU_SEG''
                            and lo1.tipo_log = ''ERROR_ACCESO''
                            and to_char(lo1.fecha_reg,''yyyy-MM'')= to_char(lo.fecha_reg,''yyyy-MM'')
                            and to_char(lo1.fecha_reg,''yyyy'')::integer = '||v_parametros.gestion||') as error
                            from segu.tlog lo
                            where lo.transaccion = ''SEG_VALUSU_SEG''
                            and to_char(lo.fecha_reg,''yyyy'')::integer = ' ||v_parametros.gestion||'
                            order by 1';
               return v_consulta;
         END;         

     else
         raise exception 'No existe la opcion';

     end if;

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