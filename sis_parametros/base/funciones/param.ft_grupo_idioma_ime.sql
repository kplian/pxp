--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_grupo_idioma_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_grupo_idioma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tgrupo_idioma'
 AUTOR:          (RAC)
 FECHA:            21-04-2020 02:29:46
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133                21-04-2020 02:29:46    RAC             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_grupo_idioma          INTEGER;
    v_registros                RECORD;
    v_rec_det                  RECORD;
    v_base_query               VARCHAR;
    v_id_palabra_clave         INTEGER;
                
BEGIN

    v_nombre_funcion = 'param.ft_grupo_idioma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_GRI_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/

    IF (p_transaccion='PM_GRI_INS') THEN
                    
        BEGIN
        
            --si es un grupo del tipo almacenado es obligatorio regitrar, tablas , columnas llave y columnas de texto por defeco
            IF v_parametros.tipo = 'almacenado' THEN
                IF v_parametros.nombre_tabla IS NULL OR v_parametros.nombre_tabla = ''  THEN
                    raise exception 'El nombre de la tabla es obligatorio para grupos de datos almacenados';
                END IF; 
                
                IF v_parametros.columna_llave IS NULL OR v_parametros.columna_llave = ''  THEN
                    raise exception 'El nombre de la  columna llave es obligatorio para grupos de datos almacenados';
                END IF;
                
                IF v_parametros.columna_texto_defecto IS NULL OR v_parametros.columna_texto_defecto = ''  THEN
                    raise exception 'El nombre de la  columna de texto por defecto es obligatorio para grupos de datos almacenados';
                END IF;   
            
            END IF;
        
        
            --Sentencia de la insercion
            INSERT INTO param.tgrupo_idioma(
            codigo,
            nombre,
            tipo,
            estado_reg,
            nombre_tabla,
            id_usuario_ai,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            id_usuario_mod,
            fecha_mod,
            columna_llave,
            columna_texto_defecto
              ) VALUES (
            v_parametros.codigo,
            v_parametros.nombre,
            trim(v_parametros.tipo),
            'activo',
            v_parametros.nombre_tabla,
            v_parametros._id_usuario_ai,
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            null,
            null,
            trim(v_parametros.columna_llave),
            trim(v_parametros.columna_texto_defecto)            
            ) RETURNING id_grupo_idioma into v_id_grupo_idioma;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo de Idioma almacenado(a) con exito (id_grupo_idioma'||v_id_grupo_idioma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_idioma',v_id_grupo_idioma::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_GRI_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/

    ELSIF (p_transaccion='PM_GRI_MOD') THEN

        BEGIN
            --si es un grupo del tipo almacenado es obligatorio regitrar, tablas , columnas llave y columnas de texto por defeco
            IF v_parametros.tipo = 'almacenado' THEN
                IF v_parametros.nombre_tabla IS NULL OR v_parametros.nombre_tabla = ''  THEN
                    raise exception 'El nombre de la tabla es obligatorio para grupos de datos almacenados';
                END IF; 
                
                IF v_parametros.columna_llave IS NULL OR v_parametros.columna_llave = ''  THEN
                    raise exception 'El nombre de la  columna llave es obligatorio para grupos de datos almacenados';
                END IF;
                
                IF v_parametros.columna_texto_defecto IS NULL OR v_parametros.columna_texto_defecto = ''  THEN
                    raise exception 'El nombre de la  columna de texto por defecto es obligatorio para grupos de datos almacenados';
                END IF;   
            
            END IF;
            
            --Sentencia de la modificacion
            UPDATE param.tgrupo_idioma SET
              codigo = v_parametros.codigo,
              nombre = v_parametros.nombre,
              tipo = trim(v_parametros.tipo),
              nombre_tabla = trim(v_parametros.nombre_tabla),
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai,
              columna_llave = trim(v_parametros.columna_llave),
              columna_texto_defecto = trim(v_parametros.columna_texto_defecto) 
            WHERE id_grupo_idioma=v_parametros.id_grupo_idioma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo de Idioma modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_idioma',v_parametros.id_grupo_idioma::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_GRI_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/

    ELSIF (p_transaccion='PM_GRI_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tgrupo_idioma
            WHERE id_grupo_idioma=v_parametros.id_grupo_idioma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo de Idioma eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_idioma',v_parametros.id_grupo_idioma::varchar);
              
            --Devuelve la respuesta
            RETURN v_resp;

        END;
     /*********************************    
     #TRANSACCION:  'PM_GENKEYS_IME'
     #DESCRIPCION:   insertar las llaves de traduccion para el grupo seleccionado
     #AUTOR:        RAC    
     #FECHA:        21-04-2020 02:29:46
    ***********************************/
    ELSIF (p_transaccion='PM_GENKEYS_IME') THEN

        BEGIN
            
            SELECT 
                gi.id_grupo_idioma,
                gi.codigo, 
                gi.tipo,
                gi.columna_llave,
                gi.columna_texto_defecto,
                gi.nombre_tabla
            INTO v_registros
            FROM param.tgrupo_idioma gi
            WHERE gi.id_grupo_idioma = v_parametros.id_grupo_idioma;
            
            --validaciones
            IF  v_registros.tipo != 'almacenado'  THEN
                raise exception 'El grupo no es del tipo de datos almacenados';
            END IF;
            
            IF v_registros.nombre_tabla IS NULL OR v_registros.nombre_tabla = ''  THEN
                raise exception 'la tabla no esta configurada';
            END IF;
            
            IF v_registros.columna_llave IS NULL OR v_registros.columna_llave = ''  THEN
                raise exception 'la columna llave no esta configurada';
            END IF;
            
            IF v_registros.columna_texto_defecto IS NULL OR v_registros.columna_texto_defecto = ''  THEN
                raise exception 'la columna de texto por defecto no esta configurada';
            END IF;
            
            --recuperamos los datos de la tabla configurada
            v_base_query := 'SELECT  
                                 '|| v_registros.columna_llave ||' as columna_llave,
                                 '|| v_registros.columna_texto_defecto ||' as  columna_texto_defecto     
                             FROM '||v_registros.nombre_tabla ||' tab
                             WHERE  tab.estado_reg = ''activo'' ';
            
            FOR v_rec_det  in execute (v_base_query) LOOP
            
                --verificamos si el dato ya existe en la talba de llaves
                v_id_palabra_clave := NULL;
                
                SELECT pc.id_palabra_clave
                  INTO v_id_palabra_clave
                  FROM param.tpalabra_clave pc
                  JOIN param.tgrupo_idioma gi ON gi.id_grupo_idioma = pc.id_grupo_idioma
                 WHERE pc.codigo = trim(v_rec_det.columna_llave)
                   AND gi.id_grupo_idioma = v_registros.id_grupo_idioma;
               
                IF (v_id_palabra_clave is null) THEN
      
                    -- si la llave  no existe la insertamos
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
                      'insertado al generar llaves',--obs_dba,           
                      v_registros.id_grupo_idioma,
                      trim(v_rec_det.columna_llave),
                      v_rec_det.columna_texto_defecto::Varchar
                    );   
                ELSE                
                   -- si existe actualizamos  el texto por defecto
                   UPDATE 
                        param.tpalabra_clave 
                      SET 
                         id_usuario_mod = 1,           
                         fecha_mod = NOW(),           
                         obs_dba =   'modificado al generar llaves',
                         default_text = v_rec_det.columna_texto_defecto::Varchar
                      WHERE 
                        id_palabra_clave = v_id_palabra_clave;
                          	
                END IF;
            END LOOP;
                
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','se generaron llavez para el grupo de idioma '||v_registros.codigo); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_idioma',v_parametros.id_grupo_idioma::varchar);
              
            --Devuelve la respuesta
            RETURN v_resp;

        END;
   
         
    ELSE
     
        RAISE EXCEPTION 'Transaccion inexistente: %',p_transaccion;

    END IF;

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