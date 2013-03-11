--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_obtener_funcionarios_x_uo_array (
  kp_id_uo integer,
  p_fecha date = now()
)
RETURNS integer [] AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE KARD
***************************************************************************
 SCRIPT:f_obtener_funcionarios_x_uo
 COMENTARIOS:
 AUTOR: MZM
 Fecha: 19-03-12
 
 MODIFICACIONES
 
 
 AUTOR: RAC
 DESCRIPCION:  Se adiciona el campode fecha por las asignaciones de usuario up varia segun la fecha 
 de ingerso y retiro

*/
DECLARE

v_registros record;
v_id_uo     integer;

v_resp INTEGER[];
v_cont integer;


BEGIN



v_cont = 1;

    for v_registros in (
                      select ha.id_funcionario
                         from orga.tuo_funcionario ha 
                         where ha.estado_reg='activo' and ha.id_uo=kp_id_uo
                               and ((ha.fecha_asignacion <= p_fecha and ha.fecha_finalizacion >=p_fecha) 
                                   or (ha.fecha_asignacion <= p_fecha and ha.fecha_finalizacion is NULL))
                         ) loop

               if(v_respuesta!='') then
                  v_resp[v_cont]=v_registros.id_funcionario;
                  v_cont= v_cont +1;
                  
               end if;

     end loop;
return v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;