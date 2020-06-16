CREATE OR REPLACE FUNCTION orga.f_trig_huo_funcionario(
)
    RETURNS trigger AS
$body$
BEGIN
    IF TG_OP = 'INSERT' THEN
        if (exists(select 1
                   from orga.tuo_funcionario uof
                   where uof.id_funcionario = NEW.id_funcionario
                     and uof.estado_reg = 'activo'
                     and (uof.fecha_asignacion <= NEW.fecha_asignacion and
                          (uof.fecha_finalizacion >= NEW.fecha_asignacion)
                       OR uof.fecha_asignacion <= NEW.fecha_finalizacion and
                          uof.fecha_finalizacion >= NEW.fecha_finalizacion))) then
            RAISE EXCEPTION 'El intervalo de fechas ingresadas, No debe solapar a una asignacion de cargo activa';

        end if;
    ELSEIF TG_OP = 'UPDATE' THEN
        if (NEW.fecha_finalizacion is not null ) then
            if (exists(select 1
                       from orga.tuo_funcionario uof
                       where uof.id_funcionario = NEW.id_funcionario
                         and uof.estado_reg = 'activo'
                         and uof.id_uo_funcionario != NEW.id_uo_funcionario
                         and (uof.fecha_asignacion <= NEW.fecha_asignacion and
                              (uof.fecha_finalizacion >= NEW.fecha_asignacion)
                           OR uof.fecha_asignacion <= NEW.fecha_finalizacion and
                              uof.fecha_finalizacion >= NEW.fecha_finalizacion)
                )) then
                RAISE EXCEPTION 'El intervalo de fechas ingresadas, No debe solapar a una asignacion de cargo activa';
            end if;
         elseif (exists(select 1
                   from orga.tuo_funcionario uof
                   where uof.id_funcionario = NEW.id_funcionario
                       and uof.estado_reg = 'activo'
                       and uof.id_uo_funcionario != NEW.id_uo_funcionario
                       and uof.fecha_finalizacion is null
                      )) then
            RAISE EXCEPTION 'Esta intentado guardar una asignación de cargo sin fecha finalización, Existe ya una asignacion con la misma caracteristica. ';

        end if;

    END IF;

    INSERT INTO orga.huo_funcionario(id_usuario_reg,
                                     id_usuario_mod,
                                     fecha_reg,
                                     fecha_mod,
                                     estado_reg,
                                     id_usuario_ai,
                                     usuario_ai,
                                     obs_dba,
                                     id_uo_funcionario,
                                     id_uo,
                                     id_funcionario,
                                     fecha_asignacion,
                                     fecha_finalizacion,
                                     tipo,
                                     fecha_documento_asignacion,
                                     nro_documento_asignacion,
                                     observaciones_finalizacion,
                                     id_cargo,
                                     certificacion_presupuestaria,
                                     carga_horaria,
                                     prioridad,
                                     separar_contrato,
                                     fecha_registro_historico)
    VALUES (OLD.id_usuario_reg,
            OLD.id_usuario_mod,
            OLD.fecha_reg,
            OLD.fecha_mod,
            OLD.estado_reg,
            OLD.id_usuario_ai,
            OLD.usuario_ai,
            OLD.obs_dba,
            OLD.id_uo_funcionario,
            OLD.id_uo,
            OLD.id_funcionario,
            OLD.fecha_asignacion,
            OLD.fecha_finalizacion,
            OLD.tipo,
            OLD.fecha_documento_asignacion,
            OLD.nro_documento_asignacion,
            OLD.observaciones_finalizacion,
            OLD.id_cargo,
            OLD.certificacion_presupuestaria,
            OLD.carga_horaria,
            OLD.prioridad,
            OLD.separar_contrato,
            now());
    RETURN new;
END
$body$
    LANGUAGE 'plpgsql'
    VOLATILE
    CALLED ON NULL INPUT
    SECURITY INVOKER
    COST 100;

ALTER FUNCTION orga.f_trig_huo_funcionario ()
    OWNER TO postgres;