--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_insertar_funcionario_asistente (
  v_id_funcionario integer
)
RETURNS boolean AS
$body$
DECLARE
  v_registros record;
BEGIN

  FOR v_registros in (select uo.id_uo
                      from orga.tuo uo
                      where uo.presupuesta='si'
                      and uo.id_uo not in (select a.id_uo from param.tasistente a where a.id_funcionario=v_id_funcionario))LOOP
          insert into param.tasistente
          ( id_uo,id_funcionario,estado_reg, recursivo, id_usuario_reg)
          VALUES
          (v_registros.id_uo,v_id_funcionario,'activo','Si',1);

  END LOOP;

  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;