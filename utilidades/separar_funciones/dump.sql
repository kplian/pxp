CREATE FUNCTION gen.f_obtener_datos_tabla_sel (
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS SETOF record
AS 
$body$
/*
Autor: RCM
Fecha: 19/11/201
Descripción: Función que devuelve los datos de las columnas y de la tabla para el generador
*/

DECLARE

	v_consulta    		varchar;
	v_rec  				record;
	v_nombre_funcion   	text;
    v_resp				varchar;
    v_sql				varchar;

BEGIN

    v_nombre_funcion:='gen.f_obtener_datos_tabla_sel';

    if p_transaccion = 'GEN_COLUMN_SEL' then

    	begin
        	--1. Creación de la tabla temporal para almacenar todos los datos de la columna
            v_sql = 'create temp table tt_tabla_metadatos(id integer,
             												columna varchar,
                                                            descripcion varchar,
                                                            tipo_dato varchar,
                                                            longitud text,
                                                            nulo varchar,
                                                            checks varchar,
                                                            valor_defecto varchar,
                                                            grid_ancho integer,
                                                            grid_mostrar varchar,
                                                            form_ancho_porcen integer,
                                                            orden smallint,
                                                            grupo smallint

            ) on commit drop;';
            
            execute(v_sql);
            
            v_sql = 'create temp table tt_constraints(id integer,
            											nombre varchar
            ) on commit drop';
            execute(v_sql);
                        
            --2. Obtención de las columnas y sus metadatos
            v_sql = 'insert into tt_tabla_metadatos(
            		columna, descripcion, tipo_dato, checks, nulo, longitud,
                    valor_defecto, grid_ancho, grid_mostrar, form_ancho_porcen,
                    orden, grupo
            		)
                    SELECT DISTINCT
                    a.attname as column_name,
                    pg_catalog.obj_description(c.oid) as descripcion,
                    t.typname as tipo_dato,
                    CASE
                    WHEN cc.contype=''p'' THEN ''PK''
                    WHEN cc.contype=''u'' THEN ''UQ''
                    WHEN cc.contype=''f'' THEN ''FK''
                    ELSE '''' END AS cheks,
                    CASE WHEN a.attnotnull=false THEN ''si'' ELSE ''no'' END AS  nulo,
                    CASE WHEN a.attlen=''-1'' THEN (a.atttypmod - 4) ELSE a.attlen END as  longitud,
                    d.adsrc as valor_defecto,
                    100, ''si'', 80, null::smallint, 1::smallint
                    FROM pg_catalog.pg_attribute a
                    LEFT JOIN pg_catalog.pg_type t ON t.oid = a.atttypid
                    LEFT JOIN pg_catalog.pg_class c ON c.oid = a.attrelid
                    LEFT JOIN pg_catalog.pg_constraint cc ON cc.conrelid = c.oid AND cc.conkey[1] = a.attnum
                    LEFT JOIN pg_catalog.pg_attrdef d ON d.adrelid = c.oid AND a.attnum = d.adnum
                    WHERE c.relname = ''' || p_tabla || '''
                    AND a.attnum > 0
                    AND t.oid = a.atttypid
                    AND NOT a.attisdropped';

            --raise exception '%',v_sql;
            execute(v_sql);
            
            --5. Consulta de la tabla resultado
            for v_rec in execute('select distinct columna, descripcion, tipo_dato,
            					longitud, nulo, checks, valor_defecto,
                                grid_ancho, grid_mostrar, form_ancho_porcen,
                                orden, grupo
                                from tt_tabla_metadatos') loop
            	return next v_rec;
            end loop;
            
            --6. Respuesta
            return;
 
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
--
-- Definition for function ft_columna_ime (OID = 303919) : 
--
CREATE FUNCTION gen.ft_columna_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
DECLARE

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_columna			integer;


/*

 id_proyecto
 denominacion 
 descripcion
 estado_reg 

*/

BEGIN

     v_nombre_funcion:='gen.ft_columna_ime';
     v_parametros:=pxp.f_get_record(p_tabla);

     if(p_transaccion='GEN_COLUMN_INS')then

          BEGIN
               
               insert into gen.tcolumna(
		 		nombre,
                 descripcion,
                 id_tabla,
                 id_usuario_reg,
                 id_usuario_mod,
                 fecha_reg,
                 fecha_mod,
                 estado_reg,
                 etiqueta,
                 guardar
               ) values(
                v_parametros.nombre,
                v_parametros.descripcion,
                v_parametros.id_tabla,
                v_parametros.id_usuario_reg,
                NULL,
                now(),
                NULL,
                'activo',
                v_parametros.etiqueta,
                v_parametros.guardar
               )RETURNING id_columna into v_id_columna;
               
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna almacenada con exito (id_columna'||v_id_columna||')'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_id_columna::varchar);

               return v_resp;

         END;

     elsif(p_transaccion='GEN_COLUMN_MOD')then

          BEGIN

               update gen.tcolumna set
               nombre=v_parametros.nombre,
               descripcion=v_parametros.descripcion,
               id_tabla=v_parametros.id_tabla,
               id_usuario_mod=v_parametros.id_usuario_mod,
               fecha_mod=now(),
               etiqueta=v_parametros.etiqueta,
               guardar=v_parametros.guardar,
               longitud=v_parametros.longitud,
               grid_ancho=v_parametros.grid_ancho,
               grid_mostrar=v_parametros.grid_mostrar,
               form_ancho_porcen=v_parametros.form_ancho_porcen,
               orden=v_parametros.orden,
               grupo=v_parametros.grupo
               where id_columna=v_parametros.id_columna;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna modificada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
               
               return v_resp;
          END;

    elsif(p_transaccion='GEN_COLUMN_ELI')then

          BEGIN

               delete from gen.tcolumna
               where id_columna=v_parametros.id_columna;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Columna eliminada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
              
               return v_resp;
         END;
         
     else
     
         raise exception 'Transacción inexistente: %',p_transaccion;

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
--
-- Definition for function ft_columna_sel (OID = 303920) : 
--
CREATE FUNCTION gen.ft_columna_sel (
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
    v_nombre_funcion:='gen.ft_columna_sel';

    if p_transaccion = 'GEN_COLUMN_SEL' then

    	begin
        	v_consulta:='select
            			id_columna, nombre, descripcion,
            			id_tabla, id_usuario_reg, id_usuario_mod, fecha_reg,
            			fecha_mod, estado_reg, etiqueta,guardar,
                        tipo_dato, longitud, nulo, checks, valor_defecto,
                        grid_ancho, grid_mostrar, form_ancho_porcen, orden,
                        grupo
            			from gen.tcolumna
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice '%',v_consulta;
            return v_consulta;
		end;

    elsif p_transaccion = 'GEN_COLUMN_CONT' then

        begin
        	v_consulta:='select count(id_columna)
            			from gen.tcolumna
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
        end;

     elsif p_transaccion = 'GEN_DATCOL_SEL' then

    	begin
        	v_consulta:='
SELECT (col.table_schema)::character varying AS esquema,
    (col.table_name)::character varying AS tabla, (col.column_name)::character
    varying AS columna, (col.ordinal_position)::integer AS posicion,
    (col.column_default)::character varying AS defecto,
    (col.is_nullable)::character varying AS blanco, (col.data_type)::character
    varying AS tipo, CASE WHEN ((col.data_type)::text =
    ''character varying''::text) THEN (col.character_maximum_length)::integer
    WHEN ((col.data_type)::text = ''numeric''::text) THEN
    (col.numeric_precision)::integer ELSE 0 END AS length, CASE WHEN
    ((col.data_type)::text = ''numeric''::text) THEN (col.numeric_scale)::integer
    ELSE 0 END AS "precision", (cons.conname)::character varying AS
    nombre_constraint, (cons.consrc)::character varying AS definicion_constraint,
    col1.guardar,col1.etiqueta
FROM information_schema.columns col
INNER JOIN gen.tcolumna col1
    on(col1.nombre=col.column_name)
LEFT JOIN information_schema.constraint_column_usage colcon ON
    col.table_schema::text = colcon.table_schema::text AND
    col.table_name::text = colcon.table_name::text AND
    col.column_name::text = colcon.column_name::text
LEFT JOIN pg_constraint cons ON
    cons.conname = colcon.constraint_name::name AND
    cons.contype = ''c''::"char"
LEFT JOIN pg_class c ON
cons.conrelid =c.oid AND c.relname = col.table_name::name
WHERE '; --col.table_schema::text = 'rhum'::text AND
    --col.table_name::text = 'tcolumna'::text AND id_tabla=21;
      
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            return v_consulta;
		end;

     elsif p_transaccion = 'GEN_DATCOL_CONT' then

        begin
        	v_consulta:='select count(col1.relname)
            		from gen.vcolumna col1
			left join gen.tcolumna col2
			on col2.nombre = col1.relname
                        where ';
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
--
-- Definition for function ft_esquema_sel (OID = 303921) : 
--
CREATE FUNCTION gen.ft_esquema_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_esquema_sel
 DESCRIPCION:   lista las interfaces en el generador
 AUTOR: 	jrr	
 FECHA:	        25/01/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/


DECLARE


v_consulta   		varchar;
v_parametros  		record;
v_nombre_funcion  	text;
v_mensaje_error    	text;
v_resp              varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_esquema_sel';
     
/*******************************    
 #TRANSACCION:  GEN_ESQUEM_SEL
 #DESCRIPCION:	Listado de esquemas en los metadatos para el combo del generador
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		25/01/11	
***********************************/

     if(par_transaccion='GEN_ESQUEM_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT n.oid::integer,
                                n.nspname::varchar AS name,
                                u.usename::varchar
                            FROM pg_namespace n
                            LEFT OUTER JOIN pg_user u ON n.nspowner = u.usesysid
                            LEFT OUTER JOIN pg_description ds ON n.oid = ds.objoid
                            where n.nspname not like ''pg_%'' and
                                n.nspname not like ''information_schema'' and ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by n.nspname limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  GEN_ESQUEM_CONT
 #DESCRIPCION:	Listado de esquemas en los metadatos para el combo del generador
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		25/01/11	
***********************************/
     elsif(par_transaccion='GEN_ESQUEM_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(n.oid)
                            FROM pg_namespace n
                            LEFT OUTER JOIN pg_user u ON n.nspowner = u.usesysid
                            LEFT OUTER JOIN pg_description ds ON n.oid = ds.objoid
                            where n.nspname not like ''pg_%'' and
                                n.nspname not like ''information_schema'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
     else
         raise exception 'No existe la opcion';

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
--
-- Definition for function ft_tabla_ime (OID = 303922) : 
--
CREATE FUNCTION gen.ft_tabla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
DECLARE

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_tabla			integer;
    v_registros         record;
    v_tabla_antigua     varchar;
    v_esquema           varchar;


/*

 id_proyecto
 denominacion 
 descripcion
 estado_reg 

*/

BEGIN

     v_nombre_funcion:='gen.ft_tabla_ime';
     v_parametros:=pxp.f_get_record(p_tabla);

     if(p_transaccion='GEN_TABLA_INS')then

          BEGIN
                select lower(s.codigo)
                into v_esquema
                from segu.tsubsistema s
                where id_subsistema=v_parametros.id_subsistema;
                
               insert into gen.ttabla(
		          esquema,
		          nombre,
                 titulo,
                 id_subsistema,
                 id_usuario_reg,
                 id_usuario_mod,
                 fecha_reg,
                 fecha_mod,
                 estado_reg,
                 alias,
                 --reemplazar,
                 --menu,
                 direccion,
                 cant_grupos
               ) values(
                v_esquema,
                v_parametros.nombre,
                v_parametros.titulo,
                v_parametros.id_subsistema,
                p_id_usuario,
                NULL,
                now(),
                NULL,
                'activo',
                v_parametros.alias,
                --v_parametros.reemplazar,
                --v_parametros.menu,
                v_parametros.direccion,
                v_parametros.cant_grupos
               )RETURNING id_tabla into v_id_tabla;
                --raise exception 'llega%',v_parametros.nombre;
              
          		--Registro de las colummas de la tabla
                insert into gen.tcolumna(
                id_usuario_reg,
                 estado_reg, 
                 nombre, 
                 descripcion,  
                 tipo_dato, 
                 longitud, 
                 nulo,
                id_tabla, 
                etiqueta, 
                guardar, checks, valor_defecto, grid_ancho, grid_mostrar,
                form_ancho_porcen, orden, grupo
                )
                select
                p_id_usuario, 'activo', columna, descripcion, tipo_dato, longitud, nulo,
                v_id_tabla, columna, 'si', checks, valor_defecto,grid_ancho, grid_mostrar,
                form_ancho_porcen, orden, grupo
                from gen.f_obtener_datos_tabla_sel(p_id_usuario,v_parametros.nombre,'GEN_COLUMN_SEL') as (
                columna varchar,descripcion varchar,tipo_dato varchar,longitud text,
                nulo varchar,checks varchar, valor_defecto varchar, grid_ancho INTEGER,
                grid_mostrar varchar, form_ancho_porcen integer, orden smallint, grupo smallint);
                --
               
				v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla almacenada con exito (id_tabla'||v_id_tabla||')'); 
          		v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_id_tabla::varchar);

               return v_resp;

         END;

     elsif(p_transaccion='GEN_TABLA_MOD')then

          BEGIN

              select nombre
              into v_tabla_antigua
              from gen.ttabla
              where id_tabla=v_parametros.id_tabla;
              select lower(s.codigo)
                into v_esquema
                from segu.tsubsistema s
                where id_subsistema=v_parametros.id_subsistema;
              if(v_tabla_antigua!=v_parametros.nombre)then
                delete from gen.tcolumna
                where id_tabla=v_parametros.id_tabla;
                
                --Registro de las colummas de la tabla
                insert into gen.tcolumna(
                id_usuario_reg, estado_reg, nombre, descripcion,  tipo_dato, longitud, nulo,
                id_tabla, etiqueta, guardar
                )
                select
                p_id_usuario, 'activo', columna, descripcion, tipo_dato, longitud, nulo,
                v_parametros.id_tabla, columna, 'si'
                from gen.f_obtener_datos_tabla_sel(p_id_usuario,v_parametros.nombre,'GEN_COLUMN_SEL') as (
                id integer,columna varchar,descripcion varchar,tipo_dato varchar,longitud integer,nulo varchar,checks varchar);
                --
              
              end if;
              

               update gen.ttabla set
               esquema=v_esquema,
               nombre=v_parametros.nombre,
               titulo=v_parametros.titulo,
               id_subsistema=v_parametros.id_subsistema,
               id_usuario_mod=p_id_usuario,
               fecha_mod=now(),
               alias = v_parametros.alias,
              -- reemplazar = v_parametros.reemplazar,
              -- menu = v_parametros.menu,
               direccion=v_parametros.direccion,
               cant_grupos=v_parametros.cant_grupos
               where id_tabla=v_parametros.id_tabla;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla modificada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_parametros.id_tabla::varchar);
               
               return v_resp;
          END;

    elsif(p_transaccion='GEN_TABLA_ELI')then

          BEGIN
                delete from gen.tcolumna
               where id_tabla=v_parametros.id_tabla;
               
               delete from gen.ttabla
               where id_tabla=v_parametros.id_tabla;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla eliminada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_parametros.id_tabla::varchar);
              
               return v_resp;
         END;
         
     else
     
         raise exception 'Transacción inexistente: %',p_transaccion;

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
--
-- Definition for function ft_tabla_sel (OID = 303923) : 
--
CREATE FUNCTION gen.ft_tabla_sel (
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
