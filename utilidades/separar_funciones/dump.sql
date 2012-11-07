CREATE FUNCTION alm.ft_almacen_ime (
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
CREATE FUNCTION alm.ft_almacen_sel (
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
 FUNCION:        alm.ft_almacen_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.talmacen'
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

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
              
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************  
     #TRANSACCION:  'SAL_ALM_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    if(p_transaccion='SAL_ALM_SEL')then
                   
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        al.id_almacen,
                        al.codigo,
                        al.nombre,
                        al.localizacion                      
                        from alm.talmacen al
                        where ';
          
            --Definicion de la respuesta--
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
           
            --Devuelve la respuesta--
            return v_consulta;
           
                      
        end;

    /*********************************  
     #TRANSACCION:  'SAL_ALM_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        21-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros--
            v_consulta:='select count(al.id_almacen)
                        from alm.talmacen al
                        where ';
          
            --Definicion de la respuesta--          
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
                  
    else
                       
        raise exception 'Transaccion inexistente';
                           
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
-- Definition for function ft_clasificacion_ime (OID = 688784) :
--
CREATE FUNCTION alm.ft_clasificacion_ime (
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
CREATE FUNCTION alm.ft_clasificacion_sel (
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
 FUNCION:         alm.ft_clasificacion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tclasificacion'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            24-09-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
    v_where varchar;
    v_join varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_clasificacion_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'ALM_CLA_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            24-09-2012
    ***********************************/

    if(p_transaccion='ALM_CLA_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        cla.id_clasificacion,
                        cla.nombre,
                        cla.codigo_largo
                        from alm.tclasificacion cla
                        where  ';
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                       
        end;
       
     /*********************************   
     #TRANSACCION:  'ALM_CLA_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            24-09-2012
    ***********************************/

    elseif(p_transaccion='ALM_CLA_ARB_SEL')then
                    
        begin
       
              if(v_parametros.id_padre = '%') then
                v_where := ' cla.id_clasificacion_fk is NULL';   
                     
              else
                v_where := ' cla.id_clasificacion_fk = '||v_parametros.id_padre;
              end if;
       
       
            --Sentencia de la consulta
            v_consulta:='select
                        cla.id_clasificacion,
                        cla.id_clasificacion_fk,
                        cla.codigo,
                        cla.nombre,
                        cla.descripcion,
                         case
                          when (cla.id_clasificacion_fk is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo
                        from alm.tclasificacion cla
                        where  '||v_where|| ' 
                        ORDER BY cla.id_clasificacion';
            raise notice '%',v_consulta;
           
            --Devuelve la respuesta
            return v_consulta;
                       
        end;  

    /*********************************   
     #TRANSACCION:  'ALM_CLA_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            24-09-2012
    ***********************************/

    elsif(p_transaccion='ALM_CLA_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_clasificacion)
                        from alm.tclasificacion cla
                        where ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
                   
    else
                        
        raise exception 'Transaccion inexistente';
                            
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
-- Definition for function ft_item_ime (OID = 688806) :
--
CREATE FUNCTION alm.ft_item_ime (
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
CREATE FUNCTION alm.ft_item_sel (
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
 FUNCION:        alm.ft_item_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.titem'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            20-09-2012
 COMENTARIOS:  
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:  
 AUTOR:          
 FECHA:      
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
              
BEGIN

    v_nombre_funcion = 'alm.ft_item_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        20-09-2012
    ***********************************/

    if(p_transaccion='SAL_ITEM_SEL')then
                   
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        item.id_item,
                        item.id_clasificacion,
                        cla.nombre as desc_clasificacion,
                        cla.codigo_largo,
                        item.nombre,
                        item.descripcion,
                        item.palabras_clave,
                        item.codigo_fabrica,
                        item.observaciones,
                        item.numero_serie                      
                        from alm.titem item, alm.tclasificacion cla
                        where item.id_clasificacion = cla.id_clasificacion and ';
          
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
           
            --Devuelve la respuesta
            return v_consulta;
           
                      
        end;

    /*********************************  
     #TRANSACCION:  'SAL_ITEM_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(item.id_item)
                        from alm.titem item
                        where ';
          
            --Definicion de la respuesta          
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
                  
    else
                       
        raise exception 'Transaccion inexistente';
                           
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
-- Definition for function ft_almacen_stock_sel (OID = 711099) :
--
CREATE FUNCTION alm.ft_almacen_stock_sel (
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
 FUNCION:         alm.ft_almacen_stock_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            01-10-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_item_sel';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        01-10-2012
    ***********************************/

    if(p_transaccion='SAL_ALMITEM_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        almitem.id_almacen_stock,
                        almitem.estado_reg,
                        almitem.id_almacen,
                        almitem.id_item,
                        item.nombre as desc_item,
                        almitem.cantidad_min,
                        almitem.cantidad_alerta_amarilla,
                        almitem.cantidad_alerta_roja,
                        almitem.id_usuario_reg,
                        almitem.fecha_reg,
                        almitem.id_usuario_mod,
                        almitem.fecha_mod
                        from alm.talmacen_stock almitem, alm.titem item
                        where almitem.id_item = item.id_item and ';
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
           
            if (public.f_existe_parametro(p_tabla,'id_almacen')) then        
                v_consulta:= v_consulta || ' and almitem.id_almacen='||v_parametros.id_almacen;
            end if;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                       
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(almitem.id_almacen_stock)
                        from alm.talmacen_stock almitem, alm.titem item
                        where almitem.id_item = item.id_item and  ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;
            if (public.f_existe_parametro(p_tabla,'id_almacen')) then        
                v_consulta:= v_consulta || ' and almitem.id_almacen='||v_parametros.id_almacen;
            end if;
            --Devuelve la respuesta
            return v_consulta;

        end;
                   
    else
                        
        raise exception 'Transaccion inexistente';
                            
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
-- Definition for function ft_almacen_stock_ime (OID = 712319) :
--
CREATE FUNCTION alm.ft_almacen_stock_ime (
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
 FUNCION:         alm.ft_almacen_stock_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen_stock'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            01-10-2012
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
    v_id_almacen_stock    integer;
               
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_stock_ime';
    v_parametros = f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        Gonzalo Sarmiento 
     #FECHA:        01-10-2012
    ***********************************/

    if(p_transaccion='SAL_ALMITEM_INS')then
                   
        begin
            --Sentencia de la insercion
            insert into alm.talmacen_stock(
            estado_reg,
            id_almacen,
            id_item,
            id_usuario_reg,
            fecha_reg,
            id_usuario_mod,
            fecha_mod    ,
            cantidad_min,
            cantidad_alerta_amarilla,
            cantidad_alerta_roja
              ) values(
            'activo',
            v_parametros.id_almacen,
            v_parametros.id_item,
            p_id_usuario,
            now(),
            null,
            null ,
            v_parametros.cantidad_min,
            v_parametros.cantidad_alerta_amarilla,
            v_parametros.cantidad_alerta_roja
            )RETURNING id_almacen_stock into v_id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen almacenado(a) con exito (id_almacen_stock'||v_id_almacen_stock||')');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_id_almacen_stock::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_MOD')then

        begin
            --Sentencia de la modificacion
            update alm.talmacen_stock set
            id_almacen = v_parametros.id_almacen,
            id_item = v_parametros.id_item,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now() ,
            cantidad_min=v_parametros.cantidad_min,
            cantidad_alerta_amarilla=v_parametros.cantidad_alerta_amarilla,
            cantidad_alerta_roja=v_parametros.cantidad_alerta_roja
            where id_almacen_stock=v_parametros.id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen modificado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_parametros.id_almacen_stock::varchar);
              
            --Devuelve la respuesta
            return v_resp;
           
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ALMITEM_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        01-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_ALMITEM_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from alm.talmacen_stock
            where id_almacen_stock=v_parametros.id_almacen_stock;
              
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Item por Almacen eliminado(a)');
            v_resp = f_agrega_clave(v_resp,'id_almacen_stock',v_parametros.id_almacen_stock::varchar);
             
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
-- Definition for function ft_movimiento_det_sel (OID = 722844) :
--
CREATE FUNCTION alm.ft_movimiento_det_sel (
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
 FUNCION:        alm.ft_movimiento_det_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion    text;
  v_parametros         record;
  v_consulta         varchar;
  v_respuesta         varchar;
BEGIN
  v_nombre_funcion = 'alm.ft_movimiento_det_sel';
  v_parametros = f_get_record(p_tabla);
 
  /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        02-10-2012
    ***********************************/
   
  if(p_transaccion='SAL_MOV_DET_SEL') then
      begin
    ---sentencia de la consulta----
     v_consulta:='select
                     movdet.id_movimiento_det,
                    movdet.id_movimiento,
                    movdet.id_item,                   
                    item.nombre as desc_item,
                    movdet.cantidad,
                    movdet.costo_unitario,
                    movdet.fecha_caducidad,
                    movdet.id_usuario_reg,
                    movdet.fecha_reg,
                    movdet.id_usuario_mod,
                    movdet.fecha_mod
                    from alm.tmovimiento_det movdet,alm.titem item
                    where movdet.id_item = item.id_item and ';         
    -----DEFINICION DE LA RESPUESTA-----
     v_consulta:=v_consulta||v_parametros.filtro;
           
            if (public.f_existe_parametro(p_tabla,'id_movimiento')) then        
                v_consulta:= v_consulta || ' and movdet.id_movimiento='||v_parametros.id_movimiento;
            end if;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

       
            raise notice '%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;
    end;
      /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_CONT'
     #DESCRIPCION:   Conteo de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/

    elsif(p_transaccion='SAL_MOV_DET_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(movdet.id_movimiento_det)
                        from alm.tmovimiento_det movdet, alm.tmovimiento mov
                        where movdet.id_movimiento = mov.id_movimiento and  ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;
            if (public.f_existe_parametro(p_tabla,'id_movimiento')) then        
                v_consulta:= v_consulta || ' and movdet.id_movimiento='||v_parametros.id_movimiento;
            end if;
            --Devuelve la respuesta
            return v_consulta;

        end;
                   
    else
                        
        raise exception 'Transaccion inexistente';
                            
    end if;
 
EXCEPTION
    WHEN OTHERS THEN
            v_respuesta='';
            v_respuesta = f_agrega_clave(v_resp,'mensaje',SQLERRM);
            v_respuesta = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
            v_respuesta = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
            raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_movimiento_det_ime (OID = 725600) :
--
CREATE FUNCTION alm.ft_movimiento_det_ime (
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
 FUNCION:         alm.ft_movimiento_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_det'
 AUTOR:         Gonzalo Sarmiento
 FECHA:            02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion         varchar;
  v_consulta            varchar;
  v_parametros          record;
  v_respuesta             varchar;
  v_id_movimiento_det    integer;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_det_ime';
  v_parametros=f_get_record(p_tabla);
  /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Gonzalo Sarmiento 
     #FECHA:        02-10-2012
    ***********************************/
    if(p_transaccion='SAL_MOV_DET_INS') then
        begin
            insert into alm.tmovimiento_det(
                id_usuario_reg,
                fecha_reg,
                estado_reg,               
                id_movimiento,
                id_item,
                cantidad,
                costo_unitario,
                fecha_caducidad)
                VALUES(
                p_id_usuario,
                now(),
                'activo',
                v_parametros.id_movimiento,
                v_parametros.id_item,
                v_parametros.cant,
                v_parametros.costo_unitario,
                v_parametros.fecha_caducidad)
                RETURNING id_movimiento_det into v_id_movimiento_det;
                 
                v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento almacenado(a) con exito (id_movimiento_det'||v_id_movimiento_det||')');
                v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento_det',v_id_movimiento_det::varchar);

                return v_respuesta;
        end;
    /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/
    elseif(p_transaccion='SAL_MOV_DET_MOD')then
        begin
            update alm.tmovimiento_det set
            id_usuario_mod=p_id_usuario,
            fecha_mod=now(),
            id_movimiento=v_parametros.id_movimiento,
            id_item=v_parametros.id_item,
            cantidad=v_parametros.cant,
            costo_unitario=v_parametros.costo_unitario,
            fecha_caducidad=v_parametros.fecha_caducidad
            where id_movimiento_det=v_parametros.id_movimiento_det;
           
            v_respuesta = f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento modificado con exito');
            v_respuesta = f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
           
            return v_respuesta;
        end;
    /*********************************   
     #TRANSACCION:  'SAL_MOV_DET_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        02-10-2012
    ***********************************/
    elseif(p_transaccion='SAL_MOV_DET_ELI')then
        begin
            RAISE NOTICE 'llega gonzalo';
            delete from alm.tmovimiento_det
            where id_movimiento_det=v_parametros.id_movimiento_det;
           
            v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento eliminado correctamente');
            v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
          
            return v_respuesta;
        end;
    else
        raise exception 'Transaccion inexistente';
    end if;
EXCEPTION

    WHEN OTHERS THEN
        v_respuesta='';
        v_respuesta=f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta=f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta=f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_movimiento_sel (OID = 728848) :
--
CREATE FUNCTION alm.ft_movimiento_sel (
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
 FUNCION:        alm.ft_movimiento_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:  
***************************************************************************/

DECLARE
  v_nombre_funcion    varchar;
  v_consulta         varchar;
  v_parametros         record;
  v_respuesta        varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_sel';
  v_parametros=f_get_record(p_tabla);
 
  /*********************************  
     #TRANSACCION:  'SAL_MOV_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        02-12-2012
    ***********************************/
 
  if(p_transaccion='SAL_MOV_SEL')then
      begin
        v_consulta:='select
            mov.id_movimiento,
            mov.id_movimiento_tipo,
            mov.id_almacen,
            almo.nombre as nombre_origen,
            mov.id_funcionario,
            mov.id_proveedor,
            mov.id_almacen_dest,
            almd.nombre as nombre_destino,
            mov.fecha_mov,
            mov.numero_mov,
            mov.descripcion,
            mov.observaciones,
            mov.id_usuario_reg,
            mov.fecha_reg,
            mov.id_usuario_mod,
            mov.fecha_mod,
            mov.estado_mov
            from alm.tmovimiento_tipo movtipo
            INNER JOIN alm.tmovimiento mov on mov.id_movimiento_tipo = movtipo.id_movimiento_tipo
            INNER JOIN alm.talmacen almo on almo.id_almacen= mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen= mov.id_almacen_dest
            where movtipo.codigo='''||v_parametros.codigo||''' and ';
        v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;           
        return v_consulta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        24-09-2012
    ***********************************/
  elsif(p_transaccion='SAL_MOV_CONT')then
    begin
        v_consulta:='select count(mov.id_movimiento)
                    from alm.tmovimiento mov,alm.tmovimiento_tipo movtipo
                    where movtipo.codigo= ''||v_parametros.codigo||'' and
                          movtipo.id_movimiento_tipo=mov.id_movimiento_tipo and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;
  end if;
EXCEPTION
  WHEN OTHERS THEN
    v_respuesta='';
    v_respuesta=f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
    v_respuesta=f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
    v_respuesta=f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
    raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_movimiento_ime (OID = 738894) :
--
CREATE FUNCTION alm.ft_movimiento_ime (
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
 FUNCION:        alm.ft_movimiento_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          03-10-2012
 COMENTARIOS:  
************************************************************************/
DECLARE
  v_nombre_funcion                 varchar; 
  v_parametros                    record;
  v_id_movimiento_tipo            integer;
  v_id_movimiento                integer;
  v_id_movimiento_tipo_ingreso    integer;
  v_id_movimiento_tipo_salida    integer;
  v_respuesta                    varchar;
  v_id_movimiento_ingreso        integer;
  v_id_movimiento_salida        integer;
  v_transferencia                record;
  v_consulta                    varchar;
  v_detalle                        record;

BEGIN
  v_nombre_funcion='alm.ft_movimiento_ime';
  v_parametros=f_get_record(p_tabla);
 
 
  /*********************************  
     #TRANSACCION:  'SAL_MOV_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/
  if(p_transaccion='SAL_MOV_INS')then
      begin       
        v_id_movimiento_tipo=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo=v_parametros.codigo);       

        insert into alm.tmovimiento
                      (id_movimiento_tipo, id_almacen,
                     id_funcionario, id_proveedor,
                     id_almacen_dest, fecha_mov,
                     numero_mov, descripcion,
                     observaciones, id_usuario_reg,
                     fecha_reg, estado_reg, estado_mov)
                     values(v_id_movimiento_tipo,v_parametros.id_almacen,
                     v_parametros.id_funcionario, v_parametros.id_proveedor,
                     v_parametros.id_almacen_dest,v_parametros.fecha_mov,
                     v_parametros.numero_mov, v_parametros.descripcion,
                     v_parametros.observaciones, p_id_usuario,
                     now(),'activo', 'borrador')
                     RETURNING id_movimiento into v_id_movimiento;

        v_respuesta =f_agrega_clave(v_respuesta,'mensaje','Movimiento almacenado correctamente');
        v_respuesta =f_agrega_clave(v_respuesta,'id_movimiento',v_id_movimiento::varchar);

        return v_respuesta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/         
               
  elseif(p_transaccion='SAL_MOV_MOD')then
      begin
        update alm.tmovimiento set                    
                     id_almacen=v_parametros.id_almacen,
                     id_funcionario=v_parametros.id_funcionario,
                     id_proveedor=v_parametros.id_proveedor,
                     id_almacen_dest=v_parametros.id_almacen_dest,
                     fecha_mov=v_parametros.fecha_mov,
                     numero_mov=v_parametros.numero_mov,
                     descripcion=v_parametros.descripcion,
                     observaciones=v_parametros.observaciones,
                     id_usuario_mod=p_id_usuario,
                     fecha_mod=now()
        where id_movimiento = v_parametros.id_movimiento;
       
        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento modificado con exito');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;
    end;
  /*********************************  
     #TRANSACCION:  'SAL_MOV_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Gonzalo Sarmiento  
     #FECHA:        03-10-2012
    ***********************************/
  elseif(p_transaccion='SAL_MOV_ELI')then
      begin
        delete from alm.tmovimiento
        where id_movimiento=v_parametros.id_movimiento;

        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento eliminado');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);

        return v_respuesta;
    end;
  elseif(p_transaccion='SAL_MOV_FIN')then
      begin

        update alm.tmovimiento set
        estado_mov='finalizado'
        where id_movimiento=v_parametros.id_movimiento;
       
        if(v_parametros.operacion='finalizarTransferencia')then
            begin
                select * into v_transferencia from alm.tmovimiento where id_movimiento=v_parametros.id_movimiento;
                v_id_movimiento_tipo_ingreso=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo='ING');                       
               
                v_id_movimiento_tipo_salida=(select id_movimiento_tipo from alm.tmovimiento_tipo
                          where codigo='SAL');
               
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_ingreso,
                v_transferencia.id_almacen_dest,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
                now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_ingreso;
               
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_salida,
                v_transferencia.id_almacen,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
                now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_salida;
               
                v_consulta='select * from alm.tmovimiento_det where id_movimiento='||v_parametros.id_movimiento||'';
                FOR v_detalle IN EXECUTE(v_consulta)
                LOOP    
                    insert into alm.tmovimiento_det(
                    id_movimiento,id_item,cantidad, costo_unitario,fecha_caducidad,
                    id_usuario_reg,fecha_reg,estado_reg)values
                    (v_id_movimiento_ingreso, v_detalle.id_item,v_detalle.cantidad,
                    v_detalle.costo_unitario, v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg,now(),'activo');
                   
                    insert into alm.tmovimiento_det(
                    id_movimiento,id_item, cantidad, costo_unitario,
                    fecha_caducidad, id_usuario_reg, fecha_reg, estado_reg)
                    values(
                    v_id_movimiento_salida, v_detalle.id_item, v_detalle.cantidad,
                    v_detalle.costo_unitario,v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg, now(),'activo');                             
                   END LOOP;
            end;
        end if;
        v_respuesta=f_agrega_clave(v_respuesta,'mensaje','Movimiento finalizado');
        v_respuesta=f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;   
    end;
  else
       raise exception 'Transaccion inexistente: %',p_transaccion;
  end if;
EXCEPTION
  WHEN OTHERS THEN
        v_respuesta='';
        v_respuesta = f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta = f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta = f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
    LANGUAGE plpgsql;