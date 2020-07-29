CREATE OR REPLACE FUNCTION segu.f_signup (
  p_email character varying,
  p_nombre character varying,
  p_apellido character varying,
  p_login character varying,
  p_contrasena character varying

)
RETURNS integer
AS
$body$
/**************************************************************************
 FUNCION: 		segu.f_get_id_usuario
 DESCRIPCION: 	Crea usuario desde el formulario de sign up con un rol configurado en variable global
 AUTOR: 		KPLIAN(JRR)
 FECHA:			23/JUN/2020
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:

***************************************************************************/
DECLARE
  v_id_usuario  integer;
  v_role        varchar;
  v_id_rol      integer;
  v_id_persona  integer;
  v_segu_extra_function varchar;
  v_extra       boolean;
BEGIN
  --validate signup is allowed
  if (not exists(
    select 1
    from pxp.variable_global
    where variable = 'segu_signup' and valor = 'true')) then
    raise exception 'Signup de usuarios no permitido';
  end if;
  --validate role is defined
  select valor
  into v_role
  from pxp.variable_global
  where variable = 'segu_def_rol_google_face';

  select id_rol into v_id_rol
  from segu.trol
  where rol = v_role;

  if (coalesce(v_id_rol, -1) = -1) then
    raise exception 'No existe ningun rol definido para signup';
  end if;
  --validate same email doesn't exists

  if (exists(
    select 1
    from segu.tusuario u
    inner join segu.tpersona p on p.id_persona = u.id_persona
    where p.correo ilike p_email or u.cuenta ilike p_email)) then
    raise exception 'Ya existe un usuario con el mismo correo, intente recuperar su password.';
  end if;
  --validate login doesn't exists
  if (exists(
    select 1
    from segu.tusuario u
    where u.cuenta ilike p_login )) then
    raise exception 'Ya existe un usuario con el mismo nombre de usuario.';
  end if;


  --insert person
  insert into segu.tpersona (
    nombre,
    apellido_paterno,
    correo
  )
  values(
    p_nombre,
    p_apellido,
    p_email
  ) RETURNING id_persona into v_id_persona;

  --insert inactive user, signup token sign up expiration token
  insert into segu.tusuario (
      id_clasificador,
      cuenta,
      contrasena,
      fecha_caducidad,
      estilo,
      id_persona,
      estado_reg,
      reset_token,
      token_expiration)
  values (
      1,
      p_login,
      md5(p_contrasena),
      (SELECT CAST(now() AS DATE) + CAST('10 year' AS INTERVAL)),
      'xtheme-access.css',
      v_id_persona,
      'activo'::pxp.estado_reg,
      null,
      null)
      --pxp.f_generate_token(15),
      --now() + (pxp.f_get_variable_global('segu_token_expiration') || ' hour')::interval)
	RETURNING id_usuario into v_id_usuario;

  insert into segu.tusuario_rol (id_usuario, id_rol, estado_reg)
  values( v_id_usuario,(select id_rol from segu.trol where rol='PXP-Rol inicial'),'activo');

  insert into segu.tusuario_rol (id_usuario, id_rol, estado_reg)
  values( v_id_usuario, v_id_rol, 'activo');

  -- recuperar funcion para ejecutar funcionalidad extra
  v_segu_extra_function = pxp.f_get_variable_global('segu_extra_function');

  IF v_segu_extra_function != '' THEN
    EXECUTE 'SELECT '||v_segu_extra_function||'($1)'
    INTO  v_extra
    USING v_id_usuario;


      IF not v_extra THEN
        raise exception 'error al procesar funcionalidad adicional';
      END IF;
  END IF;

  RETURN v_id_usuario;


END;
$body$
    LANGUAGE plpgsql;
