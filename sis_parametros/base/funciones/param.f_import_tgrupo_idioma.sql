--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tgrupo_idioma (
  p_accion varchar,
  p_codigo varchar,
  p_nombre varchar,
  p_tipo varchar,
  p_estado_reg varchar,
  p_nombre_tabla varchar,
  p_columna_llave varchar,
  p_columna_texto_defecto varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Parametros Generales
 FUNCION:       param.f_import_tgrupo_idioma
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
	v_id_grupo_idioma 		integer;
BEGIN

   -- llamda de ejemplo
   -- select param.f_import_tgrupo_idioma ('insert','BASICO', 'Grupo de traducciones basicas', 'comun',activo',NULL,NULL,NULL);
	    
    select id_grupo_idioma 
    into v_id_grupo_idioma
    from param.tgrupo_idioma gi    
    where gi.codigo = p_codigo;
    
    
      if (v_id_grupo_idioma is null)then
          
        INSERT INTO 
          param.tgrupo_idioma
        (
          id_usuario_reg,            
          fecha_reg,          
          estado_reg,           
          obs_dba,         
          codigo,
          nombre,
          tipo,
          nombre_tabla,
          columna_llave,
          columna_texto_defecto
        )
        VALUES (
          1,            
          now(),          
          'activo',           
          'insertado desde la importacion f_import_tgrupo_idioma',--obs_dba,
          p_codigo,
          p_nombre,
          p_tipo,
          p_nombre_tabla,
          p_columna_llave,
          p_columna_texto_defecto
        );
        
               
      else            
          UPDATE 
            param.tgrupo_idioma 
          SET 
           
            id_usuario_mod = 1,           
            fecha_mod = NOW(),
            estado_reg = p_estado_reg,            
            obs_dba =   'modificado desde la importacion f_import_tgrupo_idioma',
            codigo = p_codigo,
            nombre = p_nombre,
            tipo = p_tipo,
            nombre_tabla = p_nombre_tabla,
            columna_llave = p_columna_llave,
            columna_texto_defecto = p_columna_texto_defecto
          WHERE 
            id_grupo_idioma = v_id_grupo_idioma;       	
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