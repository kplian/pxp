--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_funcionario_existente (
)
RETURNS boolean AS
$body$
DECLARE

v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
v_id_persona 	integer;
v_genero		varchar;
v_reg_cargo	record;
v_id_afp	integer;
v_estado_civil	varchar;
v_id_funcionario	integer;

v_id_escala_salarial	integer;
v_fecha_ingreso			date;
BEGIN




   FOR v_registros in ( SELECT 
                          id_usuario_reg,
                          id_usuario_mod,
                          fecha_reg,
                          fecha_mod,
                          estado_reg,
                          id_usuario_ai,
                          usuario_ai,
                          id_funcionario,
                          id_persona,
                          codigo,
                          email_empresa,
                          interno,
                          fecha_ingreso,
                          telefono_ofi,
                          antiguedad_anterior,
                          id_auxiliar,
                          id_biometrico
                        FROM 
                          orga.tfuncionario)LOOP

         

           -- recuperamos el cargo y la uo a la que pertenece el cargo

           select
             c.id_uo,
             c.id_cargo,
             c.id_lugar,
             c.id_escala_salarial
           into
             v_reg_cargo
           from orga.tcargo c
           where c.codigo = replace(v_registros.codigo, 'FUN', '');
           
           if v_reg_cargo.id_cargo is not null then
             
            select
             c.fecha_ingreso
           into
             v_fecha_ingreso
           from orga.tcargo_tmp c
           where c.item = replace(v_registros.codigo, 'FUN', '');
           

           -- recuperamos el seguro

             INSERT INTO orga.tuo_funcionario(
                          id_uo,
                          id_funcionario,
                          fecha_asignacion,
                          id_cargo,
                          nro_documento_asignacion,
                          fecha_documento_asignacion,
                          id_usuario_reg,
                          tipo)
             values (
                      v_reg_cargo.id_uo,
                      v_registros.id_funcionario,
                      v_fecha_ingreso,
                      v_reg_cargo.id_cargo,
                      '0',
                       v_fecha_ingreso,
                       1,
                      'oficial');

		
           end if;
END LOOP;


reTURN TRUE;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;