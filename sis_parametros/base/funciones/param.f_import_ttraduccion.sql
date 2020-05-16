--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_ttraduccion (
  p_accion varchar,
  p_texto varchar,
  p_estado_reg varchar,
  p_codigo_lenguaje varchar,
  p_codigo_palabra_clave varchar,
  p_codigo_grupo varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Parametros Generales
 FUNCION:       param."f_import_ttraduccion  "
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
    v_id_lenguaje           integer;
    v_id_traduccion         integer;
BEGIN

     -- llamda de ejemplo
     -- select param.f_import_ttraduccion ('insert','Linguagem','activo','pt','idioma','BASICO');
     
     
     SELECT len.id_lenguaje
     INTO v_id_lenguaje
     FROM param.tlenguaje len
     WHERE upper(len.codigo) = upper(p_codigo_lenguaje);
     
     IF v_id_lenguaje IS NULL THEN
        raise exception 'No existe el codigo de lenguaje: %',p_codigo_lenguaje;
     END IF;
     
     SELECT gi.id_grupo_idioma
       INTO v_id_grupo_idioma
       FROM param.tgrupo_idioma gi
      WHERE gi.codigo = p_codigo_grupo;
     
     IF v_id_grupo_idioma IS NULL THEN
         raise exception 'No existe el grupo codigo: %',p_codigo_grupo;
     END IF;
     
     
     SELECT pc.id_palabra_clave
     INTO v_id_palabra_clave
     FROM  param.tpalabra_clave pc      
     WHERE  pc.id_grupo_idioma = v_id_grupo_idioma
       AND  pc.codigo = p_codigo_palabra_clave;
       
     IF v_id_palabra_clave IS NULL THEN
         raise exception 'No existe el la palabra clase codigo: %',p_codigo_palabra_clave;
     END IF;
       
      
      
    SELECT   tr.id_traduccion 
      INTO   v_id_traduccion 
      FROM param.ttraduccion tr
      JOIN param.tpalabra_clave pc ON pc.id_palabra_clave = tr.id_palabra_clave     
     WHERE pc.id_palabra_clave = v_id_palabra_clave
       AND tr.id_lenguaje = v_id_lenguaje;
       
     raise notice 'traduccion ID: %  (%,%)',v_id_traduccion, v_id_palabra_clave, v_id_lenguaje;
    
    
      if (v_id_traduccion is null)then
      
          INSERT INTO 
            param.ttraduccion
          (
            id_usuario_reg,          
            fecha_reg,            
            estado_reg,            
            obs_dba,            
            id_palabra_clave,
            id_lenguaje,
            texto
          )
          VALUES (
             1,            
            now(),          
            'activo',         
            'insertado desde la importacion f_import_ttraduccion',--obs_dba,
            v_id_palabra_clave,
            v_id_lenguaje,
            p_texto
          );
         
                     
      else 
          UPDATE 
            param.ttraduccion 
          SET 
             id_usuario_mod = 1,           
             fecha_mod = NOW(),
             estado_reg = p_estado_reg,            
             obs_dba =   'modificado desde la importacion f_import_ttraduccion',
             texto = p_texto
          WHERE 
            id_traduccion = v_id_traduccion;
         
                	
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