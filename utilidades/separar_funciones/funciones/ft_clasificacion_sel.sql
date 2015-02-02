CREATE OR REPLACE FUNCTION alm.ft_clasificacion_sel (
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
