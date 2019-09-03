CREATE OR REPLACE FUNCTION param.ft_pie_firma_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_pie_firma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tpie_firma'
 AUTOR: 		
 FECHA:	        02-09-2019 15:43:48
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #56                02-09-2019 15:43:48    mzm                      Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tpie_firma'    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_pie_firma    integer;
                
BEGIN

    v_nombre_funcion = 'param.ft_pie_firma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PIEFIR_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:            
     #FECHA:        02-09-2019 15:43:48
    ***********************************/

    if(p_transaccion='PM_PIEFIR_INS')then
                    
        begin
            --Sentencia de la insercion
            insert into param.tpie_firma(
            estado_reg,
            nombre,
            orientacion,
            id_usuario_reg,
            fecha_reg,
            id_usuario_ai,
            usuario_ai,
            id_usuario_mod,
            fecha_mod
              ) values(
            'activo',
            v_parametros.nombre,
            v_parametros.orientacion,
            p_id_usuario,
            now(),
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            null,
            null
                            
            
            
            )RETURNING id_pie_firma into v_id_pie_firma;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL almacenado(a) con exito (id_pie_firma'||v_id_pie_firma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_pie_firma',v_id_pie_firma::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_PIEFIR_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:            
     #FECHA:        02-09-2019 15:43:48
    ***********************************/

    elsif(p_transaccion='PM_PIEFIR_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tpie_firma set
            nombre = v_parametros.nombre,
            orientacion = v_parametros.orientacion,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            where id_pie_firma=v_parametros.id_pie_firma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_pie_firma',v_parametros.id_pie_firma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_PIEFIR_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:            
     #FECHA:        02-09-2019 15:43:48
    ***********************************/

    elsif(p_transaccion='PM_PIEFIR_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tpie_firma
            where id_pie_firma=v_parametros.id_pie_firma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_pie_firma',v_parametros.id_pie_firma::varchar);
              
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