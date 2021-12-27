/***********************************I-SCP-FRH-WF-0-15/02/2013****************************************/
CREATE TYPE wf.cuenta_form AS (  
  id_oficina_cuenta INTEGER,
  monto NUMERIC(18,2)
);

CREATE TABLE wf.ttipo_proceso (
  id_tipo_proceso   SERIAL NOT NULL, 
  id_tipo_estado   int4, 
  id_proceso_macro int4 NOT NULL, 
  nombre           varchar(200), 
  tabla            varchar(100), 
  columna_llave    varchar(150), 
  codigo           varchar(10) COLLATE pg_catalog."default",
  inicio VARCHAR(2) DEFAULT 'no'::character varying NOT NULL,
  funcion_validacion_wf VARCHAR(200),
  tipo_disparo VARCHAR(40),
  descripcion VARCHAR,
  codigo_llave VARCHAR(200),
  modificado INTEGER,
  funcion_disparo_wf VARCHAR(100),
  CONSTRAINT uk_codigo UNIQUE(codigo),
  CONSTRAINT uk_tipo_proceso_tipo_estado UNIQUE(id_tipo_proceso,id_tipo_estado),
  PRIMARY KEY (id_tipo_proceso)) INHERITS (pxp.tbase);

  COMMENT ON COLUMN wf.ttipo_proceso.funcion_validacion_wf
IS 'Nombre de la funcion de validacion, esta funcion retorna falso o verdadero. Sirve para decidir si el proceso se inia o no (ejemplo preingresos de almaces o aactivos fijos al relaizar compras)';

COMMENT ON COLUMN wf.ttipo_proceso.tipo_disparo
IS 'obligatorio -> define si el proceso se dispara siempre, opcional -> (el usuario decide), opcional_automatico (se revisa la funcion de validacion), bandeja -> el proceso queda pendiente en una bandeja de espera';

COMMENT ON COLUMN wf.ttipo_proceso.descripcion
IS 'campo que describe el tipo de proceso';

COMMENT ON COLUMN wf.ttipo_proceso.codigo_llave
IS 'Este codigo permite identificar en tiempode ejecucion la anturaleza del proceso, pro ejemeplo, existe para procesos de Obligacion de pago, esto nos permite identificar que son obligaciones de pago y no ingresos a almacenes';

COMMENT ON COLUMN wf.ttipo_proceso.funcion_disparo_wf
IS 'Esta funcion sirve para colocar logija adicional depues de un disparo de proceso, ejemplo al dispara la obligacion de pago es necesario copiar el detalle de la cotizacion y copiarlo al detallle de la obligacion';

  
  
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
  descripcion VARCHAR,
  plantilla_mensaje VARCHAR DEFAULT '<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>'::character varying,
  plantilla_mensaje_asunto VARCHAR(500) DEFAULT 'Aviso WF ,  {PROCESO_MACRO}  ({NUM_TRAMITE})',
  cargo_depto VARCHAR(200)[],
  mobile VARCHAR(10) DEFAULT 'no' NOT NULL,
  funcion_inicial VARCHAR(150),
  funcion_regreso VARCHAR(200),
  acceso_directo_alerta VARCHAR,
  nombre_clase_alerta VARCHAR(40),
  parametros_ad VARCHAR DEFAULT '{}' NOT NULL,
  tipo_noti VARCHAR(40) DEFAULT 'notificacion' NOT NULL,
  titulo_alerta VARCHAR(50) DEFAULT '',
  modificado INTEGER,
  admite_obs VARCHAR(30) DEFAULT 'no' NOT NULL,
  etapa VARCHAR(150),
  grupo_doc VARCHAR,
  id_tipo_estado_anterior INTEGER,
  icono VARCHAR(50),
  dias_alerta INTEGER,
  sla VARCHAR(2) DEFAULT 'no'::character varying NOT NULL,
  dias_limite INTEGER,
  dias_envio VARCHAR,
  hrs_envio VARCHAR,
  PRIMARY KEY (id_tipo_estado)) INHERITS (pxp.tbase); 

  COMMENT ON COLUMN wf.ttipo_estado.plantilla_mensaje
IS 'plantilla de mensajes para el envio de alertas';

COMMENT ON COLUMN wf.ttipo_estado.obs
IS 'Este campo se utiliza para adicionar comodines que pueden ser utile en el proceso. Por ejemplo sirve para identificar que partidas son revisadas por los vistos buenos de almancenes y activos fijos';

COMMENT ON COLUMN wf.ttipo_estado.plantilla_mensaje
IS 'rirve para personalizar la el correo que me manda al cambiar el estado, los valor de la plantilla se recuperar de la table referenciada en tipo_proceso';

COMMENT ON COLUMN wf.ttipo_estado.cargo_depto
IS 'este campo recibe los cargo del depto que reciben la alerta, si no tiene valores se les manda  todos';

COMMENT ON COLUMN wf.ttipo_estado.mobile
IS 'si o no, se muestra en el la interface de vobowf,  solo es conveniente las interfaces que solo necesitas ir adelante o atras';
  
COMMENT ON COLUMN wf.ttipo_estado.funcion_inicial
IS 'esta funcion correo cuando  el flujo continua sobre este estado';  

COMMENT ON COLUMN wf.ttipo_estado.funcion_regreso
IS 'esta funcion correo cuando  el flujo retrocede hacia este estado';

COMMENT ON COLUMN wf.ttipo_estado.acceso_directo_alerta
IS 'direccion de la interface que se manda dentro la alerta de este estado';

COMMENT ON COLUMN wf.ttipo_estado.nombre_clase_alerta
IS 'nombre de la clase que se ejecuta en el acceso directo de la clase';

COMMENT ON COLUMN wf.ttipo_estado.parametros_ad
IS 'parametros en formato JSON que se mandan al acceso directo';

COMMENT ON COLUMN wf.ttipo_estado.tipo_noti
IS 'tipo de alerta';

COMMENT ON COLUMN wf.ttipo_estado.titulo_alerta
IS 'Titulo que se muestra en la alerta';

COMMENT ON COLUMN wf.ttipo_estado.admite_obs
IS 'no o si, define si permite registrar observaciones en este estado';

COMMENT ON COLUMN wf.ttipo_estado.etapa
IS 'Este es un texto que sirve hacer menos abstrato el nombre de los estados,  por lo general barrios estado pueden pertener a una misma etapa, este cmapo tiene que aprece en el diagrama gantt y en grilla';

COMMENT ON COLUMN wf.ttipo_estado.grupo_doc
IS 'aca se almacena la configuracion gruposBarraTareas  que va en la interface de documentos para definir que categorias pueden verse desde esta interface.';

COMMENT ON COLUMN wf.ttipo_estado.icono
IS 'Icono para representar al estado';

COMMENT ON COLUMN wf.ttipo_estado.dias_alerta
IS 'Dias de vida antes de que se borre automaticamente la alerta';

COMMENT ON COLUMN wf.ttipo_estado.dias_limite
IS 'Dias en que un estado debe pasar al siguiente a menos que sea un estado fin. Se envian correos y alertas si este esta habilitado(SLA)';

COMMENT ON COLUMN wf.ttipo_estado.dias_envio
IS 'Dias en  se enviara una (alerta/correo) deacuerdo a los dias limite. Se envian correos y alertas si este esta habilitado(SLA)';

COMMENT ON COLUMN wf.ttipo_estado.hrs_envio
IS 'Hrs que se enviara Cada (alerta/correo) el ultimo dia y los dias retrasados
del estado';
  
  
CREATE TABLE wf.testructura_estado (
  id_estructura_estado  SERIAL NOT NULL, 
  id_tipo_estado_padre  int4 NOT NULL, 
  id_tipo_estado_hijo   int4 NOT NULL, 
  prioridad             int4, 
  regla                 varchar(1000), 
  modificado INTEGER,
  bucle VARCHAR(2) DEFAULT 'no' NOT NULL,
  PRIMARY KEY (id_estructura_estado)) INHERITS (pxp.tbase);
  COMMENT ON COLUMN wf.testructura_estado.bucle
  IS 'identifica si la arista ocaciona un bucle, este campo se registra de manera automatica el momento de insetar la arista';


  
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
  verifica_documento VARCHAR(2) DEFAULT 'si',
  PRIMARY KEY (id_estado_wf)) INHERITS (pxp.tbase);
  
  
CREATE TABLE wf.tnum_tramite (
  id_num_tramite    SERIAL NOT NULL, 
  id_proceso_macro int4 NOT NULL, 
  id_gestion       int4 NOT NULL, 
  num_siguiente    int4, 
  PRIMARY KEY (id_num_tramite)) INHERITS (pxp.tbase);
     
    
  
  
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
  descripcion VARCHAR(1000) COLLATE pg_catalog."default",
  codigo_proceso VARCHAR(350)  NOT NULL COLLATE pg_catalog."default",
  revisado_asistente VARCHAR(4) DEFAULT 'no',
  prioridad INTEGER DEFAULT 2 NOT NULL,
  id_tipo_estado_wfs INTEGER[],
  PRIMARY KEY (id_proceso_wf)) INHERITS (pxp.tbase);
   
COMMENT ON COLUMN wf.tproceso_wf.codigo_proceso
IS 'es un codigo que permite identifica al proceso origen de manrea univoca, por ejemplo nuro de solicitud de compra, orden de compra, o numero de cuota, etc';

COMMENT ON COLUMN wf.tproceso_wf.prioridad
IS 'los numeros mas bajos representan prioridades mayores';


COMMENT ON COLUMN wf.tproceso_wf.id_tipo_estado_wfs
IS 'almacenes el historico de tipo de estado por lo que va pansado el flujo, se utiliza para saber cuanto veces paso por un mismo estado';

  
  
  
CREATE TABLE wf.tproceso_macro (
  id_proceso_macro  SERIAL NOT NULL, 
  id_subsistema    int4, 
  codigo           varchar(10) UNIQUE, 
  nombre           varchar(200), 
  inicio           varchar(2), 
  modificado INTEGER,
  grupo_doc VARCHAR,
  PRIMARY KEY (id_proceso_macro)) INHERITS (pxp.tbase);
  COMMENT ON COLUMN wf.tproceso_macro.grupo_doc
  IS 'aca se almacena la configuracion gruposBarraTareas  que va en la interface de documentos para definir que categorias pueden verse desde esta interface.';

  
/*****************************F-SCP-FRH-WF-0-15/02/2013**********************************************/


/***********************************I-SCP-FRH-WF-0-18/02/2013****************************************/

CREATE TABLE wf.tfuncionario_tipo_estado (
  id_funcionario_tipo_estado  SERIAL NOT NULL, 
  id_tipo_estado             int4 NOT NULL,
  id_funcionario             int4,   
  id_depto                   int4,
  id_labores_tipo_proceso    int4,  
  regla                      VARCHAR,
  modificado                 INTEGER,
  PRIMARY KEY (id_funcionario_tipo_estado)) INHERITS (pxp.tbase); 
  
  CREATE TABLE wf.tlabores_tipo_proceso (
  id_labores_tipo_proceso  SERIAL NOT NULL, 
  id_tipo_proceso         int4 NOT NULL, 
  nombre                  varchar(50), 
  codigo                  varchar(15) UNIQUE, 
  descripcion             varchar(255), 
  modificado              INTEGER,
  PRIMARY KEY (id_labores_tipo_proceso)) INHERITS (pxp.tbase);

/***********************************F-SCP-FRH-WF-0-18/02/2013****************************************/


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
    modificado INTEGER,
    solo_lectura VARCHAR(4) DEFAULT 'no' NOT NULL,
    categoria_documento VARCHAR(60)[],
    orden NUMERIC(4,2) DEFAULT 1 NOT NULL,
    nombre_vista varchar(70),
    nombre_archivo_plantilla text,
    esquema_vista VARCHAR(10),
    PRIMARY KEY (id_tipo_documento)) INHERITS (pxp.tbase);
COMMENT ON COLUMN wf.ttipo_documento.solo_lectura
IS 'los campos  de solo lectura se copia por base de datos,  y no deben ser cambiados por los usuarios';

COMMENT ON COLUMN wf.ttipo_documento.categoria_documento
IS 'este campo sirve para idetoficar a que caterorias pertenece un tipo de documento';

COMMENT ON COLUMN wf.ttipo_documento.orden
IS 'numero para ordenar los documentos por importancion los mas importantes necesitan numeros mas bajos';




 
CREATE TABLE wf.ttipo_documento_estado(
    id_tipo_documento_estado SERIAL NOT NULL,
    id_tipo_documento int4 NOT NULL,
    id_tipo_proceso int4 NOT NULL,
    id_tipo_estado int4 NOT NULL,
    momento varchar(255),
    tipo_busqueda VARCHAR(12) DEFAULT 'superior' NOT NULL,
    regla VARCHAR,
    modificado INTEGER,
    PRIMARY KEY (id_tipo_documento_estado))INHERITS (pxp.tbase);
    COMMENT ON COLUMN wf.ttipo_documento_estado.tipo_busqueda
    IS 'superior o inferior, define la forma de buscar el documento';


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
    extension varchar(5),
    obs text,
    id_estado_ini INTEGER,
    chequeado_fisico VARCHAR(4) DEFAULT 'no' NOT NULL,
    momento_fisico VARCHAR(30) DEFAULT 'verificar' NOT NULL,
    id_usuario_upload INTEGER,
    fecha_upload TIMESTAMP WITHOUT TIME ZONE,
    id_proceso_wf_ori INTEGER,
    nro_tramite_ori VARCHAR,
    id_documento_wf_ori INTEGER,
    accion_pendiente VARCHAR(15),
    fecha_firma VARCHAR(25),
    usuario_firma VARCHAR(50),
    datos_firma JSON,
    hash_firma varchar(50),
    demanda VARCHAR(4) DEFAULT 'no' NOT NULL,
    observacion VARCHAR,
    PRIMARY KEY (id_documento_wf)) INHERITS (pxp.tbase);
COMMENT ON COLUMN wf.tdocumento_wf.id_estado_ini
IS 'hace referencia al estado donde se creo el documento';

COMMENT ON COLUMN wf.tdocumento_wf.chequeado_fisico
IS 'identifica los documentos que se tienen fisicamente';

COMMENT ON COLUMN wf.tdocumento_wf.momento_fisico
IS 'verificar o exigir documentos fisicos';

COMMENT ON COLUMN wf.tdocumento_wf.id_proceso_wf_ori
IS 'para alguno documentos copiados, como los contratos en OP, toma el pvalor del proceso wf original para que nos sirva para direccionar a los otros documentos del tramite original';

COMMENT ON COLUMN wf.tdocumento_wf.nro_tramite_ori
IS 'por rendimiento copiamos el nro_tramite';

COMMENT ON COLUMN wf.tdocumento_wf.demanda
IS 'documento insertado por demanda si o no, por defecto es no';


/***********************************F-SCP-RAC-WF-0-15/01/2014****************************************/


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
  vista_campo_maestro VARCHAR(75),
  vista_scripts_extras	TEXT,
  menu_nombre VARCHAR(100), 
  menu_icono VARCHAR(100), 
  menu_codigo VARCHAR(25),
  ejecutado VARCHAR(2) DEFAULT 'no' NOT NULL,
  script_ejecutado VARCHAR(2) DEFAULT 'no' NOT NULL,
  vista_estados_new VARCHAR(100)[],
  vista_estados_delete VARCHAR(100)[],
  modificado INTEGER,
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
  modificado INTEGER,
  bd_prioridad INTEGER,
  form_grupo INTEGER,
  bd_campos_subconsulta TEXT,
  transacciones_permiso VARCHAR(250),
  orden INTEGER,
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
  modificado INTEGER,
  regla VARCHAR,
  PRIMARY KEY(id_columna_estado)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/*******************************************F-SCP-JRR-WF-0-07/05/2014*************************************/


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


/***********************************I-SCP-RCM-WF-0-09/06/2014****************************************/



CREATE TABLE wf.ttipo_proceso_origen (
  id_tipo_proceso_origin SERIAL, 
  id_tipo_estado INTEGER NOT NULL, 
  id_tipo_proceso INTEGER NOT NULL, 
  tipo_disparo VARCHAR NOT NULL, 
  funcion_validacion_wf TEXT, 
  id_proceso_macro INTEGER, 
  modificado INTEGER,
  CONSTRAINT ttipo_proceso_origen_pkey PRIMARY KEY(id_tipo_proceso_origin)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE wf.ttipo_proceso_origen
  ALTER COLUMN id_tipo_proceso_origin SET STATISTICS 0;

ALTER TABLE wf.ttipo_proceso_origen
  ALTER COLUMN id_tipo_estado SET STATISTICS 0;

ALTER TABLE wf.ttipo_proceso_origen
  ALTER COLUMN id_tipo_proceso SET STATISTICS 0;

ALTER TABLE wf.ttipo_proceso_origen
  ALTER COLUMN funcion_validacion_wf SET STATISTICS 0;

ALTER TABLE wf.ttipo_proceso_origen
  ALTER COLUMN id_proceso_macro SET STATISTICS 0;

COMMENT ON COLUMN wf.ttipo_proceso_origen.tipo_disparo
IS 'obligatorio -> define si el proceso se dispara siempre, opcional -> (el usuario decide), opcional_automatico (se revisa la funcion de validacion), bandeja -> el proceso queda pendiente en una bandeja de espera';

COMMENT ON COLUMN wf.ttipo_proceso_origen.funcion_validacion_wf
IS 'tuncion de validacion o regla a ser evaluada';

COMMENT ON COLUMN wf.ttipo_proceso_origen.id_proceso_macro
IS 'ee utiliza para filtrar los tipo_estado disaradores que se muestran';



/***********************************F-SCP-RCM-WF-0-09/06/2014****************************************/


/***********************************I-SCP-RAC-WF-0-20/08/2014****************************************/
CREATE TABLE wf.tplantilla_correo (		
id_plantilla_correo	serial not null,	
id_tipo_estado	integer	not null,
codigo_plantilla	varchar(50)	not null,
plantilla	text,	
correos	varchar[] not null,
documentos	varchar[],
regla	text,
modificado INTEGER,
asunto VARCHAR(255),
requiere_acuse VARCHAR(4) DEFAULT 'no' NOT NULL,
url_acuse VARCHAR,
mensaje_acuse VARCHAR,
mensaje_link_acuse VARCHAR,
mandar_automaticamente VARCHAR(5) DEFAULT 'si' NOT NULL,
funcion_acuse_recibo VARCHAR,
funcion_creacion_correo VARCHAR,
cc VARCHAR[],
bcc VARCHAR[],
CONSTRAINT tplantilla_correo_pkey PRIMARY KEY(id_plantilla_correo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
COMMENT ON COLUMN wf.tplantilla_correo.requiere_acuse
IS 'si l aplantilla requiere acuse el correo se manda con un link donde la persona que recibe tendra que confirma su aceptación';

COMMENT ON COLUMN wf.tplantilla_correo.url_acuse
IS 'indeitifca la URL que se coloca en el link del correo para que la persona que recibe acepte,   puede ser un servidor dintinto, en un dmz';

COMMENT ON COLUMN wf.tplantilla_correo.mensaje_acuse
IS 'depues de precinar el link del acuse se muestra este mensaje,';

COMMENT ON COLUMN wf.tplantilla_correo.mensaje_link_acuse
IS 'mensjae que a antes del link de acuse de recibo';

COMMENT ON COLUMN wf.tplantilla_correo.mandar_automaticamente
IS 'se manda el correo de manera automatica al llegar a este estado o espera la confirmación para enviar';	

COMMENT ON COLUMN wf.tplantilla_correo.funcion_acuse_recibo
IS 'esta funcion se ejecuta cuando se recibe el acuse de recibo';

COMMENT ON COLUMN wf.tplantilla_correo.funcion_creacion_correo
IS 'esta funcion se ejecuta despude se insertar la alerta';
/***********************************F-SCP-RAC-WF-0-20/08/2014****************************************/


/***********************************I-SCP-JRR-WF-1-03/09/2014****************************************/

CREATE TABLE wf.ttipo_estado_rol (
  id_tipo_estado_rol SERIAL NOT NULL,
  id_tipo_estado INTEGER NOT NULL,
  id_rol INTEGER NOT NULL,      
  modificado INTEGER,
  PRIMARY KEY(id_tipo_estado_rol)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-JRR-WF-1-03/09/2014****************************************/

/***********************************I-SCP-RAC-WF-1-23/09/2014****************************************/


--------------- SQL ---------------


CREATE TABLE wf.tobs (
  id_obs SERIAL, 
  titulo VARCHAR NOT NULL, 
  descripcion VARCHAR NOT NULL, 
  id_funcionario_resp INTEGER NOT NULL, 
  estado VARCHAR(20) DEFAULT 'abierto'::character varying, 
  fecha_fin TIMESTAMP(6) WITHOUT TIME ZONE, 
  desc_fin VARCHAR,
  num_tramite VARCHAR(500) NOT NULL,
  id_estado_wf INTEGER NOT NULL,
  id_alarma INTEGER,
  CONSTRAINT tobs_pkey PRIMARY KEY(id_obs)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
COMMENT ON COLUMN wf.tobs.id_alarma
IS 'referencia a la alarma creada por la observacion';
/***********************************F-SCP-RAC-WF-1-23/09/2014****************************************/

/*****************************I-SCP-RAC-WF-0-04/12/2014*************/

--------------- SQL ---------------

CREATE TABLE wf.tdocumento_historico_wf (
  id_documento_historico_wf SERIAL,
  id_documento INTEGER,
  version INTEGER,
  vigente VARCHAR(4) DEFAULT 'si' NOT NULL,
  url_old VARCHAR,
  url VARCHAR,
  extension VARCHAR(5),
  fecha_firma VARCHAR(25),
  usuario_firma VARCHAR(50),
  datos_firma JSON,
  hash_firma varchar(50),
  observacion VARCHAR,
  PRIMARY KEY(id_documento_historico_wf)
) INHERITS (pxp.tbase)
;

ALTER TABLE wf.tdocumento_historico_wf
  OWNER TO postgres;

COMMENT ON COLUMN wf.tdocumento_historico_wf.vigente
IS 'si o no, lo no vigentes son versiones anteriores';
   
/*****************************F-SCP-RAC-WF-0-04/12/2014*************/


/*****************************I-SCP-RAC-WF-0-20/03/2015*************/

--------------- SQL ---------------

CREATE TABLE wf.tcategoria_documento (
  id_categoria_documento SERIAL,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  nombre VARCHAR,
  modificado INTEGER,
  PRIMARY KEY(id_categoria_documento)
) INHERITS (pxp.tbase)
;

ALTER TABLE wf.tcategoria_documento
  OWNER TO postgres;

COMMENT ON COLUMN wf.tcategoria_documento.codigo
IS 'identifica el documento y se almacenes en el array  categoria_documento en la interface de tipo_documento_wf';


/*****************************F-SCP-RAC-WF-0-20/03/2015*************/