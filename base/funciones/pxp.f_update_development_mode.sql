--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_update_development_mode (
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        PXP
 FUNCION:         pxp.f_update_development_mode
 DESCRIPCION:   Modifica Variables Globales que se deben deshabilidar para el modo desarrollo
 AUTOR:          (EGS)
 FECHA:         05/12/2019
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 ISSUE      FECHA         AUTHOR         DESCRIPCION
 #92         02/12/2019    EGS           creacion
***************************************************************************/
-----------------------------------------
-- CUERPO DE LA FUNCIÓN --
-----------------------------------------

DECLARE

    v_resp              varchar;
    v_nombre_funcion    varchar;


BEGIN
    v_nombre_funcion = 'pxp.f_update_development_mode';

    UPDATE pxp.variable_global SET
        valor = 'false'
    WHERE  variable = 'conta_migrar_comprobante';

    UPDATE pxp.variable_global SET
        valor = 'hostaddr=xxx.xx.xx.xxx port=5432 dbname=dbXXXX user=dbamigracion password=dbamigracion'
    WHERE  variable = 'conta_host_migracion';

    --Actualizamos las contrasenas con la misma para que al crear una nueva instancia esta pueda
    UPDATE segu.tusuario SET
        contrasena = contrasena;
    v_resp= 'exito';
     return v_resp;
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
COST 100;