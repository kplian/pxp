CREATE OR REPLACE FUNCTION alm.ft_almacen_ime (
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
 FUNCION:        alm.ft_almacen_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen'
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
    v_id_almacen    integer;
              
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************  
     #TRANSACCION:  'SAL_ALM_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    if(p_transaccion='SAL_ALM_INS')then
                  
        begin
            --Sentencia de la insercion--
            insert into alm.talmacen(
            estado_reg,
            fecha_mod,
            fecha_reg,
            id_usuario_mod,
            id_usuario_reg,
            codigo,
            nombre,
            localizacion)
            values(
            'activo',
            NULL,
            now(),
            NULL,
            p_id_usuario, 
            v_parametros.codigo,
            v_parametros.nombre,
            v_parametros.localizacion
            )RETURNING id_almacen into v_id_almacen;
             
            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Almacen almacenado(a) con exito (id_almacen'||v_id_almacen||')');
            v_resp = f_agrega_clave(v_resp,'id_almacen',v_id_almacen::varchar);

            --Devuelve la respuesta--
            return v_resp;

        end;

    /*********************************  
     #TRANSACCION:  'SAL_ALM_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALM_MOD')then

        begin
            --Sentencia de la modificacion--
            update alm.talmacen set
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            codigo = v_parametros.codigo,
            nombre = v_parametros.nombre,
            localizacion = v_parametros.localizacion
            where id_almacen=v_parametros.id_almacen;
             
            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Almacen modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen',v_parametros.id_almacen::VARCHAR);
             
            --Devuelve la respuesta--
            return v_resp;
          
        end;

    /*********************************  
     #TRANSACCION:  'SAL_ALM_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALM_ELI')then

        begin
            --Sentencia de la eliminacion--
            delete from alm.talmacen
            where id_almacen=v_parametros.id_almacen;
             
            --Definicion de la respuesta--
            v_resp = f_agrega_clave(v_resp,'mensaje','Almacen eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen',v_parametros.id_almacen::varchar);
            
            --Devuelve la respuesta--
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
-- Definition for function ft_almacen_sel (OID = 688764) :
--
