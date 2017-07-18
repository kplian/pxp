CREATE OR REPLACE FUNCTION param.ftrig_talarma (
)
  RETURNS trigger AS
$body$
DECLARE
v_id_persona INTEGER;
  v_id_usuario integer;
BEGIN
  IF (TG_OP='INSERT')then
    BEGIN

      select usu.id_usuario INTO v_id_usuario FROM orga.tfuncionario fun
        INNER JOIN segu.tusuario usu on usu.id_persona = fun.id_persona
      where fun.id_funcionario = NEW.id_funcionario;

      if (v_id_usuario is NOT NULL and NEW.id_funcionario is NOT NULL ) then

        NEW.estado_notificacion = 'pendiente';
        NEW.id_usuario = v_id_usuario;

      ELSIF  (NEW.id_usuario is NOT NULL and NEW.id_funcionario is  NULL ) then

        NEW.estado_notificacion = 'pendiente';

      end if;

      return NEW;
    END;
  END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;