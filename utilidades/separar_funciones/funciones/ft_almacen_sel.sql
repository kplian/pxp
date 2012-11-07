CREATE OR REPLACE FUNCTION alm.ft_almacen_sel (
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
