/***********************************I-SCP-FFP-EXA-1-12/06/2020****************************************/

CREATE TABLE exa.tdata_example (
                              id_data_example SERIAL,
                              desc_example varchar(255),
                              CONSTRAINT pk_tdata_example__id_data_example PRIMARY KEY(id_data_example)
) INHERITS (pxp.tbase)
  WITHOUT OIDS;

/***********************************F-SCP-FFP-EXA-1-12/06/2020****************************************/
