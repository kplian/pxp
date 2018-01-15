CREATE OR REPLACE FUNCTION param.f_importar_proveedor_tmp (
)
RETURNS boolean AS
$body$
DECLARE

  v_r record;
  v_tabla varchar;
  v_resp varchar;
  v_id_proveedor integer;
  v_sigla varchar;
  v_cont integer;

BEGIN
  v_cont = 1;
  FOR v_r in (
  select ct.id,
         coalesce(trim(ct.nit),'') as nit,
         coalesce(trim(ct.nom_comercio),'') as nom_comercio,
         coalesce(trim(ct.lugar),'') as lugar,
         coalesce(trim(ct.direccion),'') as direccion,
         coalesce(trim(ct.sigla),'') as sigla,
         coalesce(trim(ct.nombre),'') as nombre,
         coalesce(trim(ct.unipersonal),'') as unipersonal,
         coalesce(trim(ct.categ1),'') as categ1,
         coalesce(trim(ct.categ2),'') as categ2,
         coalesce(trim(ct.categ3),'') as categ3,
         coalesce(trim(ct.telf1),'') as telf1,
         coalesce(trim(ct.telf2),'') as telf2,
         coalesce(trim(ct.telf3),'') as telf3,
         coalesce(trim(ct.telf4),'') as telf4,
         coalesce(trim(ct.correo),'') as correo,
         coalesce(trim(ct.web),'') as web,
         coalesce(trim(ct.contacto),'') as contacto
  from param.tproveedor_tmp ct
  where ct.migrado = 'no' order by id)
  LOOP
    raise notice 'PROVEEDOR: %', v_r;

    v_r.telf1 = replace(v_r.telf1, '.', '');
    v_r.telf1 = replace(v_r.telf1, '-', '');
    v_r.telf1 = replace(v_r.telf1, ' ', '');
    v_r.telf1 = replace(v_r.telf1, '(', '');
    v_r.telf1 = replace(v_r.telf1, ')', '');
    v_r.telf1 = replace(v_r.telf1, '+', '');
    v_r.telf1 = replace(v_r.telf1, '/', '');

    v_r.telf2 = replace(v_r.telf2, '.', '');
    v_r.telf2 = replace(v_r.telf2, '-', '');
    v_r.telf2 = replace(v_r.telf2, ' ', '');
    v_r.telf2 = replace(v_r.telf2, '(', '');
    v_r.telf2 = replace(v_r.telf2, ')', '');
    v_r.telf2 = replace(v_r.telf2, '+', '');
    v_r.telf2 = replace(v_r.telf2, '/', '');

    v_r.telf3 = replace(v_r.telf3, '.', '');
    v_r.telf3 = replace(v_r.telf3, '-', '');
    v_r.telf3 = replace(v_r.telf3, ' ', '');
    v_r.telf3 = replace(v_r.telf3, '(', '');
    v_r.telf3 = replace(v_r.telf3, ')', '');
    v_r.telf3 = replace(v_r.telf3, '+', '');
    v_r.telf3 = replace(v_r.telf3, '/', '');

    v_r.telf4 = replace(v_r.telf4, '.', '');
    v_r.telf4 = replace(v_r.telf4, '-', '');
    v_r.telf4 = replace(v_r.telf4, ' ', '');
    v_r.telf4 = replace(v_r.telf4, '(', '');
    v_r.telf4 = replace(v_r.telf4, ')', '');
    v_r.telf4 = replace(v_r.telf4, '+', '');
    v_r.telf4 = replace(v_r.telf4, '/', '');

    if v_r.sigla='' or v_r.sigla is null then
      v_sigla = 'CSA' || v_cont::varchar;
      v_cont = v_cont + 1;
    else
      v_sigla = v_r.sigla;
      IF exists(
        select 1
        from param.tproveedor_tmp p
        where p.sigla = v_sigla and
              p.id <> v_r.id)   THEN
        v_sigla = v_sigla || '__' || v_cont;
        v_cont = v_cont + 1;
      END IF;
    end if;
    if v_r.id=9482 then--para debug
      v_sigla = v_sigla;
    end if;
    if trim(v_r.unipersonal)='' or v_r.unipersonal is null then--institución
      v_tabla = pxp.f_crear_parametro(ARRAY['apellido_materno',
        'apellido_paterno',
        'casilla',
        'celular1',
        'celular1_institucion',
        'celular2',
        'celular2_institucion',
        'ci',
        'codigo',
        'codigo_banco',
        'codigo_institucion',
        'contacto',
        'correo',
        'direccion',
        'direccion_institucion',
        'doc_id',
        'email1_institucion',
        'email2_institucion',
        'fax',
        'fecha_nacimiento',
        'genero',
        'id_institucion',
        'id_lugar',
        'id_persona',
        'nit',
        'nombre',
        'nombre_institucion',
        'numero_sigma',
        'observaciones',
        'pag_web',
        'register',
        'rotulo_comercial',
        'telefono1',
        'telefono1_institucion',
        'telefono2',
        'telefono2_institucion',
        'tipo'
        ],
        ARRAY[''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        replace(substr(coalesce(v_r.telf1::varchar,''),0 , 19), '.', ''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf2::varchar,''),0 , 19), '.', ''),
        ''::varchar,
        ''::varchar,
        ''::varchar,
        coalesce(v_sigla::varchar,''),
        coalesce(v_r.contacto::varchar,''),
        ''::varchar,
        ''::varchar,
        substr(coalesce(v_r.direccion::varchar,''),0 , 200),
        ''::varchar,
        substr(coalesce(v_r.correo::varchar,''),0 , 100),
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        '1'::varchar,
        ''::varchar,
        coalesce(v_r.nit::varchar,''),
        ''::varchar,
        coalesce(v_r.nombre::varchar,''),
        '1'::varchar,
        ''::varchar,
        coalesce(v_r.web::varchar,''),
        'no_registered'::varchar,
        coalesce(v_r.nom_comercio::varchar,''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf3::varchar,''),0 , 19), '.', ''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf4::varchar,''),0 , 19), '.', ''),
        'institucion'::varchar
        ],
        ARRAY['varchar',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'int4',
        'varchar',
        'varchar',
        'varchar',
        'text',
        'varchar',
        'varchar',
        'varchar',
        'bigint',
        'varchar',
        'varchar',
        'bigint',
        'date',
        'varchar',
        'int4',
        'int4',
        'int4',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'varchar'
        ]
      );
      else
      --persona
      v_tabla = pxp.f_crear_parametro(ARRAY['apellido_materno',
        'apellido_paterno',
        'casilla',
        'celular1',
        'celular1_institucion',
        'celular2',
        'celular2_institucion',
        'ci',
        'codigo',
        'codigo_banco',
        'codigo_institucion',
        'contacto',
        'correo',
        'direccion',
        'direccion_institucion',
        'doc_id',
        'email1_institucion',
        'email2_institucion',
        'fax',
        'fecha_nacimiento',
        'genero',
        'id_institucion',
        'id_lugar',
        'id_persona',
        'nit',
        'nombre',
        'nombre_institucion',
        'numero_sigma',
        'observaciones',
        'pag_web',
        'register',
        'rotulo_comercial',
        'telefono1',
        'telefono1_institucion',
        'telefono2',
        'telefono2_institucion',
        'tipo'
        ],
        ARRAY[''::varchar,
        coalesce(v_r.nombre::varchar,''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf1::varchar,''),0 , 50), '.', ''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf2::varchar,''),0 , 50), '.', ''),
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        coalesce(v_r.contacto::varchar,''),
        substr(coalesce(v_r.correo::varchar,''),0 , 100),
        substr(coalesce(v_r.direccion::varchar,''),0 , 200),
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        ''::varchar,
        '1'::varchar,
        ''::varchar,
        coalesce(v_r.nit::varchar,''),
        ''::varchar,
        ''::varchar,
        '1'::varchar,
        ''::varchar,
        ''::varchar,
        'no_registered'::varchar,
        coalesce(v_r.nom_comercio::varchar,''),
        replace(substr(coalesce(v_r.telf3::varchar,''),0 , 50), '.', ''),
        ''::varchar,
        replace(substr(coalesce(v_r.telf4::varchar,''),0 , 50), '.', ''),
        ''::varchar,
        'persona'::varchar
        ],
        ARRAY['varchar',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'int4',
        'varchar',
        'varchar',
        'varchar',
        'text',
        'varchar',
        'varchar',
        'varchar',
        'bigint',
        'varchar',
        'varchar',
        'bigint',
        'date',
        'varchar',
        'int4',
        'int4',
        'int4',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'varchar',
        'bigint',
        'varchar',
        'bigint',
        'varchar'
        ]
      );
    end if;
    --Insercion del documento
    --v_resp = conta.ft_doc_compra_venta_ime(p_administrador,p_id_usuario,v_tabla,'PM_PROVEE_INS');
    v_resp = param.f_tproveedor_ime(1,1,v_tabla,'PM_PROVEE_INS');

    --Obtencion del ID generado
    v_id_proveedor = pxp.f_obtiene_clave_valor(v_resp,'id_proveedor','','',
      'valor')::integer;
    update param.tproveedor_tmp p
    set id_proveedor = v_id_proveedor,
        migrado = 'si'
    where p.id = v_r.id;
    raise notice 'OK: % - %', v_id_proveedor, v_r.nom_comercio;
  END LOOP;
  raise exception 'TERMINÓ - comentar en producción';
  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;