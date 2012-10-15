CREATE OR REPLACE FUNCTION pxp.f_runtime_config (
  p_variable character varying,
  p_ambito character varying,
  p_valor character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_runtime_config
 DESCRIPCION:   Cambia el valor de una variable de configuracion de postgresql.conf
                en tiempo de ejecucion
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE
    v_nombre_funcion    varchar;
    v_resp              varchar;
BEGIN
    v_nombre_funcion='pxp.f_runtime_config';
    if(p_variable is null or p_ambito is null or p_valor is null)then
        raise exception 'Error al realizar configuracion en tiempo de ejecucion uno de los parametros esta vacio';
    end if;
    execute('SET '||p_ambito||' '||p_variable||' = '||p_valor);
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
-- Definition for function f_validar_bloqueos (OID = 304250) : 
--
