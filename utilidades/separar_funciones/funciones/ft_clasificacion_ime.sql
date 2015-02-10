CREATE OR REPLACE FUNCTION alm.ft_clasificacion_ime (
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
 FUNCION:         alm.ft_clasificacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tclasificacion'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            25-09-2012
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
    v_id_clasificacion    integer;
    v_codigo_largo varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_clasificacion_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_CLA_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:            Gonzalo Sarmiento    
     #FECHA:            25-09-2012
    ***********************************/

    if(p_transaccion='SAL_CLA_INS')then
                   
        begin
       
           --obtiene codigo recursivamente
            IF v_parametros.id_clasificacion_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
           
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT cla.id_clasificacion,cla.id_clasificacion_fk, cla.codigo,1
               FROM alm.tclasificacion cla
               WHERE cla.id_clasificacion = v_parametros.id_clasificacion_fk
              UNION ALL
               SELECT cla.id_clasificacion,cla.id_clasificacion_fk, cla.codigo , n+1
               FROM alm.tclasificacion cla, t
               WHERE cla.id_clasificacion = t.id_fk
            )
            SELECT textcat_all(a.cod||'.')
             into 
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t
                 order by n desc)  a;
                
                
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
           
           
            --Sentencia de la insercion
            insert into alm.tclasificacion(
            estado_reg,
            fecha_reg,
            id_usuario_reg,
            codigo,
            id_clasificacion_fk,
            nombre,
            descripcion,
            codigo_largo
              ) values(
            'activo',
            now(),
            p_id_usuario,
            v_parametros.codigo,
            v_parametros.id_clasificacion_fk,
            v_parametros.nombre,
            v_parametros.descripcion,
            v_codigo_largo
            )RETURNING id_clasificacion into v_id_clasificacion;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Clasificacion almacenado(a) con exito (id_clasificacion'||v_id_clasificacion||')');
            v_resp = f_agrega_clave(v_resp,'id_clasificacion',v_id_clasificacion::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************   
     #TRANSACCION:  'SAL_CLA_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            25-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_CLA_MOD')then

        begin
            --obtiene codigo recursivamente
            IF v_parametros.id_clasificacion_fk is null THEN
               v_codigo_largo = v_parametros.codigo;
            ELSE
           
             WITH RECURSIVE t(id,id_fk,cod,n) AS (
               SELECT cla.id_clasificacion,cla.id_clasificacion_fk, cla.codigo,1
               FROM alm.tclasificacion cla
               WHERE cla.id_clasificacion = v_parametros.id_clasificacion_fk
              UNION ALL
               SELECT cla.id_clasificacion,cla.id_clasificacion_fk, cla.codigo , n+1
               FROM alm.tclasificacion cla, t
               WHERE cla.id_clasificacion = t.id_fk
            )
            SELECT textcat_all(a.cod||'.')
             into 
             v_codigo_largo
            FROM (SELECT  cod
                  FROM t
                 order by n desc)  a;
                
                
               v_codigo_largo = v_codigo_largo||v_parametros.codigo;
            END IF;
       
            --Sentencia de la modificacion
            update alm.tclasificacion set
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            codigo = v_parametros.codigo,
            id_clasificacion_fk = v_parametros.id_clasificacion_fk,
            nombre = v_parametros.nombre,
              descripcion = v_parametros.descripcion,
            codigo_largo=v_codigo_largo
            where id_clasificacion=v_parametros.id_clasificacion;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Clasificacion modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_clasificacion',v_parametros.id_clasificacion::varchar);
              
            --Devuelve la respuesta
            return v_resp;
           
        end;

    /*********************************   
     #TRANSACCION:  'SAL_CLA_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:            Gonzalo Sarmiento   
     #FECHA:            25-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_CLA_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from alm.tclasificacion
            where id_clasificacion=v_parametros.id_clasificacion;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Clasificacion eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_clasificacion',v_parametros.id_clasificacion::varchar);
             
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
-- Definition for function ft_clasificacion_sel (OID = 688797) :
--
