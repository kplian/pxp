--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.get_translations (
  p_grupo varchar,
  p_lenguaje varchar = NULL::character varying
)
RETURNS TABLE (
  codigo varchar,
  texto varchar,
  grupo varchar,
  lenguaje varchar
) AS
$body$
/**************************************************************************
 FUNCION:       pxp.get_translations
 DESCRIPCION:   recuepra traducciones segun idioma del usuario
 AUTOR:         KPLIAN (rac)    
 FECHA:         25-05-2020

***************************************************************************
HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
#133               25-06-2020              rac             Creacion    
     
***************************************************************************/

DECLARE
v_resp              VARCHAR;
v_nombre_funcion    VARCHAR;

BEGIN

  RETURN  QUERY  SELECT     
                    pc.codigo,
                    tr.texto,
                    gr.codigo as grupo,
                    pxp.glb('lenguaje_usu') as lenguaje                  
                 FROM param.tpalabra_clave pc
                 JOIN param.tgrupo_idioma gr ON gr.id_grupo_idioma = pc.id_grupo_idioma
                 JOIN param.ttraduccion tr ON pc.id_palabra_clave = tr.id_palabra_clave
                 JOIN param.tlenguaje len ON len.id_lenguaje = tr.id_lenguaje
                 WHERE upper(len.codigo) = upper(COALESCE(p_lenguaje, pxp.glb('lenguaje_usu')))
                   AND gr.codigo =  p_grupo;

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
COST 100 ROWS 1000;