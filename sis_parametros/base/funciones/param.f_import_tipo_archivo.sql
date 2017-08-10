CREATE OR REPLACE FUNCTION param.f_import_tipo_archivo(
  p_tipo_archivo       TEXT,
  p_tipo_archivo_campo TEXT,
  p_tipo_archivo_join  TEXT


)
  RETURNS VARCHAR AS
$body$
DECLARE
  v_record_json_tipo_archivo_campo RECORD;
  v_record_json_tipo_archivo_join  RECORD;
  v_record_json_tipo_archivo_aux   RECORD;
  v_tipo_archivo                   TEXT;

  v_tipo                           VARCHAR;
  v_condicion                      VARCHAR;
  v_tabla_                         VARCHAR;


  v_id_tipo_archivo                INTEGER;
  v_tamano varchar;
BEGIN


  v_tipo_archivo = p_tipo_archivo;


  v_tamano = v_tipo_archivo :: JSON ->> 'tamano';
  INSERT INTO param.ttipo_archivo (
    nombre_id,
    multiple,
    codigo,
    tipo_archivo,
    tabla,
    nombre,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    fecha_reg,
    id_usuario_reg,
    fecha_mod,
    id_usuario_mod,
    extensiones_permitidas,
    ruta_guardar,
    tamano
  ) VALUES (

  v_tipo_archivo :: JSON ->> 'nombre_id',
  v_tipo_archivo :: JSON ->> 'multiple',
  v_tipo_archivo :: JSON ->> 'codigo',
  v_tipo_archivo :: JSON ->> 'tipo_archivo',
  v_tipo_archivo :: JSON ->> 'tabla',
  v_tipo_archivo :: JSON ->> 'nombre',
    'activo',
    null,
    'NULL',
    now(),
    1,
    NULL,
    NULL,
  v_tipo_archivo :: JSON ->> 'extensiones_permitidas',
  v_tipo_archivo :: JSON ->> 'ruta_guardar',
  v_tamano::numeric


  )
  RETURNING id_tipo_archivo
    INTO v_id_tipo_archivo;

  --campos
  FOR v_record_json_tipo_archivo_campo IN (SELECT json_array_elements(p_tipo_archivo_campo :: JSON)
  ) LOOP

    insert into param.ttipo_archivo_campo(
      nombre,
      alias,
      tipo_dato,
      renombrar,
      estado_reg,
      id_tipo_archivo,
      id_usuario_ai,
      fecha_reg,
      usuario_ai,
      id_usuario_reg,
      fecha_mod,
      id_usuario_mod
    ) values(
      v_record_json_tipo_archivo_campo.json_array_elements::json->>'nombre',
      v_record_json_tipo_archivo_campo.json_array_elements::json->>'alias',
      v_record_json_tipo_archivo_campo.json_array_elements::json->>'tipo_dato',
      v_record_json_tipo_archivo_campo.json_array_elements::json->>'renombrar',
      'activo',
      v_id_tipo_archivo,
      null,
      now(),
      'NULL',
      1,
      null,
      null



    );


  END LOOP;

  --join
  FOR v_record_json_tipo_archivo_join IN (SELECT json_array_elements(p_tipo_archivo_join :: JSON)
  ) LOOP


    insert into param.ttipo_archivo_join(
      tipo,
      condicion,
      tabla,
      id_tipo_archivo,
      estado_reg,
      id_usuario_ai,
      id_usuario_reg,
      fecha_reg,
      usuario_ai,
      fecha_mod,
      id_usuario_mod,
      alias
    ) values(
      v_record_json_tipo_archivo_join.json_array_elements::json->>'tipo',
      v_record_json_tipo_archivo_join.json_array_elements::json->>'condicion',
      v_record_json_tipo_archivo_join.json_array_elements::json->>'tabla',
      v_id_tipo_archivo,
      'activo',
      null,
      1,
      now(),
      'NULL',
      null,
      null,
      v_record_json_tipo_archivo_join.json_array_elements::json->>'alias'



    );


  END LOOP;


  RETURN 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;