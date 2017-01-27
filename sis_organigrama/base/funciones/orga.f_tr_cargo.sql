CREATE OR REPLACE FUNCTION orga.f_tr_cargo (
)
  RETURNS trigger AS
  $body$
  DECLARE
    v_id_gestion		integer;
    v_id_centro_costo	integer;
    v_fecha_ini			date;
    v_gestion			numeric;


  BEGIN
    IF (TG_OP='INSERT')then
      BEGIN
        if (pxp.f_get_variable_global('') = 'si') then
          if (NEW.fecha_ini is null) then
            v_fecha_ini = now()::date;
          else
            v_fecha_ini = NEW.fecha_ini;
          end if;


          select g.id_gestion ,g.gestion,g.fecha_ini into v_id_gestion,v_gestion,v_fecha_ini
          from param.tgestion g
          where g.fecha_ini <= v_fecha_ini and g.fecha_fin >= v_fecha_ini;

          select pre.id_presupuesto into v_id_centro_costo
          from pre.vpresupuesto_cc pre
          where pre.id_uo = orga.f_get_uo_presupuesta(NEW.id_uo,NULL,v_fecha_ini) and
                pre.movimiento_tipo_pres = 'gasto' and pre.id_gestion = v_id_gestion
          order by pre.id_presupuesto ASC limit 1;

          if (v_id_centro_costo is null) then
            raise exception 'No se encontro un presupuesto para el cargo en la gestion %',v_gestion;
          end if;


          INSERT INTO
            orga.tcargo_presupuesto
            (
              id_usuario_reg,
              id_centro_costo,
              id_cargo,
              porcentaje,
              fecha_ini,
              id_gestion
            )
          VALUES (
            NEW.id_usuario_reg,
            v_id_centro_costo,
            NEW.id_cargo,
            100,
            v_fecha_ini,
            v_id_gestion
          );
        end if;

      END;
    END IF;
  END;
  $body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;