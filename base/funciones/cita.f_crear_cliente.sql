--------------- SQL ---------------

CREATE OR REPLACE FUNCTION cita.f_crear_cliente (
  p_id_usuario integer
)
RETURNS boolean AS
$body$
/**************************************************************************
 SISTEMA:        Citas
 FUNCION:        cita.f_crear_cliente
 DESCRIPCION:    complementa la creacion de clientes de facebon o google 
 AUTOR:          MZM
 FECHA:          08-06-2020 16:17:47
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 #ISSUE          FECHA                  AUTOR                DESCRIPCION
 #0              26-06-2020             RAC                  Creacion
 #
 ***************************************************************************/
 DECLARE
    v_resp                    varchar;
    v_nombre_funcion          text;
    v_mensaje_error           text;
    v_registros               record;
    v_resultado               numeric;
	v_saldo					  numeric;  
BEGIN


      INSERT INTO 
        cita.tcliente
      (
        id_usuario_reg,
        fecha_reg,
        estado_reg,
        codigo_cliente,
        estado_cliente,
        id_usuario
      )
      VALUES (
        1,
        now(),
        'activo',
        'CL'||p_id_usuario::varchar,
        'activo',
         p_id_usuario
      );

      RETURN TRUE;
EXCEPTION

  WHEN OTHERS THEN
    v_resp='';
    v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
    v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
    raise exception '%',v_resp;

  END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;