--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_get_codigo_estado (
  p_id_tipo_estado integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_get_codigo_estado
 DESCRIPCION: 	recupera el codigo apartir del id_tipo_estado
 AUTOR: 		KPLIAN(RAC)
 FECHA:			20/01/2014
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/


DECLARE


v_parametros  		record;
v_nombre_funcion   	text;
v_resp				varchar;
v_codigo   varchar;

BEGIN

  v_nombre_funcion = 'f.f_get_codigo_estado';
   
 select 
      te.codigo
   into
      v_codigo
    from 
    wf.ttipo_estado te
    where te.id_tipo_estado = p_id_tipo_estado;

 RETURN v_codigo;


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