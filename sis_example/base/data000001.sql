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

/***********************************I-DAT-MZM-EXA-0-01/06/2020****************************************/

select pxp.f_insert_tgui ('Form Example', 'Form Example', 'EXAFORM', 'si', 1, 'x', 2, 'assistant', 'EXA_FormExample1', 'EXA');
select pxp.f_insert_tgui ('Forms', 'Forms', 'EXAFORMS', 'si', 1, '', 2, '', '', 'EXA');
select pxp.f_insert_tgui ('FormBasic', 'Form1', 'EXAFORM1', 'si', 1, 'x', 3, '', 'EXA_FormExample', 'EXA');
select pxp.f_insert_tgui ('DatePicker', '', 'EXAFORMDP', 'si', 2, ' ', 3, '', 'EXA_PickerExample', 'EXA');
select pxp.f_delete_tgui ('FORMAUTOC');
select pxp.f_insert_tgui ('TextField', 'TextField', 'FORMTF', 'si', 3, ' ', 3, '', 'EXA_TextFieldExample', 'EXA');
select pxp.f_insert_tgui ('List', 'List', 'EXALIST', 'si', 2, '', 2, '', '', 'EXA');
select pxp.f_insert_tgui ('List with Filters', 'List with Filters', 'EXALIST__1', 'si', 1, '1', 3, 'list', 'EXALIST__options', 'EXA');
select pxp.f_insert_tgui ('Autocomplete', 'Autocomplete', 'FORMAC', 'si', 3, 'x', 3, '', 'EXA_AutocompleteExample', 'EXA');
select pxp.f_insert_tgui ('Wizard', 'Wizard Component', 'WZD', 'si', 3, '', 2, '', '', 'EXA');
select pxp.f_insert_tgui ('Vertical Wizard', 'Vertical Wizard', 'WZD__V', 'si', 1, '1', 3, 'self_improvement', 'WZD__Vertical', 'EXA');
select pxp.f_insert_tgui ('Horizontal Wizard', '', 'WZD__H', 'si', 2, '1', 3, 'table_chart', 'WZD__Horizontal', 'EXA');
select pxp.f_insert_tgui ('ButtonPxp', 'EXA_ButtonPxp', 'FORMKB', 'si', 5, 'c', 3, '', 'EXA_ButtonPxp', 'EXA');
/***********************************F-DAT-MZM-EXA-0-01/06/2020****************************************/

/***********************************I-DAT-JRR-EXA-0-19/06/2020****************************************/
select pxp.f_insert_tgui ('Chat', 'Chat', 'EXACHAT', 'si', 6, 'c', 3, 'assistant', 'EXA__Chat', 'EXA');
/***********************************F-DAT-JRR-EXA-0-19/06/2020****************************************/

