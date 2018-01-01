--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_importar_proveedor_tmp_2 (
)
RETURNS boolean AS
$body$
DECLARE

  v_r record;
  v_parametros record;
  v_tabla varchar;
  v_resp varchar;
  v_id_proveedor integer;
  v_sigla varchar;
  v_cont integer;

  v_id_persona integer;
  v_id_institucion integer;
  v_num_seq integer;
  v_codigo_gen varchar;
  v_desc_proveedor			varchar;
  v_id_auxiliar 				integer;
  v_id_config_subtipo_cuenta	integer;
  v_reg_cuenta				record;

BEGIN
  v_cont = 1;
  FOR v_r in (
  select ct.id,
         ct.nit,
         ct.nom_comercio,
         ct.lugar,
         ct.direccion,
         ct.sigla,
         ct.nombre,
         ct.unipersonal,
         ct.categ1,
         ct.categ2,
         ct.categ3,
         ct.telf1,
         ct.telf2,
         ct.telf3,
         ct.telf4,
         ct.correo,
         ct.web,
         ct.contacto
  from param.tproveedor_tmp ct
  where ct.migrado = 'no')
  LOOP

    raise notice 'PROVEEDOR: %', v_r;

    v_r.telf1 = replace(v_r.telf1, '.', '');
    v_r.telf1 = replace(v_r.telf1, '-', '');
    v_r.telf1 = replace(v_r.telf1, ' ', '');
    v_r.telf1 = replace(v_r.telf1, '(', '');
    v_r.telf1 = replace(v_r.telf1, ')', '');
    v_r.telf1 = replace(v_r.telf1, '+', '');

    v_r.telf2 = replace(v_r.telf2, '.', '');
    v_r.telf2 = replace(v_r.telf2, '-', '');
    v_r.telf2 = replace(v_r.telf2, ' ', '');
    v_r.telf2 = replace(v_r.telf2, '(', '');
    v_r.telf2 = replace(v_r.telf2, ')', '');
    v_r.telf2 = replace(v_r.telf2, '+', '');

    v_r.telf3 = replace(v_r.telf3, '.', '');
    v_r.telf3 = replace(v_r.telf3, '-', '');
    v_r.telf3 = replace(v_r.telf3, ' ', '');
    v_r.telf3 = replace(v_r.telf3, '(', '');
    v_r.telf3 = replace(v_r.telf3, ')', '');
    v_r.telf3 = replace(v_r.telf3, '+', '');

    v_r.telf4 = replace(v_r.telf4, '.', '');
    v_r.telf4 = replace(v_r.telf4, '-', '');
    v_r.telf4 = replace(v_r.telf4, ' ', '');
    v_r.telf4 = replace(v_r.telf4, '(', '');
    v_r.telf4 = replace(v_r.telf4, ')', '');
    v_r.telf4 = replace(v_r.telf4, '+', '');

    if v_r.sigla='' then
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
    if trim(v_r.unipersonal)='' then--institución

      select '' as apellido_materno,
             ''             as apellido_paterno,
             ''             as casilla,
             ''             as celular1,
             substr(coalesce(v_r.telf1::varchar, ''), 0, 50) as
               celular1_institucion,
             ''             as celular2,
             substr(coalesce(v_r.telf2::varchar, ''), 0, 50) as
               celular2_institucion,
             ''             as ci,
             ''             as codigo,
             ''             as codigo_banco,
             coalesce(v_sigla::varchar, '') as codigo_institucion,
             coalesce(v_r.contacto::varchar, '') as contacto,
             ''             as correo,
             ''             as direccion,
             substr(coalesce(v_r.direccion::varchar, ''), 0, 200) as
               direccion_institucion,
             ''             as doc_id,
             substr(coalesce(v_r.correo::varchar, ''), 0, 100) as
               email1_institucion,
             ''             as email2_institucion,
             ''             as fax,
             ''             as fecha_nacimiento,
             ''             as genero,
             ''             as id_institucion,
             1             as id_lugar,
             ''             as id_persona,
             coalesce(v_r.nit::varchar, '') as nit,
             ''             as nombre,
             coalesce(v_r.nombre::varchar, '') as nombre_institucion,
             '1'             as numero_sigma,
             ''             as observaciones,
             coalesce(v_r.web::varchar, '') as pag_web,
             'no_registered'             as register,
             coalesce(v_r.nom_comercio::varchar, '') as rotulo_comercial,
             ''             as telefono1,
             substr(coalesce(v_r.telf3::varchar, ''), 0, 50) as
               telefono1_institucion,
             ''             as telefono2,
             substr(coalesce(v_r.telf4::varchar, ''), 0, 50) as
               telefono2_institucion,
             'institucion'             as tipo
      into v_parametros;
      else
      select '' as apellido_materno,
             coalesce(v_r.nombre::varchar, '') as apellido_paterno,
             ''             as casilla,
             substr(coalesce(v_r.telf1::varchar, ''), 0, 50) as celular1,
             ''             as celular1_institucion,
             substr(coalesce(v_r.telf2::varchar, ''), 0, 50) as celular2,
             ''             as celular2_institucion,
             ''             as ci,
             ''             as codigo,
             ''             as codigo_banco,
             ''             as codigo_institucion,
             coalesce(v_r.contacto::varchar, '') as contacto,
             substr(coalesce(v_r.correo::varchar, ''), 0, 50) as correo,
             substr(coalesce(v_r.direccion::varchar, ''), 0, 200) as direccion,
             ''             as direccion_institucion,
             ''             as doc_id,
             ''             as email1_institucion,
             ''             as email2_institucion,
             ''             as fax,
             null             as fecha_nacimiento,
             ''             as genero,
             ''             as id_institucion,
             1             as id_lugar,
             ''             as id_persona,
             coalesce(v_r.nit::varchar, '') as nit,
             ''             as nombre,
             ''             as nombre_institucion,
             '1'             as numero_sigma,
             ''             as observaciones,
             ''             as pag_web,
             'no_registered'             as register,
             coalesce(v_r.nom_comercio::varchar, '') as rotulo_comercial,
             substr(coalesce(v_r.telf3::varchar, ''), 0, 50) as telefono1,
             ''             as telefono1_institucion,
             substr(coalesce(v_r.telf4::varchar, ''), 0, 50) as telefono2,
             ''             as telefono2_institucion,
             'persona'             as tipo
      into v_parametros;
    end if;

    raise notice 'PROVEEDOR_RECORD: %', v_parametros.tipo;
    
    v_id_persona = NULL;
    v_id_institucion = null;
    if v_r.id=947 then--para debug
      v_sigla = v_sigla;
    end if;
    --generar codigo de proveedores
    v_num_seq =  nextval('param.seq_codigo_proveedor');
    v_codigo_gen = 'PR'||pxp.f_llenar_ceros(v_num_seq, 6);
    ------------------------------------------------------
    --verificar si existe la persona y recuperar el id 
    if v_parametros.tipo::varchar = 'persona' then
      if trim(v_r.nit)<>'' then
        select p.id_persona
        into v_id_persona
        from segu.tpersona p
        where p.ci like v_r.nit || '%';
      end if;
      
      if v_id_persona is null then
        insert into segu.tpersona(nombre,
          apellido_paterno,
          apellido_materno,
          ci,
          correo,
          celular1,
          telefono1,
          telefono2,
          celular2,
          genero,
          direccion,
          num_documento)
        values (v_parametros.nombre,
          v_parametros.apellido_paterno,
          v_parametros.apellido_materno,
          v_parametros.ci,
          v_parametros.correo,
          v_parametros.celular1,
          v_parametros.telefono1,
          v_parametros.telefono2,
          v_parametros.celular2,
          v_parametros.genero,
          v_parametros.direccion,
          '420')
          RETURNING id_persona
        INTO v_id_persona;
      end if;
      else
      --verificar que el codigo no se duplique
      IF   exists(
        select 1
        from param.tinstitucion i
        where i.estado_reg = 'activo' and
              i.codigo = v_parametros.codigo_institucion) THEN
        raise exception 'Ya existe una institución con esta sigla %',
        v_parametros.codigo_institucion;
      END IF;

      

      --Sentencia de la insercion

      insert into param.tinstitucion(fax, estado_reg, casilla, direccion,
        doc_id, telefono2, email2, celular1, email1, nombre, observaciones,
        telefono1, celular2, codigo_banco, pag_web, id_usuario_reg, fecha_reg,
        id_usuario_mod, fecha_mod, codigo)
      values (v_parametros.fax, 'activo', v_parametros.casilla,
        v_parametros.direccion_institucion, v_parametros.nit,
        v_parametros.telefono2_institucion, v_parametros.email2_institucion,
        v_parametros.celular1_institucion, v_parametros.email1_institucion,
        v_parametros.nombre_institucion, v_parametros.observaciones,
        v_parametros.telefono1_institucion, v_parametros.celular2_institucion,
        v_parametros.codigo_banco, v_parametros.pag_web, 1, now(),
        null, null, COALESCE(v_parametros.codigo_institucion, v_codigo_gen))
        RETURNING id_institucion
      into v_id_institucion;
    end if;

    insert into param.tproveedor(id_usuario_reg,
      fecha_reg,
      estado_reg,
      id_institucion,
      id_persona,
      tipo,
      numero_sigma,
      codigo,
      nit,
      id_lugar,
      rotulo_comercial,
      contacto)
    values (1::integer,
      now(),
      'activo'::varchar,
      v_id_institucion::integer,
      v_id_persona::integer,
      v_parametros.tipo::varchar,
      v_parametros.numero_sigma::varchar,
      v_codigo_gen::varchar,
      v_parametros.nit::varchar,
      v_parametros.id_lugar::integer,
      v_parametros.rotulo_comercial::varchar,
      v_parametros.contacto::varchar) RETURNING id_proveedor::integer
    into v_id_proveedor::integer;
/*
    --insertar auxiliar
    -- chequear si existe el esquema de contabilidad
    IF EXISTS (
      SELECT 1
      FROM information_schema.tables
      WHERE table_schema = 'conta' AND
            table_name = 'tauxiliar') THEN

      --  verificamos que el codigo no este duplicado

      IF  exists(
        select 1
        from conta.tauxiliar a
        where a.estado_reg = 'activo' and
              upper(a.codigo_auxiliar) = upper(v_codigo_gen)) THEN
        raise exception 'Ya existe un auxiliar con el código %', v_parametros.codigo;
      END IF;

      select p.desc_proveedor
      INTO v_desc_proveedor
      from param.vproveedor p
      where p.id_proveedor = v_id_proveedor;

      IF  exists(
        select 1
        from conta.tauxiliar a
        where a.estado_reg = 'activo' and
              a.nombre_auxiliar = v_desc_proveedor)
        THEN
        v_desc_proveedor = v_desc_proveedor || ' (PROVEEDOR)'
        ;
        --raise exception 'Ya existe un auxiliar con esta descripcion:  %',v_desc_proveedor;           
      END IF;

      --Sentencia de la insercion

      insert into conta.tauxiliar(estado_reg, codigo_auxiliar, nombre_auxiliar,
        fecha_reg, id_usuario_reg, id_usuario_mod, fecha_mod, corriente)
      values ('activo', upper(v_codigo_gen), v_desc_proveedor, now(),
        1, null, null, 'si') RETURNING id_auxiliar
      into v_id_auxiliar;
      
      update param.tproveedor p
      set id_auxiliar = v_id_auxiliar
      where p.id_proveedor = v_id_proveedor;

      --relaciona el auxiliar con las cuentas de proveedores (proveedores por pagar, retenciones)

      SELECT csc.id_config_subtipo_cuenta
      into v_id_config_subtipo_cuenta
      FROM conta.tconfig_subtipo_cuenta csc
      where upper(csc.nombre) in ('PROVEEDORES', 'CUENTAS POR PAGAR') and
            csc.estado_reg = 'activo';

      if v_id_config_subtipo_cuenta is null then
        raise exception ' no tiene configurado un subtipo de cuenta para PROVEEDORES o CUENTAS POR PAGAR';
      end if;

      for v_reg_cuenta in (
      select c.id_cuenta
      from conta.tcuenta c
      where c.id_config_subtipo_cuenta = v_id_config_subtipo_cuenta and
            c.estado_reg = 'activo' and
            c.sw_transaccional = 'movimiento')
      LOOP

        --  verificar si el auxilair no esta asociado 
        IF not exists (
          select 1
          from conta.tcuenta_auxiliar ca
          where ca.estado_reg = 'activo' and
                ca.id_cuenta = v_reg_cuenta.id_cuenta and
                ca.id_auxiliar = v_id_auxiliar) THEN

          --asociamos el auxilar a las cuentas  de proveedores

          insert into conta.tcuenta_auxiliar(estado_reg, id_auxiliar, id_cuenta,
            id_usuario_reg, fecha_reg, id_usuario_mod, fecha_mod)
          values ('activo', v_id_auxiliar, v_reg_cuenta.id_cuenta, 1,
            now(), null, null);
        END IF;

      END LOOP;

    END IF;

    --Definicion de la respuesta
    v_resp = pxp.f_agrega_clave(v_resp,'mensaje',
      'Proveedores almacenado(a) con exito (id_proveedor'||
      v_id_proveedor||')');
    v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_id_proveedor::
      varchar);

    -------------------------------------------------------

*/
    
    update param.tproveedor_tmp p
    set id_proveedor = v_id_proveedor,
        migrado = 'si'
    where p.id = v_r.id;
    raise notice 'OK: % - %', v_id_proveedor, v_r.nom_comercio;
    --*/
  END LOOP;

  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;