--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_concepto_ingas_det_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_concepto_ingas_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconcepto_ingas_det'
 AUTOR:          (admin)
 FECHA:            22-07-2019 14:37:28
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
  ISSUE			AUTHOR			FECHA				DESCRIPCION
  #39 ETR		EGS				31/07/2019			Creacion #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_concepto_ingas_det    integer;
                
BEGIN

    v_nombre_funcion = 'param.ft_concepto_ingas_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_COIND_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        admin    
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    if(p_transaccion='PM_COIND_INS')then
                    
        begin

            --Sentencia de la insercion
            insert into param.tconcepto_ingas_det(
            estado_reg,
            nombre,
            descripcion,
            id_concepto_ingas,
            id_usuario_reg,
            fecha_reg,
            id_usuario_ai,
            usuario_ai,
            id_usuario_mod,
            fecha_mod,
            agrupador,
            id_concepto_ingas_det_fk
              ) values(
            'activo',
            v_parametros.nombre,
            v_parametros.descripcion,
            v_parametros.id_concepto_ingas,
            p_id_usuario,
            now(),
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            null,
            null,
            v_parametros.agrupador,
            v_parametros.id_concepto_ingas_det_fk                         
            
            )RETURNING id_concepto_ingas_det into v_id_concepto_ingas_det;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Concepto Ingreso/gasto Detalle almacenado(a) con exito (id_concepto_ingas_det'||v_id_concepto_ingas_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_det',v_id_concepto_ingas_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_COIND_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        admin    
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COIND_MOD')then

        begin
     
            --Sentencia de la modificacion
            update param.tconcepto_ingas_det set
            nombre = v_parametros.nombre,
            descripcion = v_parametros.descripcion,
            id_concepto_ingas = v_parametros.id_concepto_ingas,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai,
            agrupador =v_parametros.agrupador,
            id_concepto_ingas_det_fk = v_parametros.id_concepto_ingas_det_fk
            where id_concepto_ingas_det=v_parametros.id_concepto_ingas_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Concepto Ingreso/gasto Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_det',v_parametros.id_concepto_ingas_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_COIND_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        admin    
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COIND_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tconcepto_ingas_det
            where id_concepto_ingas_det=v_parametros.id_concepto_ingas_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Concepto Ingreso/gasto Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_det',v_parametros.id_concepto_ingas_det::varchar);
              
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