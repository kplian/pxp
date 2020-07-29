--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_insert_testructura_gui (
    par_codigo_gui varchar,
    par_codigo_gui_fk varchar,
    par_modificado integer = 1
)
    RETURNS varchar AS
$body$
/*
    HISTORIAL DE MODIFICACIONES
    ISSUE           FECHA           AUTHOR              DESCRIPCION
    #99             05/08/2019      EGS                 se soluciona que al insertar la gui solo tome la id gui padre en estado activo
    #151			29/07/2020		YMR					se soluciono el problema de la modificacion de la estructura al cambiar nodo padre se duplicaba
*/



DECLARE
    v_id_gui integer;
    v_id_gui_fk integer;
BEGIN
    select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_codigo_gui;

    select id_gui into v_id_gui_fk
    from segu.tgui g
    where g.codigo_gui = par_codigo_gui_fk and g.estado_reg = 'activo';--#99

    if (not exists( select 1
                    from segu.testructura_gui
                    where id_gui = v_id_gui and fk_id_gui = v_id_gui_fk and estado_reg = 'activo'))then
        --#151
        if (exists( select 1
                    from segu.testructura_gui
                    where id_gui = v_id_gui and estado_reg = 'activo')) then

            ALTER TABLE segu.testructura_gui DISABLE TRIGGER USER;
            update segu.testructura_gui
            set modificado = 1, fk_id_gui = v_id_gui_fk
            where id_gui = v_id_gui;
            ALTER TABLE segu.testructura_gui ENABLE TRIGGER USER;

        else
            insert into segu.testructura_gui (id_gui, fk_id_gui, modificado)
            values (v_id_gui, v_id_gui_fk, par_modificado);
        end if;

    else
        ALTER TABLE segu.testructura_gui DISABLE TRIGGER USER;

        update segu.testructura_gui set modificado = 1
        where id_gui = v_id_gui and fk_id_gui = v_id_gui_fk;

        ALTER TABLE segu.testructura_gui ENABLE TRIGGER USER;
    end if;
    return 'exito';
END;
$body$
    LANGUAGE 'plpgsql'
    VOLATILE
    CALLED ON NULL INPUT
    SECURITY INVOKER
    PARALLEL UNSAFE
    COST 100;