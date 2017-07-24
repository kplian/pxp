/***********************************I-TYP-FFP-POR-1-25/09/2015****************************************/

CREATE TYPE param.json_archivos_ins AS (
  nombre_archivo VARCHAR(255),
  extension VARCHAR(255),
  folder VARCHAR(255)
);
/***********************************F-TYP-FPP-POR-1-25/09/2015****************************************/

/***********************************I-TYP-FFP-PARAM-1-21/07/2017****************************************/

CREATE TYPE param.archivo_json_join AS (

  tipo VARCHAR(255) ,
  tabla VARCHAR(255) ,
  nick VARCHAR(255) ,
  condicion VARCHAR(255)

);

/***********************************F-TYP-FPP-PARAM-1-21/07/2017****************************************/