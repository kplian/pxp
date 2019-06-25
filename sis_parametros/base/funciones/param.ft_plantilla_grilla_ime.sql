--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_plantilla_grilla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_plantilla_grilla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tplantilla_grilla'
 AUTOR:          (egutierrez)
 FECHA:            17-06-2019 21:25:26
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #24                17-06-2019 21:25:26      EGS                 Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tplantilla_grilla'    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_plantilla_grilla    integer;
                
BEGIN

    v_nombre_funcion = 'param.ft_plantilla_grilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PLGRI_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez    
     #FECHA:        17-06-2019 21:25:26
    ***********************************/

    if(p_transaccion='PM_PLGRI_INS')then
                    
        begin
             --verificar que el nombre de la planitlla no se suplique
             
             SELECT pg.id_plantilla_grilla 
             INTO v_id_plantilla_grilla
             FROM param.tplantilla_grilla pg
             WHERE pg.id_usuario_reg = p_id_usuario
             AND pg.nombre = UPPER(TRIM(v_parametros.nombre));
        
            IF v_id_plantilla_grilla IS  NOT NULL  THEN
            
                  update param.tplantilla_grilla set
                    codigo = v_parametros.codigo,
                    configuracion = v_parametros.configuracion,
                    nombre = UPPER(TRIM(v_parametros.nombre)),
                    url_interface = v_parametros.url_interface,
                    id_usuario_mod = p_id_usuario,
                    fecha_mod = now(),
                    id_usuario_ai = v_parametros._id_usuario_ai,
                    usuario_ai = v_parametros._nombre_usuario_ai
                  where id_plantilla_grilla=v_id_plantilla_grilla;
             
               
            ELSE
            
               --Sentencia de la insercion
                insert into param.tplantilla_grilla(
                  estado_reg,
                  codigo,
                  configuracion,
                  nombre,
                  url_interface,
                  id_usuario_reg,
                  fecha_reg,
                  id_usuario_ai,
                  usuario_ai,
                  id_usuario_mod,
                  fecha_mod
                    ) values(
                  'activo',
                  v_parametros.codigo,
                  v_parametros.configuracion,
                  UPPER(TRIM(v_parametros.nombre)),
                  v_parametros.url_interface,
                  p_id_usuario,
                  now(),
                  v_parametros._id_usuario_ai,
                  v_parametros._nombre_usuario_ai,
                  null,
                  null
                
                )RETURNING id_plantilla_grilla into v_id_plantilla_grilla;
                
            END IF;
        
            
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla de grilla almacenado(a) con exito (id_plantilla_grilla'||v_id_plantilla_grilla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_grilla',v_id_plantilla_grilla::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_PLGRI_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez    
     #FECHA:        17-06-2019 21:25:26
    ***********************************/

    elsif(p_transaccion='PM_PLGRI_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tplantilla_grilla set
            codigo = v_parametros.codigo,
            configuracion = v_parametros.configuracion,
            nombre = UPPER(TRIM(v_parametros.nombre)),
            url_interface = v_parametros.url_interface,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            where id_plantilla_grilla=v_parametros.id_plantilla_grilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla de grilla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_grilla',v_parametros.id_plantilla_grilla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_PLGRI_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        egutierrez    
     #FECHA:        17-06-2019 21:25:26
    ***********************************/

    elsif(p_transaccion='PM_PLGRI_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tplantilla_grilla
            where id_plantilla_grilla=v_parametros.id_plantilla_grilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla de grilla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_grilla',v_parametros.id_plantilla_grilla::varchar);
              
            --Devuelve la respuesta
            return v_resp;

        end;
         
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;