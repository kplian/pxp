 --------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp._t (
  p_key varchar,
  p_group varchar = NULL::character varying
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		pxp._t
 DESCRIPCION:   recuepra traducciones segun idioma del usuario
 AUTOR: 	    KPLIAN (rac)	
 FECHA:	        21-04-2020

***************************************************************************
HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
#133               21-04-2020 03:41:52    admin             Creacion    
 	
***************************************************************************/
DECLARE
	v_resp   varchar;
    
BEGIN
	
    WITH base_query  AS (
     SELECT
      pc.id_palabra_clave,
      pc.codigo,
      tr.texto
     FROM param.tpalabra_clave pc
     JOIN param.tgrupo_idioma gr ON gr.id_grupo_idioma = pc.id_grupo_idioma
     JOIN param.ttraduccion tr ON pc.id_palabra_clave = tr.id_palabra_clave
     JOIN param.tlenguaje len ON len.id_lenguaje = tr.id_lenguaje
     WHERE upper(len.codigo) = pxp.glb('lenguaje_usu')
       AND pc.codigo = p_key
       AND gr.codigo =  COALESCE(p_group,pxp.glb('lenguaje_grupo'))
    )
     
     SELECT     
      COALESCE(bq.texto,pc.default_text) INTO v_resp
     FROM param.tpalabra_clave pc
     JOIN param.tgrupo_idioma gr ON gr.id_grupo_idioma = pc.id_grupo_idioma
     LEFT JOIN base_query bq ON bq.id_palabra_clave = pc.id_palabra_clave
     WHERE pc.codigo = p_key
       AND gr.codigo =  COALESCE(p_group,pxp.glb('lenguaje_grupo'));
     

     RETURN COALESCE(v_resp,'__NO_TRADUCIDO__KEY__'||p_key);
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;