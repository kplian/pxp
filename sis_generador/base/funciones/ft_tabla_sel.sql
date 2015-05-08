CREATE OR REPLACE FUNCTION gen.ft_tabla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/*
Autor: RCM
Fecha: 30/11/2010
Descripción: Función que devuelve conjuntos de datos
*/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
    v_resp				varchar;

BEGIN

    v_parametros:=pxp.f_get_record(p_tabla);
    v_nombre_funcion:='gen.ft_tabla_sel';

    if p_transaccion = 'GEN_TABLA_SEL' then

    	begin
        	v_consulta:='select
            			tabla.id_tabla, tabla.esquema, tabla.nombre, tabla.titulo,
            			tabla.id_subsistema, tabla.id_usuario_reg, tabla.id_usuario_mod,
            			tabla.fecha_reg,tabla.fecha_mod, tabla.estado_reg,
            			subsis.nombre as desc_subsistema, subsis.prefijo, tabla.alias,
            			tabla.reemplazar, tabla.menu,tabla.direccion,subsis.nombre_carpeta,
                        (select nombre from gen.tcolumna where id_tabla = tabla.id_tabla and checks = ''PK'' LIMIT 1) as llave_primaria,
                        cant_grupos
            			from gen.ttabla tabla
            			inner join segu.tsubsistema subsis
            			on subsis.id_subsistema = tabla.id_subsistema
                        where  ';
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            return v_consulta;
		end;

    elsif p_transaccion = 'GEN_TABLA_CONT' then

        begin
        	v_consulta:='select count(id_tabla)
            			from gen.ttabla tabla
            			inner join segu.tsubsistema subsis
            			on subsis.id_subsistema = tabla.id_subsistema
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
        end;

     elsif p_transaccion = 'GEN_TABLACOM_SEL' then

        begin
        	v_consulta:='SELECT n.oid::integer as oid_esquema,
                                n.nspname::varchar AS nombre_esquema,
                                c.oid::integer as oid_tabla ,
                                c.relname::varchar as nombre

                        FROM pg_namespace n
                        INNER JOIN pg_class c ON c.relnamespace = n.oid
                        where n.nspname not like ''pg_%'' and
                            n.nspname not like ''information_schema'' and c.relkind=''r'' and ';
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by c.relname limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            return v_consulta;
        end;
     elsif p_transaccion = 'GEN_TABLACOM_CONT' then

        begin
        	v_consulta:='select count(c.oid)
            			FROM pg_namespace n
                        INNER JOIN pg_class c ON c.relnamespace = n.oid
                        where n.nspname not like ''pg_%'' and
                            n.nspname not like ''information_schema'' and c.relkind=''r'' and ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
        end;

     else
     
         raise exception 'Transaccion inexistente';
         
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
    LANGUAGE plpgsql;
