/***********************************I-SCP-FRH-WF-0-15/02/2013****************************************/


CREATE TABLE wf.ttipo_proceso (
  id_tipo_proceso   SERIAL NOT NULL, 
  id_tipo_estado   int4, 
  id_proceso_macro int4 NOT NULL, 
  nombre           varchar(200), 
  tabla            varchar(100), 
  columna_llave    varchar(150), 
  codigo           varchar(5),
  
  inicio VARCHAR(2) DEFAULT 'no'::character varying NOT NULL,
  CONSTRAINT uk_codigo UNIQUE(codigo),
  CONSTRAINT uk_tipo_proceso_tipo_estado UNIQUE(id_tipo_proceso,id_tipo_estado),
  PRIMARY KEY (id_tipo_proceso)) INHERITS (pxp.tbase);
  
  
CREATE TABLE wf.ttipo_estado (
  id_tipo_estado   SERIAL NOT NULL, 
  id_tipo_proceso int4, 
  codigo		  varchar(100),
  nombre_estado   varchar(150),
  inicio          varchar(2), 
  disparador      varchar(2), 
  fin          varchar(2), 
  tipo_asignacion varchar(50),
  nombre_func_list varchar(255),
  depto_asignacion varchar(50) DEFAULT 'ninguno'::character varying NOT NULL,
  nombre_depto_func_list varchar(255),
  obs             text,
  alerta VARCHAR(3) DEFAULT 'no'::character varying NOT NULL, 
  pedir_obs VARCHAR(3) DEFAULT 'no'::character varying NOT NULL, 
  PRIMARY KEY (id_tipo_estado)) INHERITS (pxp.tbase); 
  
  
CREATE TABLE wf.testructura_estado (
  id_estructura_estado  SERIAL NOT NULL, 
  id_tipo_estado_padre  int4 NOT NULL, 
  id_tipo_estado_hijo   int4 NOT NULL, 
  prioridad             int4, 
  regla                 varchar(1000), 
  PRIMARY KEY (id_estructura_estado)) INHERITS (pxp.tbase);
  
  
CREATE TABLE wf.testado_wf (
  id_estado_wf           SERIAL NOT NULL, 
  id_estado_anterior int4, 
  id_tipo_estado     int4 NOT NULL, 
  id_proceso_wf         int4 NOT NULL, 
  id_funcionario     int4, 
  fecha              timestamp, 
  id_depto           int4,
  tipo_cambio 		 VARCHAR(20) NOT NULL DEFAULT 'siguiente'::varchar,
  obs TEXT DEFAULT ''::text NOT NULL, 
   id_alarma INTEGER[], 
  PRIMARY KEY (id_estado_wf)) INHERITS (pxp.tbase);
  
  
CREATE TABLE wf.tnum_tramite (
  id_num_tramite    SERIAL NOT NULL, 
  id_proceso_macro int4 NOT NULL, 
  id_gestion       int4 NOT NULL, 
  num_siguiente    int4, 
  PRIMARY KEY (id_num_tramite)) INHERITS (pxp.tbase);
     
  
CREATE TABLE wf.tcolumna (
  id_columna       SERIAL NOT NULL, 
  id_tipo_proceso int4 NOT NULL, 
  nombre          varchar(150), 
  tipo_dato       varchar(100), 
  orden           int4, 
  PRIMARY KEY (id_columna)) INHERITS (pxp.tbase);
  
  
CREATE TABLE wf.tcolumna_valor (
  id_columna_valor  SERIAL NOT NULL, 
  id_columna       int4 NOT NULL, 
  id_proceso_wf       int4 NOT NULL, 
  valor            varchar(300), 
  PRIMARY KEY (id_columna_valor)) INHERITS (pxp.tbase);
    
  
CREATE TABLE wf.tproceso_wf (
  id_proceso_wf       SERIAL NOT NULL, 
  id_tipo_proceso int4 NOT NULL, 
  id_estado_wf_prev int4,
  nro_tramite     varchar, 
  valor_cl        int8, 
  id_persona INTEGER, 
  id_institucion INTEGER,
  fecha_ini DATE DEFAULT now() NOT NULL, 
  tipo_ini VARCHAR(30) DEFAULT 'persona'::character varying NOT NULL,    
  PRIMARY KEY (id_proceso_wf)) INHERITS (pxp.tbase);
  
  
  
  
CREATE TABLE wf.tproceso_macro (
  id_proceso_macro  SERIAL NOT NULL, 
  id_subsistema    int4, 
  codigo           varchar(10) UNIQUE, 
  nombre           varchar(200), 
  inicio           varchar(2), 
  PRIMARY KEY (id_proceso_macro)) INHERITS (pxp.tbase);
  
/*****************************F-SCP-FRH-WF-0-15/02/2013**********************************************/


/***********************************I-SCP-FRH-WF-0-18/02/2013****************************************/

CREATE TABLE wf.tfuncionario_tipo_estado (
  id_funcionario_tipo_estado  SERIAL NOT NULL, 
  id_tipo_estado             int4 NOT NULL,
  id_funcionario             int4,   
  id_depto                   int4,
  id_labores_tipo_proceso    int4,  
  PRIMARY KEY (id_funcionario_tipo_estado)) INHERITS (pxp.tbase); 
  
  CREATE TABLE wf.tlabores_tipo_proceso (
  id_labores_tipo_proceso  SERIAL NOT NULL, 
  id_tipo_proceso         int4 NOT NULL, 
  nombre                  varchar(50), 
  codigo                  varchar(15) UNIQUE, 
  descripcion             varchar(255), 
  PRIMARY KEY (id_labores_tipo_proceso)) INHERITS (pxp.tbase);

/***********************************F-SCP-FRH-WF-0-18/02/2013****************************************/

/***********************************I-SCP-RAC-WF-0-18/09/2013****************************************/

ALTER TABLE wf.tproceso_wf
  ADD COLUMN descripcion VARCHAR(250);
  
/***********************************F-SCP-RAC-WF-0-18/09/2013****************************************/



/***********************************I-SCP-RAC-WF-0-03/12/2013****************************************/

ALTER TABLE wf.ttipo_proceso
  ALTER COLUMN codigo TYPE VARCHAR(10) COLLATE pg_catalog."default";

/***********************************F-SCP-RAC-WF-0-03/12/2013****************************************/



/***********************************I-SCP-RAC-WF-0-15/01/2014****************************************/

CREATE TABLE wf.ttipo_documento(
    id_tipo_documento SERIAL NOT NULL,
    id_tipo_proceso int4 NOT NULL,
    id_proceso_macro int4 NOT NULL,
    codigo varchar(25),
    nombre varchar(255),
    descripcion text,
    action  varchar,
    tipo VARCHAR(30) DEFAULT 'escaneado'::character varying NOT NULL, 
    PRIMARY KEY (id_tipo_documento)) INHERITS (pxp.tbase);


 
CREATE TABLE wf.ttipo_documento_estado(
    id_tipo_documento_estado SERIAL NOT NULL,
    id_tipo_documento int4 NOT NULL,
    id_tipo_proceso int4 NOT NULL,
    id_tipo_estado int4 NOT NULL,
    momento varchar(255),
    PRIMARY KEY (id_tipo_documento_estado))INHERITS (pxp.tbase);


CREATE TABLE wf.tdocumento_wf(
    id_documento_wf SERIAL NOT NULL,
    id_tipo_documento serial NOT NULL,
    id_proceso_wf serial NOT NULL,
    num_tramite varchar(200),
    momento varchar(255),
    nombre_tipo_doc varchar(200),
    nombre_doc varchar(200),
    chequeado varchar(10),
    url varchar(200),
    extencion varchar(5),
    obs text,
    PRIMARY KEY (id_documento_wf)) INHERITS (pxp.tbase);


--------------- SQL ---------------

ALTER TABLE wf.tproceso_wf
  ADD COLUMN codigo_proceso VARCHAR(150) DEFAULT '' NOT NULL;
  

ALTER TABLE wf.tproceso_wf
  ALTER COLUMN codigo_proceso DROP DEFAULT;
  
  
COMMENT ON COLUMN wf.tproceso_wf.codigo_proceso
IS 'es un codigo que permite identifica al proceso origen de manrea univoca, por ejemplo nuro de solicitud de compra, orden de compra, o numero de cuota, etc';


--------------- SQL ---------------

--------------- SQL ---------------

ALTER TABLE wf.tproceso_wf
  ALTER COLUMN descripcion TYPE VARCHAR(1000) COLLATE pg_catalog."default";


ALTER TABLE wf.tproceso_wf
  ALTER COLUMN codigo_proceso TYPE VARCHAR(350) COLLATE pg_catalog."default";


/***********************************F-SCP-RAC-WF-0-15/01/2014****************************************/


/***********************************I-SCP-RAC-WF-0-16/01/2014****************************************/


--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD COLUMN id_estado_ini INTEGER;

COMMENT ON COLUMN wf.tdocumento_wf.id_estado_ini
IS 'hace referencia al estado donde se creo el documento';


/***********************************F-SCP-RAC-WF-0-16/01/2014****************************************/



/***********************************I-SCP-RAC-WF-0-18/01/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  RENAME COLUMN extencion TO extension;


/***********************************F-SCP-RAC-WF-0-18/01/2014****************************************/



/***********************************I-SCP-RAC-WF-0-12/02/2014****************************************/


ALTER TABLE wf.ttipo_documento_estado
  ADD COLUMN tipo_busqueda VARCHAR(12) DEFAULT 'superior' NOT NULL;

COMMENT ON COLUMN wf.ttipo_documento_estado.tipo_busqueda
IS 'superior o inferior, define la forma de buscar el documento';



/***********************************F-SCP-RAC-WF-0-12/02/2014****************************************/



/***********************************I-SCP-RAC-WF-0-17/02/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD COLUMN chequeado_fisico VARCHAR(4) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN wf.tdocumento_wf.chequeado_fisico
IS 'identifica los documentos que se tienen fisicamente';

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD COLUMN momento_fisico VARCHAR(30) DEFAULT 'verificar' NOT NULL;

COMMENT ON COLUMN wf.tdocumento_wf.momento_fisico
IS 'verificar o exigir documentos fisicos';


/***********************************F-SCP-RAC-WF-0-17/02/2014****************************************/


