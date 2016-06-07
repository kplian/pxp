CREATE OR REPLACE FUNCTION orga.f_get_cargo_x_funcionario_str(p_id_funcionario int4, p_fecha date, p_tipo_cargo varchar = 'ambos')
  RETURNS varchar
AS
$BODY$
  DECLARE
  v_id_empleado				integer;
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_mensaje_error         	text;
  v_tipo 					varchar;
  v_consulta 				varchar;
BEGIN
  v_nombre_funcion = 'orga.f_get_cargo_x_funcionario_str';

  
   select car.nombre
   
  into 
      v_resp
  from orga.tuo_funcionario asig
  inner join orga.tcargo car on car.id_cargo = asig.id_cargo
  where 
         asig.fecha_asignacion <= p_fecha 
     and coalesce(asig.fecha_finalizacion, p_fecha)>=p_fecha 
     and asig.estado_reg = 'activo'
     and asig.id_funcionario = p_id_funcionario
     and  (CASE WHEN p_tipo_cargo = 'ambos'  THEN  
                asig.tipo in ('oficial','funcional')
                    ELSE
                       asig.tipo = p_tipo_cargo
                    END);
     
 
  
  
  return v_resp::varchar;
 
  
  
EXCEPTION
WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
END;
$BODY$
LANGUAGE plpgsql STABLE;