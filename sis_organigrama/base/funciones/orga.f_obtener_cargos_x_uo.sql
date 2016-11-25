CREATE OR REPLACE FUNCTION orga.f_obtener_cargos_x_uo (
  kp_id_uo integer,
  p_fecha date = now(),
  p_activos varchar = 'si'::character varying
)
RETURNS varchar [] AS
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
	select pxp.aggarray(c.codigo)::VARCHAR[] into v_respuesta
    from orga.tcargo c
    where c.estado_reg = 'activo' and c.id_uo = kp_id_uo;    
    
return v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;