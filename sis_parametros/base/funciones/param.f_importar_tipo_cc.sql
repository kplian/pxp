CREATE OR REPLACE FUNCTION param.f_importar_tipo_cc (
)
RETURNS boolean AS
$body$
DECLARE

  v_r record;
  v_tabla varchar;
  v_resp varchar;
  v_params VARCHAR[];
  v_id_ep integer;
  v_id_tipo_cc1 integer;
  v_id_tipo_cc2 integer;
  v_id_tipo_cc3 integer;
  v_id_tipo_cc_padre integer;

BEGIN
  FOR v_r in (
  select codigo, descripcion
  from pre.tformulacion_tmp
  where tipo1 = 'Proyecto expansión')
  LOOP
    raise notice 'TipoCC: %', v_r;
    --el id raíz será el mismo para todos
    v_id_tipo_cc_padre = 1549;
    --obtenemos la EP para el proyecto dado
    select ep.id_ep
    into v_id_ep
    from param.tprograma_proyecto_acttividad ppa
    join param.tep ep on ep.id_prog_pory_acti=ppa.id_prog_pory_acti
    join param.tproyecto p ON p.id_proyecto=ppa.id_proyecto
    where TRIM(upper(p.codigo_proyecto))=TRIM(upper(v_r.codigo));
    if v_id_ep is null then
      raise exception 'No existe EP para el proyecto: %', v_r.codigo;
    end if;

    --insertamos tipo cc PROYECTO
    v_params = ARRAY[TRIM(upper(v_r.codigo))::varchar,--codigo
      'si'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'no'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc_padre::varchar,--id_tipo_cc_fk
      v_r.descripcion::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc1 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc1, v_r.codigo;
    
    --insertamos tipo cc LÍNEAS TRANSMISIÓN
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'L'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'no'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc1::varchar,--id_tipo_cc_fk
      'LÍNEAS DE TRANSMISIÓN'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc2 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc2, v_r.codigo || 'L';
    
    --insertamos tipo cc SUMINISTRO LÍNEAS
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'L11'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'SUMINISTRO LÍNEAS'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'L11';
    
    --insertamos tipo cc MONTAJE Y OBRAS CIVILES
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'L25'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'MONTAJE Y OBRAS CIVILES'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'L25';
    
    
    
    
    
    
    --insertamos tipo cc SUBESTACIONES
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'S'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'no'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc1::varchar,--id_tipo_cc_fk
      'SUBESTACIONES'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc2 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc2, v_r.codigo || 'S';
    
    --insertamos tipo cc LLAVE EN MANO SUBESTACIONES
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'S10'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'LLAVE EN MANO SUBESTACIONES'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'S10';
    
    --insertamos tipo cc SUMINISTRO SUBESTACIONES
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'S11'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'SUMINISTRO SUBESTACIONES'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'S11';
    
    --insertamos tipo cc OBRAS CIVILES Y MONTAJE ELECTROMECANICO
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'S21'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'OBRAS CIVILES Y MONTAJE ELECTROMECANICO'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'S21';
    
    
    
    
    
    --insertamos tipo cc ESTUDIOS, ADMINISTRACION, INGENIERIA Y SUPERVISION
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'no'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc1::varchar,--id_tipo_cc_fk
      'ESTUDIOS, ADMINISTRACION, INGENIERIA Y SUPERVISION'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc2 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc2, v_r.codigo || 'A';
    
    --insertamos tipo cc ESTUDIOS
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A10'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'ESTUDIOS'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'A10';
    
    --insertamos tipo cc ADMINISTRACION Y LOGISTICA
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A20'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'ADMINISTRACION Y LOGISTICA'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'A20';
    
    --insertamos tipo cc INGENIERIA
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A30'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'INGENIERIA'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'A30';
    
    --insertamos tipo cc SUPERVISIÓN
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A40'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'SUPERVISIÓN'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'A40';
    
    --insertamos tipo cc OTROS ACTIVOS
    v_params = ARRAY[TRIM(upper(v_r.codigo)) || 'A50'::varchar,--codigo
      'no'::varchar,--control_techo
      'egreso'::varchar,--mov_pres
      'activo'::varchar,--estado_reg
      'si'::varchar,--movimiento
      v_id_ep::varchar,--id_ep
      v_id_tipo_cc2::varchar,--id_tipo_cc_fk
      'OTROS ACTIVOS'::varchar,--descripcion
      'edt'::varchar,--tipo
      'no'::varchar,--control_partida
      'comprometido,ejecutado,pagado,formulado'::varchar,--momento_pres
      '01/01/2017'::varchar,
      '31/01/2032'::varchar,
      '',
      ''
      ];
    v_tabla = pxp.f_crear_parametro(ARRAY['codigo', 'control_techo', 'mov_pres', 'estado_reg', 'movimiento', 'id_ep', 'id_tipo_cc_fk', 'descripcion', 'tipo', 'control_partida', 'momento_pres', 'fecha_inicio', 'fecha_final', '_nombre_usuario_ai', '_id_usuario_ai'],
      v_params,
      ARRAY['varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'int4', 'varchar', 'varchar', 'varchar', 'varchar', 'varchar', 'date', 'date', 'varchar', 'integer']
    );
    --Insertamos el registro
    v_resp = param.ft_tipo_cc_ime(1, 1, v_tabla, 'PM_TCC_INS');
    --Obtencion del ID generado
    v_id_tipo_cc3 = pxp.f_obtiene_clave_valor(v_resp,'id_tipo_cc','','', 'valor')::integer;
    raise notice 'OK: % - %', v_id_tipo_cc3, v_r.codigo || 'A50';

  END LOOP;

--  raise exception 'solo para probar errores';
  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;