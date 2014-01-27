CREATE OR REPLACE FUNCTION segu.ft_bloqueo_notificacion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_bloqueo_notificacion_ime
 DESCRIPCION:   Cambia el estado de las notificaciones y bloqueos
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)		
 FECHA:		08/01/11
***************************************************************************/

DECLARE

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_proyecto			integer;


/*

 id_proyecto
 denominacion 
 descripcion
 estado_reg 

*/

BEGIN

     v_nombre_funcion:='segu.ft_bloqueo_notificacion_ime';
     v_parametros:=pxp.f_get_record(p_tabla);

/*******************************
 #TRANSACCION:  SEG_ESBLONO_MOD
 #DESCRIPCION:	Cambia el estado de notificacion y bloqueos
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    if(p_transaccion='SEG_ESBLONO_MOD')then

          --consulta:=';
          BEGIN
               
               update segu.tbloqueo_notificacion
               set estado_reg='inactivo'
               where id_bloqueo_notificacion=v_parametros.id_bloqueo_notificacion;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Bloqueo Notificacion desactivado');
               v_resp = pxp.f_agrega_clave(v_resp,'id_bloqueo_notificacion',v_parametros.id_bloqueo_notificacion::varchar);
              
               return v_resp;
         END;
         
     else
     
         raise exception 'Transaccion inexistente: %',p_transaccion;

     end if;

EXCEPTION

	WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
        
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_bloqueo_notificacion_sel (OID = 305045) : 
--
