/********************************************I-DAUP-AUTOR-SCHEMA-0-31/02/2019********************************************/
--SHEMA : Esquema (CONTA) contabilidad         AUTHOR:Siglas del autor de los scripts' dataupdate000001.txt
/********************************************F-DAUP-AUTOR-SCHEMA-0-31/02/2019********************************************/

/********************************************I-DAUP-EGS-SEGU-0-27/10/2020********************************************/
-- UPDATE segu.tusuario SET
--     estado_reg = 'inactivo'
-- WHERE id_usuario in (553,554);
--
-- UPDATE segu.tusuario SET
--     estado_reg = 'activo'
-- WHERE id_usuario in (656);

UPDATE segu.tusuario SET
    estado_reg = 'activo'
WHERE id_usuario in (553,554);

UPDATE segu.tusuario SET
    estado_reg = 'inactivo'
WHERE id_usuario in (656);
/********************************************F-DAUP-EGS-SEGU-0-27/10/2020********************************************/