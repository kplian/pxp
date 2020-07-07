--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tpalabra_clave (
  p_accion varchar,
  p_estado_reg varchar,
  p_codigo varchar,
  p_default_text varchar,
  p_codigo_grupo_idioma varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Parametros Generales
 FUNCION:       param."f_import_tpalabra_clave "
 DESCRIPCION:   Importador de datos para la tabla grupo idioma
 AUTOR:         RAC
 FECHA:         15-05-2020 02:54:58
 COMENTARIOS:    
***************************************************************************
HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
#133               15-05-2020 02:54:58    RAC             Creacion    
#
 ***************************************************************************/

DECLARE
	v_id_palabra_clave 		integer;
    v_id_grupo_idioma       integer;
BEGIN

   -- llamda de ejemplo
   -- select param.f_import_tpalabra_clave ('insert','activo', '_actualizar', 'Actualizar', 'BASICO');
   
   SELECT gi.id_grupo_idioma
     INTO v_id_grupo_idioma
     FROM param.tgrupo_idioma gi
    WHERE gi.codigo = p_codigo_grupo_idioma;
      
    SELECT pc.id_palabra_clave
      INTO v_id_palabra_clave
      FROM param.tpalabra_clave pc
      JOIN param.tgrupo_idioma gi ON gi.id_grupo_idioma = pc.id_grupo_idioma
     WHERE pc.codigo = p_codigo
       AND gi.id_grupo_idioma = v_id_grupo_idioma;
    
    
      if (v_id_palabra_clave is null)then
      
         INSERT INTO 
            param.tpalabra_clave
          (
            id_usuario_reg,            
            fecha_reg,           
            estado_reg,          
            obs_dba,           
            id_grupo_idioma,
            codigo,
            default_text
          )
          VALUES (
            1,            
            now(),          
            'activo',         
            'insertado desde la importacion f_import_tgrupo_idioma',--obs_dba,           
            v_id_grupo_idioma,
            p_codigo,
            p_default_text
          );


               
      else 
      
         UPDATE 
              param.tpalabra_clave 
            SET 
               id_usuario_mod = 1,           
               fecha_mod = NOW(),
               estado_reg = p_estado_reg,            
               obs_dba =   'modificado desde la importacion f_import_tgrupo_idioma',
               default_text = p_default_text
            WHERE 
              id_palabra_clave = v_id_palabra_clave;
                	
      end if;
    
       
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;