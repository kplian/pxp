/***********************************I-SCP-JRR-GEN-1-19/11/2012****************************************/
--
-- Structure for table tcolumna (OID = 305578) : 
--
CREATE TABLE gen.tcolumna (
    id_columna serial NOT NULL,
    nombre varchar(50),
    descripcion varchar(500),
    id_tabla integer NOT NULL,
    etiqueta varchar(50),
    guardar varchar(2),
    tipo_dato varchar(25),
    longitud text,
    nulo varchar(10),
    checks varchar(20),
    valor_defecto varchar(200),
    grid_ancho integer,
    grid_mostrar varchar(2),
    form_ancho_porcen integer,
    orden smallint,
    grupo smallint,
    CONSTRAINT check_tcolumna__guardar CHECK ((((guardar)::text = 'si'::text) OR ((guardar)::text = 'no'::text))),
    CONSTRAINT chk_tcolumna__grid_mostrar CHECK (((grid_mostrar)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text])))
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table ttabla (OID = 305590) : 
--
CREATE TABLE gen.ttabla (
    id_tabla serial NOT NULL,
    esquema varchar(20),
    nombre varchar(50),
    id_subsistema integer,
    alias varchar(10),
    reemplazar varchar(2),
    menu varchar(2),
    titulo varchar(150),
    direccion varchar(200),
    cant_grupos integer
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Definition for view vcolumna (OID = 305598) : 
--
CREATE VIEW gen.vcolumna AS
SELECT col.table_schema AS esquema, col.table_name AS tabla,
    col.column_name AS columna, (col.ordinal_position)::integer AS
    posicion, (col.column_default)::character varying AS defecto,
    (col.is_nullable)::character varying AS blanco,
    (col.data_type)::character varying AS tipo, CASE WHEN
    ((col.data_type)::text = 'character varying'::text) THEN
    (col.character_maximum_length)::integer WHEN ((col.data_type)::text =
    'numeric'::text) THEN (col.numeric_precision)::integer ELSE 0 END AS
    length, CASE WHEN ((col.data_type)::text = 'numeric'::text) THEN
    (col.numeric_scale)::integer ELSE 0 END AS "precision",
    (cons.conname)::character varying AS nombre_constraint,
    (cons.consrc)::character varying AS definicion_constraint
FROM (((information_schema.columns col LEFT JOIN
    information_schema.constraint_column_usage colcon ON
    (((((col.table_schema)::text = (colcon.table_schema)::text) AND
    ((col.table_name)::text = (colcon.table_name)::text)) AND
    ((col.column_name)::text = (colcon.column_name)::text)))) LEFT JOIN
    pg_constraint cons ON (((cons.conname = (colcon.constraint_name)::name)
    AND (cons.contype = 'c'::"char")))) LEFT JOIN pg_class c ON
    (((cons.conrelid = c.oid) AND (c.relname = (col.table_name)::name))))
WHERE (((col.table_schema)::text <> 'pg_catalog'::text) AND
    ((col.table_schema)::text <> 'information_schema'::text));

--
-- Definition for index uk_ttabla_esquema_nombre (OID = 308234) : 
--
CREATE UNIQUE INDEX uk_ttabla_esquema_nombre ON gen.ttabla USING btree (esquema, nombre);
--
-- Definition for index pk_tcolumna__id_columna (OID = 307826) : 
--
ALTER TABLE ONLY gen.tcolumna
    ADD CONSTRAINT pk_tcolumna__id_columna
    PRIMARY KEY (id_columna);
--
-- Definition for index pk_ttabla__id_tabla (OID = 307828) : 
--
ALTER TABLE ONLY gen.ttabla
    ADD CONSTRAINT pk_ttabla__id_tabla
    PRIMARY KEY (id_tabla);
--
-- Definition for index fk_tcolumna__id_tabla (OID = 308503) : 
--
ALTER TABLE ONLY gen.tcolumna
    ADD CONSTRAINT fk_tcolumna__id_tabla
    FOREIGN KEY (id_tabla) REFERENCES gen.ttabla(id_tabla);
--
-- Definition for index fk_ttabla__id_subsistema (OID = 308508) : 
--
ALTER TABLE ONLY gen.ttabla
    ADD CONSTRAINT fk_ttabla__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
    
    
    -----------------------------------------------------------------DATA-----------------------------------------------------------

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('GEN', 'Sistema Generador de Codigo', '2009-11-02', 'GEN', 'activo', 'generador', NULL);


select pxp.f_insert_tfuncion ('ft_tabla_sel', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_tabla_ime', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_columna_ime', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_columna_sel', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_esquema_sel', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tgui ('Columnas', 'Registro de las Columnas de las tablas', 'COL', 'no', 1, 'sis_generador/vista/columna/columna.js', 4, '', 'columna', 'GEN');
select pxp.f_insert_tgui ('Procesos', '', 'PROCGEN', 'si', 2, '', 2, '', '', 'GEN');
select pxp.f_insert_tgui ('GEN', 'Generador de Código', 'GEN', 'si', 3, '', 1, '../../../lib/imagenes/gen32x32.png', '', 'GEN');
select pxp.f_insert_tgui ('Generador', 'Registro de las tablas', 'TABLA', 'si', 1, 'sis_generador/vista/tabla/tabla.js', 3, '', 'tabla', 'GEN');
select pxp.f_insert_testructura_gui ('GEN', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PROCGEN', 'GEN');
select pxp.f_insert_testructura_gui ('TABLA', 'PROCGEN');
select pxp.f_insert_testructura_gui ('COL', 'TABLA');

/***********************************F-SCP-JRR-GEN-1-19/11/2012****************************************/
