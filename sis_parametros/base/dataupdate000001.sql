/********************************************I-DAUP-MMV-PARAM-0-23/02/2021********************************************/
update param.ttipo_cc set
id_tipo_cc_fk = 47
where id_tipo_cc in (1081, 1082, 1083);

update param.ttipo_cc set
id_tipo_cc_fk = 50
where id_tipo_cc in (1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157);

update param.ttipo_cc set
id_tipo_cc_fk = 43
where id_tipo_cc in (1036, 1044, 1045, 1046);

update param.tcentro_costo set
estado_reg = 'activo'
where id_centro_costo in (select e.id_centro_costo
                          from param.tcentro_costo e
                          where e.id_tipo_cc in ( select c.id_tipo_cc
                                                  from param.ttipo_cc c
                                                  where c.codigo in ( '40400001',
                                                                      '45120002',
                                                                      '12160000',
                                                                      '40980000',
                                                                      '12410000',
                                                                      '12420000',
                                                                      '12430000',
                                                                      '12510000',
                                                                      '12520000',
                                                                      '12600000',
                                                                      '12610000',
                                                                      '12620000',
                                                                      '12630000',
                                                                      '12640000',
                                                                      '12650000',
                                                                      '13520000')));
/********************************************F-DAUP-MMV-PARAM-0-23/02/2021********************************************/
/********************************************I-DAUP-EGS-PARAM-ETR-38910-06/05/2021********************************************/
-- UPDATE param.tproveedor SET
--     codigo = 'ODT101047'
-- WHERE id_proveedor = 40449;
UPDATE param.tproveedor SET
codigo = 'FUN101047'
WHERE id_proveedor = 40449;
/********************************************F-DAUP-EGS-PARAM-ETR-38910-06/05/2021********************************************/


