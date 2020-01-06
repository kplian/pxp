/****************************I-SCP-JRR-PXP-1-19/11/2012*************/ 

CREATE EXTENSION IF NOT EXISTS dblink;
--
-- Definition for type enum_tipo_dato (OID = 303809) : 
--
SET search_path = pxp, pg_catalog;
CREATE TYPE pxp.enum_tipo_dato AS ENUM
  ( 'varchar', 'integer', 'float', 'numeric', 'boolean', 'text' );
--
-- Definition for type estado_reg (OID = 303822) : 
--
CREATE TYPE pxp.estado_reg AS ENUM
  ( 'activo', 'inactivo' );
  
--
-- Structure for table tbase (OID = 305288) : 
--
CREATE TABLE pxp.tbase (
    id_usuario_reg integer,
    id_usuario_mod integer,
    fecha_reg timestamp without time zone DEFAULT now(),
    fecha_mod timestamp without time zone DEFAULT now(),
    estado_reg varchar(10) DEFAULT 'activo'::character varying
) WITHOUT OIDS;
--
-- Definition for sequence parametro (OID = 306490) : 
--
CREATE SEQUENCE pxp.parametro
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table variable_global (OID = 306540) : 
--
CREATE TABLE pxp.variable_global (
    id_variable_global serial NOT NULL,
    variable varchar NOT NULL,
    valor varchar(200) NOT NULL,
    descripcion varchar
) WITH OIDS;
ALTER TABLE ONLY pxp.variable_global ALTER COLUMN id_variable_global SET STATISTICS 0;
ALTER TABLE ONLY pxp.variable_global ALTER COLUMN valor SET STATISTICS 0;



--
-- Definition for index variable_global_pkey (OID = 308030) : 
--
ALTER TABLE ONLY variable_global
    ADD CONSTRAINT variable_global_pkey
    PRIMARY KEY (id_variable_global);
--
-- Definition for index variable_global_variable_key (OID = 308032) : 
--
ALTER TABLE ONLY variable_global
    ADD CONSTRAINT variable_global_variable_key
    UNIQUE (variable);
--
-- Definition for index fk_tbase__id_usuario_mod (OID = 308938) : 
--

/****************************F-SCP-JRR-PXP-1-19/11/2012*************/ 


/****************************I-SCP-RAC-PXP-0-23/01/2013*************/
--------------- SQL ---------------
CREATE TABLE pxp.tforenkey (
  id_forenkey SERIAL NOT NULL, 
  tabla VARCHAR(50) NOT NULL, 
  llave VARCHAR(80) NOT NULL, 
  obs TEXT, 
  CONSTRAINT t_forenkeys_pkey PRIMARY KEY(id_forenkey), 
  CONSTRAINT tforenkey_idx UNIQUE(tabla, llave)
) WITHOUT OIDS;

/****************************F-SCP-RAC-PXP-0-23/01/2013*************/

/****************************I-SCP-GSS-PXP-0-04/07/2013*************/

CREATE EXTENSION IF NOT EXISTS hstore;

/****************************F-SCP-GSS-PXP-0-04/07/2013*************/



/****************************I-SCP-RAC-PXP-0-19/05/2014*************/

ALTER TABLE pxp.tbase
  ADD COLUMN id_usuario_ai INTEGER;

/****************************F-SCP-RAC-PXP-0-19/05/2014*************/

/****************************I-SCP-RAC-PXP-0-21/05/2014*************/

--------------- SQL ---------------

ALTER TABLE pxp.tbase
  ADD COLUMN usuario_ai VARCHAR(300);
  
/****************************F-SCP-RAC-PXP-0-21/05/2014*************/

/****************************I-SCP-JRR-PXP-0-21/11/2014*************/

CREATE TABLE pxp.tprueba1 (
    campo1 varchar
) WITHOUT OIDS;

/****************************F-SCP-JRR-PXP-0-21/11/2014*************/
/****************************I-SCP-EGS-PXP-0-06/01/2020*************/

ALTER TABLE pxp.tbase
ADD COLUMN obs_dba VARCHAR;

COMMENT ON COLUMN pxp.tbase.obs_dba
IS 'observaciones de modificaciones del registro en la base de datos';

/****************************F-SCP-EGS-PXP-0-06/01/2020*************/

