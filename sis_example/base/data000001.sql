/***********************************I-DAT-JRR-EXA-0-26/05/2020****************************************/

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('EXA', 'Example', '2020-05-02', 'EXA', 'activo', 'example', NULL);

select pxp.f_insert_tgui ('EXAMPLE', '', 'EXA', 'si', 1, '', 1, '', '', 'EXA');
select pxp.f_insert_tgui ('Form Example', 'Form Example', 'EXAFORM', 'si', 1, 'x', 2, 'assistant', 'EXA_FormExample', 'EXA');
select pxp.f_insert_tgui ('Table Example', 'Table Example', 'EXATABLE', 'si', 1, 'x', 2, 'audiotrack', 'EXA_TableExample', 'EXA');
select pxp.f_insert_tgui ('Master Detail Example', 'Master Detail Example', 'EXAMASDET', 'si', 1, 'x', 2, 'laptop', 'EXA_MasterDetailExample', 'EXA');
select pxp.f_insert_tgui ('Map Example', 'Map Example', 'EXAMAP', 'si', 1, 'x', 2, 'watch', 'EXA__MapExample', 'EXA');
select pxp.f_insert_tgui ('Custom1', 'Custom1', 'EXACUST1', 'si', 2, 'x', 2, '', 'EXA__CustomComponent', 'EXA');
select pxp.f_insert_tgui ('Custom2', 'Custom2', 'EXACUST2', 'si', 2, 'x', 2, '', 'EXA__CustomComponent2', 'EXA');

/***********************************F-DAT-JRR-EXA-0-26/05/2020****************************************/
