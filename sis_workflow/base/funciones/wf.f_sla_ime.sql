--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_sla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:
 FUNCION:
 DESCRIPCION: Envia correos segun configuracion Estado
 AUTOR:
 FECHA:
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 	ISSUE			FECHA			AUTHOR 					DESCRIPCION
    #143            29/05/2020      EGS                     Creacion
***************************************************************************/

DECLARE

	v_parametros           	record;
	v_resp		            varchar;
    v_nombre_funcion        text;

    v_acceso_directo        varchar;
    v_clase                 varchar;
    v_parametros_ad         varchar;
    v_tipo_noti             varchar;
    v_titulo                varchar;
    v_id_alarma             integer;
    v_descripcion_correo    varchar;
    v_record                record;
    v_fecha_now             date;
    v_consulta_dia          varchar;
    v_dia_semana            integer;
    v_dia_feriado           integer;
    v_dias_transcurridos    integer;
    v_dias_restantes        integer;
    v_array                 INTEGER[];
    v_tamano			    integer;
    v_i					    integer;
    v_envio                 BOOLEAN;
    v_hora                  integer;
    v_minuto                integer;
    v_hora_actual           integer;
    v_minuto_actual         integer;
    v_tiempo_restante       time;
    v_consulta_hora         varchar;
    v_incremento_fecha      date;
    v_valor_incremento      varchar;
    v_domingo               INTEGER = 0;
    v_sabado                INTEGER = 6;
    v_cant_dias             numeric=0;
    v_dias_habiles          integer;
    v_fecha_aux             date;
    v_fecha_fin             date;
    v_pais_base             VARCHAR;
    v_id_lugar              integer;
    p_id_lugar              integer;
    v_dia                   integer;
    p_id_usuario            integer = 1;
    v_hrs_restantes          time;
    v_array_hrs             varchar[];
    v_existe                integer;

BEGIN

    v_nombre_funcion = 'wf.f_sla_ime';
    v_parametros = pxp.f_get_record(p_tabla);


  /*********************************
  #TRANSACCION:  'WF_INISLA_IME'
  #DESCRIPCION:
  #AUTOR:		EGS
  #FECHA:
  #ISSUE:
  ***********************************/

  if(p_transaccion='WF_INISLA_IME')then

  begin
  --RAISE EXCEPTION 'v_parametros existe  %',v_parametros.habilitado;
  IF v_parametros.habilitado = 'si' THEN

      v_pais_base = split_part(pxp.f_get_variable_global('pxp_pais_base'), ',', 1);
      SELECT
          lu.id_lugar
      INTO
          v_id_lugar
      FROM param.tlugar lu
      WHERE  replace(upper(lu.nombre),'',' ') = replace(upper(v_pais_base),'',' ') ;
    --Si las fechas son fines de semana o feriados no se envia el correo o la alarma
    -- domingo = 0 y sabado = 6
    -- verificamos hoy es fin de semana para enviar los correos
      v_fecha_now = now()::date;
      v_consulta_dia = 'SELECT EXTRACT(DOW FROM TIMESTAMP '''||v_fecha_now||''')';
      EXECUTE v_consulta_dia into v_dia_semana;

    -- Verificamos si hoy es feriado
      SELECT
        count(f.id_feriado)
      INTO
        v_dia_feriado
      FROM param.tferiado f
      WHERE f.fecha::date = v_fecha_now;

     --RAISE EXCEPTION 'v_dia_feriado %',v_dia_feriado;
     --RAISE EXCEPTION 'v_dia_semana %',v_dia_semana;

      IF (v_dia_semana <> 6 and v_dia_semana <> 0) THEN --comprobacion de no ser un fin de semana
        IF  v_dia_feriado = 0 THEN  -- comprobacion si no es feriado
            FOR  v_record IN(
                SELECT e.fecha_reg,
                         e.id_estado_wf,
                         e.id_proceso_wf,
                         e.id_funcionario,
                         e.estado_reg,
                         pw.nro_tramite,
                         ted.acceso_directo_alerta,
                         ted.nombre_clase_alerta,
                         ted.dias_limite,
                         ted.dias_envio,
                         ted.hrs_envio,
                         ted.parametros_ad,
                         fu.email_empresa,
                         ted.codigo as estado
                  FROM wf.testado_wf e
                       LEFT JOIN wf.tproceso_wf pw ON pw.id_proceso_wf = e.id_proceso_wf
                       LEFT JOIN wf.ttipo_estado ted ON ted.id_tipo_estado = e.id_tipo_estado
                       LEFT JOIN orga.tfuncionario fu ON fu.id_funcionario = e.id_funcionario
                  WHERE ted.sla::text = 'si'::text AND
                        e.estado_reg::text = 'activo'::text
                  ORDER BY e.id_proceso_wf,
                           e.estado_reg

            )LOOP
                v_existe = 0;
                v_envio = false;
                v_cant_dias=0;
                v_fecha_aux=v_record.fecha_reg::date;
                v_fecha_fin=now()::date;
                p_id_lugar = v_id_lugar;
                v_valor_incremento := '1' || ' DAY';

                 WHILE (SELECT v_fecha_aux::date <= v_fecha_fin::date ) loop
                  IF(select extract(dow from v_fecha_aux::date)not in (v_sabado, v_domingo)) THEN
                      IF NOT EXISTS(select * from param.tferiado f
                                            JOIN param.tlugar l on l.id_lugar = f.id_lugar
                                            WHERE l.id_lugar = COALESCE(p_id_lugar,0) AND (EXTRACT(MONTH from f.fecha))::integer = (EXTRACT(MONTH from v_fecha_aux::date))::integer
                                            AND (EXTRACT(DAY from f.fecha))::integer = (EXTRACT(DAY from v_fecha_aux)) AND (EXTRACT(YEAR from f.fecha))::integer = (EXTRACT(YEAR from v_fecha_aux)) )THEN
                                            v_cant_dias=v_cant_dias+1;

                      END IF;


                  END IF;

                  v_incremento_fecha=(SELECT v_fecha_aux::date + CAST(v_valor_incremento AS INTERVAL));
                  v_fecha_aux = v_incremento_fecha;
                end loop;


                v_dias_habiles = v_cant_dias;
                v_dias_transcurridos=v_dias_habiles;

                v_dias_restantes = v_record.dias_limite::integer - v_dias_transcurridos;
                raise notice 'dia h % %',v_record.dias_limite,v_dias_transcurridos ;
                v_array = string_to_array(v_record.dias_envio,',');
                v_tamano:=array_upper(v_array,1);

                --cuando se envia los dias configurados
                For i in 1..(v_tamano) loop

                    v_dia = v_array[i]::integer;
                    RAISE NOTICE '% %',v_dia,v_dias_restantes;
                    IF (v_dia = v_dias_restantes) THEN
                        --verificamos si en el dia ya se envio una alerta/correo
                        SELECT count(a.id_alarma)
                        INTO
                        v_existe
                        FROM param.talarma a
                        WHERE a.fecha_reg::date = now()::date and
                        a.id_proceso_wf = v_record.id_proceso_wf and
                        a.id_estado_wf = v_record.id_estado_wf;
                         RAISE NOTICE 'v_existe %',v_existe;

                        IF v_existe <> 0 THEN

                            RAISE notice 'existe correo';
                            v_envio = false;
                        ELSE
                            RAISE notice 'no existe correo';
                            v_envio = true;
                        END IF;



                    END IF;

    	        v_descripcion_correo = '<font color="FF0000" size="5"><font size="4">RECORDATORIO</font> </font><br><br><b></b>El motivo de la presente es recordarle que el número de trámite : <b>'||v_record.nro_tramite||'</b>. En el Estado <b>'||v_record.estado||'</b>.<br> Tiene un tiempo Limite de '||v_dias_restantes||' dias.<br>Saludos<br>';

                End loop;

                 --cuando ya falta hrs para cumplir el tiempo limite
                IF v_dias_restantes = 0 THEN


                    v_tiempo_restante = v_record.fecha_reg::TIME - now()::TIME;

                    v_consulta_hora = 'SELECT to_char(interval '''||v_tiempo_restante||''', ''HH24:MI'')';

                    EXECUTE v_consulta_hora into v_hrs_restantes;

                    v_array_hrs = string_to_array(v_record.hrs_envio,',');
                    v_tamano:=array_upper(v_array_hrs,1);

                    For i in 1..(v_tamano) loop

                        IF v_hrs_restantes = v_array_hrs[i]::time THEN

                           v_envio = true;

                        END IF;

                    End loop;
                    v_descripcion_correo = '<font color="FF0000" size="5"><font size="4">RECORDATORIO</font> </font><br><br><b></b>El motivo de la presente es recordarle que el número de trámite : <b>'||v_record.nro_tramite||'</b>. En el Estado <b>'||v_record.estado||'</b>.<br> Tiene un tiempo Limite de '||v_hrs_restantes||' Hrs .<br>Saludos<br>';

                END IF;
                --cuando ya paso el tiempo limite

                 IF v_dias_restantes < 0 THEN

                    SELECT count(a.id_alarma)
                    INTO
                    v_existe
                    FROM param.talarma a
                    WHERE a.fecha_reg::date = now()::date and
                    a.id_proceso_wf = v_record.id_proceso_wf and
                    a.id_estado_wf = v_record.id_estado_wf;

                    IF v_existe <> 0 THEN

                        RAISE notice 'existe correo';
                        v_envio = false;
                    ELSE
                        RAISE notice 'no existe correo';
                        v_envio = true;
                    END IF;

                    v_descripcion_correo = '<font color="FF0000" size="5"><font size="4">RECORDATORIO</font> </font><br><br><b></b>El motivo de la presente es recordarle que el número de trámite : <b>'||v_record.nro_tramite||'</b>. En el Estado <b>'||v_record.estado||'</b>.<br> Ya sobrepaso el tiempo Limite con '||abs(v_dias_restantes)||' dias .<br>Saludos<br>';

                END IF;

                IF v_envio = true THEN
                  v_acceso_directo = v_record.acceso_directo_alerta;
                  v_clase = v_record.nombre_clase_alerta;
                  v_parametros_ad = '{filtro_directo:{campo:"'||COALESCE(v_record.parametros_ad,'')||'",valor:"'||v_record.id_proceso_wf::varchar||'"}}';
                  v_tipo_noti = 'notificacion';
                  v_titulo = 'Servicio de Recordatorio: '||v_record.nro_tramite;

                  v_id_alarma = param.f_inserta_alarma(
                                                v_record.id_funcionario,
                                                v_descripcion_correo,--par_descripcion
                                                v_acceso_directo,--acceso directo
                                                now()::date,--par_fecha: Indica la fecha de vencimiento de la alarma
                                                v_tipo_noti, --notificacion
                                                v_titulo,  --asunto
                                                p_id_usuario,
                                                v_clase, --clase
                                                v_titulo,--titulo
                                                v_parametros_ad,--par_parametros varchar,   parametros a mandar a la interface de acceso directo
                                                v_parametros.id_usuario, --usuario a quien va dirigida la alarma
                                                v_titulo,--titulo correo
                                                v_record.email_empresa, --correo funcionario
                                                null,--#9
                                                v_record.id_proceso_wf,
                                                v_record.id_estado_wf
                                               );
                END IF;



            END LOOP;


        END IF; -- fin de comprobacio si no es feriado
      END IF; --Fin de if de comprobacion de no ser fin de semana



  ELSE
      v_resp = 'no esta habilitado la opcion de desactivado automatico';
  END IF;
     v_resp='exito';
    --Definicion de la respuesta
     v_resp = pxp.f_agrega_clave(v_resp,'mensaje',v_resp);

    --Devuelve la respuesta
    return v_resp;


  end;


  else

    raise exception 'Transaccion inexistente: %',p_transaccion;

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