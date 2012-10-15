CREATE OR REPLACE FUNCTION orga.f_obtener_funcionarios_x_uo (
  kp_id_uo integer
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE KARD
***************************************************************************
 SCRIPT:f_obtener_funcionarios_x_uo
 COMENTARIOS:
 AUTOR: MZM
 Fecha: 19-03-12

*/
DECLARE
v_respuesta varchar;
v_registros record;
v_id_uo     integer;
BEGIN

    for v_registros in (
    select e.desc_funcionario1 as nombre_completo
                         from orga.vfuncionario e
                         inner join orga.tuo_funcionario ha on ha.id_funcionario=e.id_funcionario
                         where ha.estado_reg='activo' and ha.id_uo=kp_id_uo) loop

               if(v_respuesta!='') then
                  v_respuesta:= COALESCE(v_respuesta,'')||'<br>-'||v_registros.nombre_completo;
               else
                  v_respuesta:=v_registros.nombre_completo;
               end if;

     end loop;
return v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_obtener_uo_x_funcionario (OID = 304940) : 
--
