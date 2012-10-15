CREATE OR REPLACE FUNCTION segu.f_actualizar_sesion (
  p_pid_bd integer,
  p_sid_web character varying,
  p_pid_web integer,
  p_transaccion character varying,
  p_procedimiento character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.f_actualizar_log_bd
 DESCRIPCION: 	Actualiza llos datos de sesion del usuario cada vez que se realiza una
                transaccion
 AUTOR: 		KPLIAN(jrr)
 FECHA:			08/03/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
    v_resp      varchar;
    v_nombre_funcion   text;
    v_mensaje_error    text;
BEGIN
    v_nombre_funcion:='segu.f_actualizar_sesion';
    
    update segu.tsesion
    set pid_bd=p_pid_bd,
    transaccion_actual=p_transaccion,
    funcion_actual=p_procedimiento
    where pid_web=p_pid_web and estado_reg='activo' and variable=p_sid_web;

    return 'exito';
EXCEPTION

      WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql SECURITY DEFINER;
--
-- Definition for function f_get_id_usuario (OID = 305030) : 
--
