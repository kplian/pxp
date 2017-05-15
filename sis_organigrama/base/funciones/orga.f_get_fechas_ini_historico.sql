CREATE OR REPLACE FUNCTION orga.f_get_fechas_ini_historico (
  p_id_funcionario integer,
  p_fecha date = now()::date
)
  RETURNS text AS
  $body$
  DECLARE
    g_registros record;
    g_fechas text;
    g_ultima_fecha_ini date;
  BEGIN
    g_fechas = '';
    for g_registros in execute ('
    select fecha_asignacion, ha.fecha_finalizacion,nro_documento_asignacion,count(*) over() as cantidad
            from orga.tuo_funcionario ha
            inner join orga.tcargo car on car.id_cargo = ha.id_cargo
            inner join orga.ttipo_contrato tcon on tcon.id_tipo_contrato=car.id_tipo_contrato
            where ha.estado_reg = ''activo'' and ha.id_funcionario = '||p_id_funcionario||' and tcon.id_tipo_contrato in (1,4) and ha.tipo = ''oficial'' and
            ha.fecha_asignacion <= ''' || p_fecha|| '''::date
            order by fecha_asignacion desc')loop
      if (g_fechas = '')then
        g_ultima_fecha_ini = g_registros.fecha_asignacion;
        if ((g_registros.nro_documento_asignacion is null or g_registros.nro_documento_asignacion != 'reestructuracion') or
            g_registros.cantidad = 1) then
          g_fechas = to_char(g_registros.fecha_asignacion,'DD/MM/YYYY');

        end if;
      else
        if ((g_ultima_fecha_ini - interval '1 day') = g_registros.fecha_finalizacion) then
          g_ultima_fecha_ini = g_registros.fecha_asignacion;
          if (g_registros.nro_documento_asignacion is null or g_registros.nro_documento_asignacion != 'reestructuracion') then
            g_fechas = to_char(g_registros.fecha_asignacion,'DD/MM/YYYY') || ' ' || g_fechas;

          end if;
        else
          EXIT;
        end if;
      end if;

    end loop;

    return g_fechas;
  END;
  $body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;