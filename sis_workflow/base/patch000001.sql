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



/***********************************I-SCP-RAC-WF-0-21/02/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD COLUMN id_usuario_upload INTEGER;

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD COLUMN fecha_upload TIMESTAMP WITHOUT TIME ZONE;
  
/***********************************F-SCP-RAC-WF-0-22/02/2014****************************************/



/***********************************I-SCP-RAC-WF-0-25/03/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso
  ADD COLUMN funcion_validacion_wf VARCHAR(200);

COMMENT ON COLUMN wf.ttipo_proceso.funcion_validacion_wf
IS 'Nombre de la funcion de validacion, esta funcion retorna falso o verdadero. Sirve para decidir si el proceso se inia o no (ejemplo preingresos de almaces o aactivos fijos al relaizar compras)';

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso
  ADD COLUMN tipo_disparo VARCHAR(40);

COMMENT ON COLUMN wf.ttipo_proceso.tipo_disparo
IS 'obligatorio -> define si el proceso se dispara siempre, opcional -> (el usuario decide), opcional_automatico (se revisa la funcion de validacion), bandeja -> el proceso queda pendiente en una bandeja de espera';


--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso
  ADD COLUMN descripcion VARCHAR;

COMMENT ON COLUMN wf.ttipo_proceso.descripcion
IS 'campo que describe el tipo de proceso';

--------------- SQL ---------------

ALTER TABLE wf.ttipo_estado
  ADD COLUMN descripcion VARCHAR;  

--------------- SQL ---------------

ALTER TABLE wf.ttipo_estado
  ADD COLUMN plantilla_mensaje VARCHAR;

COMMENT ON COLUMN wf.ttipo_estado.plantilla_mensaje
IS 'plantilla de mensajes para el envio de alertas';

--------------- SQL ---------------

COMMENT ON COLUMN wf.ttipo_estado.obs
IS 'Este campo se utiliza para adicionar comodines que pueden ser utile en el proceso. Por ejemplo sirve para identificar que partidas son revisadas por los vistos buenos de almancenes y activos fijos';

/***********************************F-SCP-RAC-WF-0-25/03/2014****************************************/


/***********************************I-SCP-RAC-WF-0-15/04/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.ttipo_estado
  ADD COLUMN plantilla_mensaje_asunto VARCHAR(500);

ALTER TABLE wf.ttipo_estado
  ALTER COLUMN plantilla_mensaje_asunto SET DEFAULT 'Aviso WF ,  {PROCESO_MACRO}  ({NUM_TRAMITE})';

--------------- SQL ---------------

--------------- SQL ---------------

ALTER TABLE wf.ttipo_estado
  ALTER COLUMN plantilla_mensaje SET DEFAULT '<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>'::character varying;

COMMENT ON COLUMN wf.ttipo_estado.plantilla_mensaje
IS 'rirve para personalizar la el correo que me manda al cambiar el estado, los valor de la plantilla se recuperar de la table referenciada en tipo_proceso';


/***********************************F-SCP-RAC-WF-0-15/04/2014****************************************/



/***********************************I-SCP-RAC-WF-0-29/04/2014****************************************/

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso
  ADD COLUMN codigo_llave VARCHAR(200);

COMMENT ON COLUMN wf.ttipo_proceso.codigo_llave
IS 'Este codigo permite identificar en tiempode ejecucion la anturaleza del proceso, pro ejemeplo, existe para procesos de Obligacion de pago, esto nos permite identificar que son obligaciones de pago y no ingresos a almacenes';


/***********************************F-SCP-RAC-WF-0-29/04/2014****************************************/

/*******************************************I-SCP-JRR-WF-0-07/05/2014*************************************/

CREATE TABLE wf.ttabla (
  id_tabla SERIAL NOT NULL,
  id_tipo_proceso INTEGER NOT NULL, 
  bd_nombre_tabla VARCHAR(100) NOT NULL,
  bd_codigo_tabla VARCHAR(25) NOT NULL, 
  bd_descripcion TEXT, 
  bd_scripts_extras TEXT, 
  vista_tipo VARCHAR(30) NOT NULL, 
  vista_posicion VARCHAR(50), 
  vista_id_tabla_maestro INTEGER,
  vista_campo_ordenacion VARCHAR(100),
  vista_dir_ordenacion VARCHAR(4),  
  vista_campo_maestro VARCHAR(50),
  vista_scripts_extras	TEXT,
  menu_nombre VARCHAR(100), 
  menu_icono VARCHAR(100), 
  menu_codigo VARCHAR(25),
  ejecutado VARCHAR(2) DEFAULT 'no' NOT NULL,
  script_ejecutado VARCHAR(2) DEFAULT 'no' NOT NULL,
  PRIMARY KEY(id_tabla)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

COMMENT ON COLUMN wf.ttabla.vista_id_tabla_maestro
IS 'la tabla qu es maestro en caso de que sea detalle';

COMMENT ON COLUMN wf.ttabla.vista_campo_maestro
IS 'el campo del maestro en caso de ser detalle';

COMMENT ON COLUMN wf.ttabla.vista_scripts_extras
IS 'En este campo debe registrarse un json con los metodos que se desean sobrescribir de la clase';

COMMENT ON COLUMN wf.ttabla.bd_scripts_extras
IS 'En este campo se puede definir llaves foraneas, indices, triggers, funciones y otros que puedan ser necesarios para la tabla';


CREATE TABLE wf.ttipo_columna (
  id_tipo_columna SERIAL NOT NULL,
  id_tabla INTEGER NOT NULL, 
  bd_nombre_columna VARCHAR(100) NOT NULL,
  bd_tipo_columna VARCHAR(100) NOT NULL,
  bd_descripcion_columna TEXT,
  bd_tamano_columna VARCHAR(5),  
  bd_campos_adicionales TEXT, 
  bd_joins_adicionales TEXT,
  bd_formula_calculo TEXT, 
  grid_sobreescribe_filtro TEXT,  
  grid_campos_adicionales TEXT,
  form_tipo_columna VARCHAR(100) NOT NULL,
  form_label VARCHAR(100), 
  form_es_combo VARCHAR(2), 
  form_combo_rec VARCHAR(50), 
  form_sobreescribe_config TEXT, 
  ejecutado VARCHAR(2) DEFAULT 'no' NOT NULL,
  PRIMARY KEY(id_tipo_columna)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

COMMENT ON COLUMN wf.ttipo_columna.bd_campos_adicionales
IS 'el formato es : "nombre_columna nombre_modelo tipo" separados por comas por cada campo adicional';

COMMENT ON COLUMN wf.ttipo_columna.grid_campos_adicionales
IS 'el formato es : "nombre tipo formato" separados por comas por cada campo adicional';

COMMENT ON COLUMN wf.ttipo_columna.form_sobreescribe_config
IS 'sobreescribir el config de una columna en la vista, debe ser un objeto de tipo json {}';

COMMENT ON COLUMN wf.ttipo_columna.grid_sobreescribe_filtro
IS 'sobreescribir el filtro de una columna en la vista, debe ser un objeto de tipo json {}';


CREATE TABLE wf.tcolumna_estado (
  id_columna_estado SERIAL NOT NULL,
  id_tipo_columna INTEGER NOT NULL,
  id_tipo_estado INTEGER NOT NULL, 
  momento VARCHAR(100) NOT NULL,   
  PRIMARY KEY(id_columna_estado)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/*******************************************F-SCP-JRR-WF-0-07/05/2014*************************************/



/*******************************************I-SCP-RAC-WF-0-15/05/2014*************************************/

--------------- SQL ---------------

ALTER TABLE wf.ttipo_estado
  ADD COLUMN cargo_depto VARCHAR(200)[];

COMMENT ON COLUMN wf.ttipo_estado.cargo_depto
IS 'este campo recibe los cargo del depto que reciben la alerta, si no tiene valores se les manda  todos';


/*******************************************F-SCP-RAC-WF-0-15/05/2014*************************************/


/***********************************I-SCP-RCM-WF-0-05/05/2014****************************************/
CREATE TABLE wf.ttipo_componente (
  id_tipo_componente SERIAL,
  codigo VARCHAR(50) UNIQUE,
  nombre VARCHAR(100),
  CONSTRAINT pk_ttipo_componente__id_tipo_componente PRIMARY KEY(id_tipo_componente)
) INHERITS (pxp.tbase);

COMMENT ON TABLE wf.ttipo_componente
IS 'Almacena los tipos de componente disponibles para la generación de formularios dinámicos';

COMMENT ON COLUMN wf.ttipo_componente.id_tipo_componente
IS 'Identificador de la tabla';

COMMENT ON COLUMN wf.ttipo_componente.codigo
IS 'Codigo unico que representa al componente';

COMMENT ON COLUMN wf.ttipo_componente.nombre
IS 'Nombre descriptivo del componente';

CREATE TABLE wf.ttipo_propiedad (
  id_tipo_propiedad SERIAL,
  codigo VARCHAR(50) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  tipo_dato VARCHAR(30) NOT NULL,
  CONSTRAINT pk_tipo_propiedad_id_tipo_propiedad PRIMARY KEY(id_tipo_propiedad)
) INHERITS (pxp.tbase);

COMMENT ON TABLE wf.ttipo_propiedad
IS 'Almacena los tipos de propiedad generales que podrán ser relacionados a los tipos de componente';

COMMENT ON COLUMN wf.ttipo_propiedad.id_tipo_propiedad
IS 'Identificador de la tabla';

COMMENT ON COLUMN wf.ttipo_propiedad.codigo
IS 'Codigo unico que representa al tipo de propiedad';

COMMENT ON COLUMN wf.ttipo_propiedad.nombre
IS 'Nombre descriptivo del tipo de propiedad';

COMMENT ON COLUMN wf.ttipo_propiedad.tipo_dato
IS 'Tipo de dato por defecto para el valor del tipo de propiedad';

CREATE TABLE wf.ttipo_comp_tipo_prop (
  id_tipo_comp_tipo_prop SERIAL,
  id_tipo_propiedad INTEGER NOT NULL,
  id_tipo_componente INTEGER NOT NULL,
  obligatorio VARCHAR(2) NOT NULL,
  tipo_dato VARCHAR(40) NOT NULL,
  CONSTRAINT pk_tipo_comp_tipo_prop__id_tipo_comp_tipo_prop PRIMARY KEY(id_tipo_comp_tipo_prop)
) INHERITS (pxp.tbase)
;

COMMENT ON TABLE wf.ttipo_comp_tipo_prop
IS 'Almacena los tipos de propiedad para cada tipo de componente';

COMMENT ON COLUMN wf.ttipo_comp_tipo_prop.id_tipo_comp_tipo_prop
IS 'Identificador de la tabla';

COMMENT ON COLUMN wf.ttipo_comp_tipo_prop.id_tipo_propiedad
IS 'Llave foranea de la tabla wf.ttipo_propiedad';

COMMENT ON COLUMN wf.ttipo_comp_tipo_prop.id_tipo_componente
IS 'Llave foranea de la tabla wf.ttipo_componente';

COMMENT ON COLUMN wf.ttipo_comp_tipo_prop.obligatorio
IS 'Define si el registro del valor del tipo de propiedad sera obligatorio';

COMMENT ON COLUMN wf.ttipo_comp_tipo_prop.tipo_dato
IS 'Tipo de dato para el valor del tipo de propiedad';

/***********************************F-SCP-RCM-WF-0-05/05/2014****************************************/

/***********************************I-SCP-RCM-WF-0-22/05/2014****************************************/
CREATE TABLE wf.tcatalogo (
  id_catalogo SERIAL,
  id_proceso_macro integer not null,
  codigo VARCHAR(50) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  CONSTRAINT pk_tcatalogo__id_catalogo PRIMARY KEY(id_catalogo)
) INHERITS (pxp.tbase);

COMMENT ON TABLE wf.tcatalogo
IS 'Los catálogos se refieren a dominios de datos limitados, que podrán ser utilizados por los formularios
dinámicos del workflow por proceso macro';

COMMENT ON COLUMN wf.tcatalogo.id_catalogo
IS 'Identificador de la cabecera de Catalogos de WF';

COMMENT ON COLUMN wf.tcatalogo.id_proceso_macro
IS 'Llave foránea de la tabla wf.tproceso_macro';

COMMENT ON COLUMN wf.tcatalogo.codigo
IS 'Código único (llave alterna) para nombrar al Catálogo';

COMMENT ON COLUMN wf.tcatalogo.nombre
IS 'Nombre del catálogo';

CREATE TABLE wf.tcatalogo_valor (
  id_catalogo_valor SERIAL,
  fk_id_catalogo_valor integer,
  id_catalogo integer not null,
  codigo VARCHAR(50) NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  orden smallint not null,
  CONSTRAINT pk_tcatalogo_valor__id_catalogo_valor PRIMARY KEY(id_catalogo_valor)
) INHERITS (pxp.tbase);

COMMENT ON TABLE wf.tcatalogo_valor
IS 'Valores definidos en el catálogo (o dominio) creado';

COMMENT ON COLUMN wf.tcatalogo_valor.id_catalogo_valor
IS 'Identificador de la tabla';

COMMENT ON COLUMN wf.tcatalogo_valor.id_catalogo_valor
IS 'Relación recursiva para registro de datos jerárquicos (árbol)';

COMMENT ON COLUMN wf.tcatalogo_valor.id_catalogo
IS 'Llave foránea del maestro de la tabla wf.tcatalogo';

COMMENT ON COLUMN wf.tcatalogo_valor.codigo
IS 'Código único (llave alterna) de los valores del catálogo';

COMMENT ON COLUMN wf.tcatalogo_valor.nombre
IS 'Nombre de los valores del catálogo';

COMMENT ON COLUMN wf.tcatalogo_valor.orden
IS 'Orden de despliegue de los valores del catálogo';
/***********************************F-SCP-RCM-WF-0-22/05/2014****************************************/