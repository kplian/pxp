CREATE OR REPLACE FUNCTION orga.f_obtener_funcionarios_x_uo (
  kp_id_uo integer,
  p_fecha date = now(),
  p_activos varchar = 'si'::character varying
)
RETURNS varchar AS
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
v_respuesta varchar;
v_registros record;
v_id_uo     integer;
v_filtro_fecha	varchar;


BEGIN
	if (p_activos = 'si')then
    	v_filtro_fecha = '(ha.fecha_asignacion <= ''' || p_fecha::date || ''' and 
        					(ha.fecha_finalizacion >= ''' || p_fecha::date || ''' or ha.fecha_finalizacion is NULL))';
    else
    	v_filtro_fecha = '0=0';
    end if;

    for v_registros in execute(
                      'select e.desc_funcionario1 as nombre_completo
                         from orga.vfuncionario e
                         inner join orga.tuo_funcionario ha on ha.id_funcionario=e.id_funcionario
                         where ha.estado_reg=''activo'' and ha.id_uo=' || kp_id_uo || '
                               and ' || v_filtro_fecha
                         ) loop

               if(v_respuesta!='') then
                  v_respuesta:= COALESCE(v_respuesta,'')||'<br>-'||v_registros.nombre_completo;
               else
                  v_respuesta:=v_registros.nombre_completo;
               end if;

     end loop;
return v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;