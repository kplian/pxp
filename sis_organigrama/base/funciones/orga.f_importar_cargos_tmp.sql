--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_cargos_tmp (
)
RETURNS boolean AS
$body$
DECLARE

  v_registros record;
  v_id_nivel_organizacional integer;
  v_id_uo integer;
  v_id_uo_existe integer;
  v_id_uo_padre integer;
  v_id_cargo integer;
  v_id_tipo_contrato integer;
  v_id_uo_cargo integer;
  v_id_lugar integer;
  v_id_oficina integer;
  v_id_escala_salarial integer;

BEGIN

  FOR v_registros in (
  select ct.cargo,
         ct.codigo_uo,
         ct.item,
         ct.migrado,
         ct.uo,
         ct.individual,
         ct.contrato,
         ct.oficina,
         ct.escala
  from orga.tcargo_tmp ct
  where ct.migrado = 'no')
  LOOP

    v_id_uo = NULL;
    v_id_uo_cargo = NULL;
    v_id_lugar = NULL;
    v_id_tipo_contrato = NULL;

    --recupera el lugar

    select of . id_oficina,
           of . id_lugar
    into v_id_oficina,
         v_id_lugar
    from orga.toficina of
    where upper(trim(of . nombre)) = upper(trim(v_registros.oficina));

    IF v_id_lugar is null THEN
      raise exception 'no se encontro lugar para %',v_registros.lugar;
    END IF;

    --recupera el tipo de contrato

    select tc.id_tipo_contrato
    into v_id_tipo_contrato
    from orga.ttipo_contrato tc
    where upper(tc.codigo) = upper(v_registros.contrato);

    IF v_id_tipo_contrato is null THEN
      raise exception 'no se encontro contrato para %',v_registros.contrato;
    END IF;

    --recuperar el ID DE la UO

    select c.id_uo
    into v_id_uo
    from orga.tuo c
    where c.codigo = v_registros.codigo_uo;

    IF v_registros.individual = 'si' THEN
      v_id_uo_cargo = v_id_uo;
    ELSE
      select uo.id_uo
      into v_id_uo_cargo
      from orga.tuo uo
      inner join orga.testructura_uo euo on euo.id_uo_hijo = uo.id_uo
      where euo.id_uo_padre = v_id_uo and
            upper(uo.nombre_cargo) = upper(v_registros.cargo);
            
      if v_id_uo_cargo is null then
        select id_nivel_organizacional
        into v_id_nivel_organizacional
        from orga.tnivel_organizacional no
        where no.nombre_nivel ilike 'FUNCIONARIO BASE';
        
        insert into orga.tuo(codigo, nombre_unidad, nombre_cargo, descripcion,
          cargo_individual, presupuesta, estado_reg, fecha_reg, id_usuario_reg,
          nodo_base, correspondencia, gerencia, id_nivel_organizacional)
        values (upper(v_registros.item), upper(v_registros.cargo), upper(
          v_registros.cargo), upper(v_registros.cargo), 'no', 'no',
               --v_parametros.presupuesta,
               'activo',             now()::date, 1, --par_id_usuario,
               'no',             --v_parametros.nodo_base,
               'no',             --v_parametros.correspondencia,
               'no',             --v_parametros.gerencia,
               v_id_nivel_organizacional) RETURNING id_uo
        into v_id_uo_cargo;
        INSERT INTO orga.testructura_uo(id_uo_hijo, id_uo_padre, estado_reg,
          id_usuario_reg, fecha_reg)
        values (v_id_uo_cargo, (v_id_uo)::integer, 'activo', 1, now()::date);
        --raise notice 'se creo una uo dependiente de % con el codigo % (%)', v_registros.codigo_uo,v_registros.item ,v_registros.cargo;
      end if;
    END IF;
    IF v_id_uo is not null and v_id_uo_cargo is not null THEN
      --verificamos si el cargo existe

      SELECT c.id_cargo
      INTO v_id_cargo
      FROM orga.tcargo c
      WHERE c.codigo = v_registros.item;
      
      --obtenemos la escala salarial
      select e.id_escala_salarial
      into v_id_escala_salarial
      from orga.tescala_salarial e
      where e.codigo = v_registros.escala;

      IF v_id_cargo IS NOT NULL THEN
        UPDATE orga.tcargo
        SET id_tipo_contrato = v_id_tipo_contrato,
            id_lugar = v_id_lugar,
            id_uo = v_id_uo_cargo,
            id_oficina = v_id_oficina,
            id_escala_salarial = v_id_escala_salarial
        WHERE id_cargo = v_id_cargo;
      ELSE
        insert into orga.tcargo(id_tipo_contrato, id_lugar, id_uo,
          id_escala_salarial, codigo, nombre, fecha_ini, estado_reg, fecha_fin,
          fecha_reg, id_usuario_reg, fecha_mod, id_usuario_mod, id_oficina)
        values (v_id_tipo_contrato, v_id_lugar, v_id_uo_cargo,
          v_id_escala_salarial, v_registros.item, v_registros.cargo,
          '01/01/2015', 'activo', NULL, --v_parametros.fecha_fin,
               now(), 1, --p_id_usuario,
               null, null, v_id_oficina --v_parametros.id_oficina
               ) RETURNING id_cargo
        into v_id_cargo;
      END IF;
      update orga.tcargo_tmp
      set migrado = 'si',
          id_cargo = v_id_cargo
      where item = v_registros.item;

    ELSE
        raise notice 'no existen v_id_uo y v_id_uo_cargo ';
    END IF;

  END LOOP;

  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;