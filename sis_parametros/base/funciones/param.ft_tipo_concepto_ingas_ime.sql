CREATE OR REPLACE FUNCTION param.ft_tipo_concepto_ingas_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_tipo_concepto_ingas_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_concepto_ingas'
 AUTOR:          (egutierrez)
 FECHA:            29-04-2019 13:28:44
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                29-04-2019 13:28:44                                Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_concepto_ingas'    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_tipo_concepto_ingas    integer;
                
BEGIN

    v_nombre_funcion = 'param.ft_tipo_concepto_ingas_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_TICOING_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez    
     #FECHA:        29-04-2019 13:28:44
    ***********************************/

    if(p_transaccion='PM_TICOING_INS')then
                    
        begin
            --Sentencia de la insercion
            insert into param.ttipo_concepto_ingas(
            nombre,
            descripcion,
            id_concepto_ingas,
            estado_reg,
            id_usuario_ai,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            fecha_mod,
            id_usuario_mod
              ) values(
            v_parametros.nombre,
            v_parametros.descripcion,
            v_parametros.id_concepto_ingas,
            'activo',
            v_parametros._id_usuario_ai,
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            null,
            null
                            
            
            
            )RETURNING id_tipo_concepto_ingas into v_id_tipo_concepto_ingas;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Concepto Ingas almacenado(a) con exito (id_tipo_conepto_ingas'||v_id_tipo_concepto_ingas||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_concepto_ingas',v_id_tipo_concepto_ingas::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_TICOING_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez    
     #FECHA:        29-04-2019 13:28:44
    ***********************************/

    elsif(p_transaccion='PM_TICOING_MOD')then

        begin
            --Sentencia de la modificacion
            update param.ttipo_concepto_ingas set
            nombre = v_parametros.nombre,
            descripcion = v_parametros.descripcion,
            id_concepto_ingas = v_parametros.id_concepto_ingas,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            where id_tipo_concepto_ingas=v_parametros.id_tipo_concepto_ingas;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Concepto Ingas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_concepto_ingas',v_parametros.id_tipo_concepto_ingas::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_ticoing_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        egutierrez    
     #FECHA:        29-04-2019 13:28:44
    ***********************************/

    elsif(p_transaccion='PM_TICOING_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.ttipo_concepto_ingas
            where id_tipo_concepto_ingas=v_parametros.id_tipo_concepto_ingas;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Concepto Ingas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_concepto_ingas',v_parametros.id_tipo_concepto_ingas::varchar);
              
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