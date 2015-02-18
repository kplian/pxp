CREATE OR REPLACE FUNCTION alm.ft_item_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_item_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.titem'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          21-09-2012
 COMENTARIOS:  
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:  
 AUTOR:          
 FECHA:      
***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_item    integer;
              
BEGIN

    v_nombre_funcion = 'alm.ft_item_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    if(p_transaccion='SAL_ITEM_INS')then
                  
        begin
            --Sentencia de la insercion
            insert into alm.titem(
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_clasificacion,
            codigo,
            nombre,
            descripcion,
            palabras_clave,
            codigo_fabrica,
             observaciones,
            numero_serie
              ) values(
            p_id_usuario,
            now(),
            'activo',
            v_parametros.id_clasificacion,
            v_parametros.codigo_largo,
            v_parametros.nombre,
            v_parametros.descripcion,
            v_parametros.palabras_clave,
            v_parametros.codigo_fabrica,
            v_parametros.observaciones,
            v_parametros.numero_serie
            )RETURNING id_item into v_id_item;
             
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item almacenado(a) con exito (id_item'||v_id_item||')');
            v_resp = f_agrega_clave(v_resp,'id_item',v_id_item::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEM_MOD')then

        begin
            --Sentencia de la modificacion
            update alm.titem set
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_clasificacion = v_parametros.id_clasificacion,
            codigo = v_parametros.codigo_largo,
            nombre = v_parametros.nombre,
            descripcion = v_parametros.descripcion,
            palabras_clave = v_parametros.palabras_clave,
            codigo_fabrica = v_parametros.codigo_fabrica,
            observaciones = v_parametros.observaciones,           
            numero_serie = v_parametros.numero_serie
            where id_item=v_parametros.id_item;
             
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_item',v_parametros.id_item::VARCHAR);
             
            --Devuelve la respuesta
            return v_resp;
          
        end;

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEM_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from alm.titem
            where id_item=v_parametros.id_item;
             
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_item',v_parametros.id_item::varchar);
            
            --Devuelve la respuesta
            return v_resp;

        end;
       
    else
   
        raise exception 'Transaccion inexistente: %',p_transaccion;

    end if;

EXCEPTION
              
    WHEN OTHERS THEN
        v_resp='';
        v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
        raise exception '%',v_resp;
                      
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_item_sel (OID = 688807) :
--
