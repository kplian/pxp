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
    CONSTRAINT pk_tcolumna__id_columna PRIMARY KEY (id_columna),
    CONSTRAINT chk_tcolumna__guardar CHECK ((((guardar)::text = 'si'::text) OR ((guardar)::text = 'no'::text))),
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
    cant_grupos integer,
    CONSTRAINT pk_ttabla__id_tabla PRIMARY KEY (id_tabla)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

CREATE UNIQUE INDEX uk_ttabla_esquema_nombre ON gen.ttabla USING btree (esquema, nombre);
/***********************************F-SCP-JRR-GEN-1-19/11/2012****************************************/


/****************************I-SCP-JRR-GEN-0-21/11/2014*************/

CREATE TABLE gen.tprueba2 (
    campo1 varchar
) WITHOUT OIDS;

/****************************F-SCP-JRR-GEN-0-21/11/2014*************/
