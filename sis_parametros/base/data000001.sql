
/***********************************I-DAT-RAC-PARAM-0-31/12/2012*****************************************/

/*
*	Author: RAC
*	Date: 21/12/2012
*	Description: Build the menu definition and the composition
*/

/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos

*/

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('PARAM', 'Parametros Generales', '2009-11-02', 'PM', 'activo', 'parametros', NULL);

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

/***********************************F-DAT-RAC-PARAM-0-31/12/2012*****************************************/



/***********************************I-DAT-RCM-PARAM-85-05/04/2013*****************************************/
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Incompleto');
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Completo');
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Anulado');


/***********************************F-DAT-RCM-PARAM-85-05/04/2013*****************************************/




/***********************************I-DAT-RCM-PARAM-00-03/05/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__bandera','Si');
select pxp.f_add_catalog('PARAM','tgral__bandera','No');
/***********************************F-DAT-RCM-PARAM-00-03/05/2013*****************************************/



/***********************************I-DAT-RCM-PARAM-00-24/06/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__estado','activo');
select pxp.f_add_catalog('PARAM','tgral__estado','inactivo');

select pxp.f_add_catalog('PARAM','tgral__gestion','2005');
select pxp.f_add_catalog('PARAM','tgral__gestion','2006');
select pxp.f_add_catalog('PARAM','tgral__gestion','2007');
select pxp.f_add_catalog('PARAM','tgral__gestion','2008');
select pxp.f_add_catalog('PARAM','tgral__gestion','2009');
select pxp.f_add_catalog('PARAM','tgral__gestion','2010');
select pxp.f_add_catalog('PARAM','tgral__gestion','2011');
select pxp.f_add_catalog('PARAM','tgral__gestion','2012');
select pxp.f_add_catalog('PARAM','tgral__gestion','2013');
select pxp.f_add_catalog('PARAM','tgral__gestion','2014');
select pxp.f_add_catalog('PARAM','tgral__gestion','2015');
select pxp.f_add_catalog('PARAM','tgral__gestion','2016');
select pxp.f_add_catalog('PARAM','tgral__gestion','2017');
select pxp.f_add_catalog('PARAM','tgral__gestion','2018');
select pxp.f_add_catalog('PARAM','tgral__gestion','2019');
select pxp.f_add_catalog('PARAM','tgral__gestion','2020');
select pxp.f_add_catalog('PARAM','tgral__gestion','2021');
select pxp.f_add_catalog('PARAM','tgral__gestion','2022');
select pxp.f_add_catalog('PARAM','tgral__gestion','2023');
select pxp.f_add_catalog('PARAM','tgral__gestion','2024');
select pxp.f_add_catalog('PARAM','tgral__gestion','2025');
/***********************************F-DAT-RCM-PARAM-00-24/06/2013*****************************************/

/***********************************I-DAT-RCM-PARAM-00-08/10/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__bandera_min','si');
select pxp.f_add_catalog('PARAM','tgral__bandera_min','no');
/***********************************F-DAT-RCM-PARAM-00-08/10/2013*****************************************/




/***********************************I-DAT-RAC-PARAM-0-15/05/2014*****************************************/

select pxp.f_add_catalog('PARAM','tdepto_usuario_cargo','responsable');
select pxp.f_add_catalog('PARAM','tdepto_usuario_cargo','auxiliar');

/***********************************F-DAT-RAC-PARAM-0-15/05/2014*****************************************/




/***********************************I-DAT-RAC-PARAM-0-28/10/2015*****************************************/

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'moneda_intercambio', E'false', E'el sistema maneja moneda de intercambio');

/***********************************F-DAT-RAC-PARAM-0-28/10/2015*****************************************/


/***********************************I-DAT-RCM-PARAM-0-21/01/2016*****************************************/
select pxp.f_add_catalog('PARAM','tmoneda__origen','nacional');
select pxp.f_add_catalog('PARAM','tmoneda__origen','extranjera');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','sin_actualizacion');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','por_saldo');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','por_transaccion');
/***********************************F-DAT-RCM-PARAM-0-21/01/2016*****************************************/





/***********************************I-DAT-RAC-PARAM-0-12/04/2016*****************************************/

/* Data for the 'pxp.variable_global' table  (Records 1 - 1) */

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES 
  (E'param_comunicado', E'usuario', E'(usuario , funcionario) envio de copmunicados a usuarios de sistema o todos los funcionarios');


/***********************************F-DAT-RAC-PARAM-0-12/04/2016*****************************************/





/*******************************************I-DAT-RAC-PARAM-0-07/10/2016***********************************************/


/* Data for the 'param.twidget' table  (Records 1 - 3) */

INSERT INTO param.twidget ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_widget", "nombre", "obs", "foto", "clase", "tipo", "ruta")
VALUES 
  (1, 1, E'2016-09-10 04:34:20.673', E'2016-09-11 05:59:54.043', E'activo', NULL, E'NULL', 1, E'Prueba', E'este es un widget  de prueba sin datos relevantes', E'./../../../uploaded_files/sis_parametros/Widget/85ab53cb4ec4e66acb25d58419cfc392_v.jpg', E'Prueba', E'objeto', E'sis_seguridad/widgets/Prueba.php'),
  (1, 1, E'2016-09-10 06:24:19.559', E'2016-09-11 10:36:09.940', E'activo', NULL, E'NULL', 2, E'test', E'test', NULL, E'Prueba3', E'objeto', E'sis_seguridad/widgets/Prueba3.php'),
  (1, NULL, E'2016-09-11 10:59:02.279', NULL, E'activo', NULL, E'NULL', 3, E'iframe', E'iframe', NULL, E'Prueba2', E'iframe', E'sis_seguridad/widgets/Prueba2.php');


/* Data for the 'param.tdashboard' table  (Records 1 - 4) */

INSERT INTO param.tdashboard ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_dashboard", "nombre", "id_usuario")
VALUES 
  (1, 1, E'2016-09-10 07:41:23', E'2016-09-11 18:25:46.596', E'activo', NULL, E'NULL', 1, E'mi test', 1),
  (1, NULL, E'2016-09-11 06:24:06.452', NULL, E'activo', NULL, E'NULL', 27, E'Mi dashboard', 1),
  (1, 1, E'2016-09-11 23:07:16.106', E'2016-09-11 23:07:26.357', E'activo', NULL, E'NULL', 28, E'prueba', 1),
  (1, 1, E'2016-09-11 23:07:46.370', E'2016-09-11 23:07:54.814', E'activo', NULL, E'NULL', 29, E'test', 1);


/*******************************************F-DAT-RAC-PARAM-0-07/10/2016***********************************************/



/***********************************I-DAT-RAC-PARAM-0-05/09/2017*****************************************/

----------------------------------
--COPY LINES TO SUBSYSTEM data.sql FILE  
---------------------------------

select param.f_import_tcatalogo_tipo ('insert','tproveedor_tipo','PARAM','tproveedor');
select param.f_import_tcatalogo ('insert','PARAM','Abastecimiento','abastecimiento','tproveedor_tipo');
select param.f_import_tcatalogo ('insert','PARAM','General','general','tproveedor_tipo');

/***********************************F-DAT-RAC-PARAM-0-05/09/2017*****************************************/


/***********************************I-DAT-RAC-PARAM-1-06/09/2017*****************************************/

select wf.f_import_tproceso_macro ('insert','PROV', 'PARAM', 'Proveedores','si');
select wf.f_import_tcategoria_documento ('insert','legales', 'Legales');
select wf.f_import_tcategoria_documento ('insert','proceso', 'Proceso');
select wf.f_import_ttipo_proceso ('insert','REG',NULL,NULL,'PROV','Registro de Proveedores','param.tproveedor','','si','','','','REG',NULL);
select wf.f_import_ttipo_estado ('insert','borrador','REG','Borrador','si','no','no','ninguno','','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Aviso WF ,  {PROCESO_MACRO}  ({NUM_TRAMITE})','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','revision','REG','revision','no','no','no','todos','','ninguno','','','si','si',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Aviso WF ,  {PROCESO_MACRO}  ({NUM_TRAMITE})','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','aprobado','REG','aprobado','no','no','si','anterior','','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Aviso WF ,  {PROCESO_MACRO}  ({NUM_TRAMITE})','','no','','','','','','','',NULL);
select wf.f_import_ttipo_documento ('insert','NIT','REG','NIT','Numero de Identificación Tributaria','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','MATR','REG','Matricula de Comercio','Matricula de Comercio','','escaneado',1.00,'{}');
select wf.f_import_testructura_estado ('insert','borrador','revision','REG',1,'');
select wf.f_import_testructura_estado ('insert','revision','aprobado','REG',1,'');
select wf.f_import_ttipo_documento_estado ('insert','MATR','REG','borrador','REG','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','NIT','REG','borrador','REG','crear','superior','');



INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES  (E'param_wf_codigo_proveedor', E'REG', E'Codigo de proceso macro del wf para el flujo de proveedores');

/***********************************F-DAT-RAC-PARAM-1-06/09/2017*****************************************/


/***********************************I-DAT-RCM-PARAM-1-27/10/2017*****************************************/
select pxp.f_add_catalog('PARAM','tferiado__tipo','Permanente','permanente');
select pxp.f_add_catalog('PARAM','tferiado__tipo','Solo gestión','solo_gestion');



select pxp.f_insert_tgui ('<i class="fa fa-wrench fa-2x"></i> PARAMETROS GENERALES', 'Parametros Generales', 'PARAM', 'si', 2, '', 1, '', 'Sistema de Parametros', 'PARAM');
select pxp.f_insert_tgui ('Alarmas', 'Para programar las alarmas', 'ALARM', 'si', 0, 'sis_parametros/vista/alarma/Alarma.php', 2, '', 'Alarma', 'PARAM');
select pxp.f_insert_tgui ('Departamentos', 'Departamentos', 'DEPTO', 'si', 0, 'sis_parametros/vista/depto/Depto.php', 2, '', 'Depto', 'PARAM');
select pxp.f_insert_tgui ('Lugar', 'Lugar', 'LUG', 'si', 0, 'sis_parametros/vista/lugar/Lugar.php', 2, '', 'Lugar', 'PARAM');
select pxp.f_insert_tgui ('Institucion', 'Detalle de instituciones', 'INSTIT', 'si', 0, 'sis_parametros/vista/institucion/Institucion.php', 2, '', 'Institucion', 'PARAM');
select pxp.f_delete_tgui ('PRO_1');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'PROVEE', 'si', 3, 'sis_parametros/vista/proveedor/Proveedor.php', 2, '', 'proveedor', 'PARAM');
select pxp.f_insert_tgui ('Documentos', 'Documentos por Sistema', 'DOCUME', 'si', 0, 'sis_parametros/vista/documento/Documento.php', 2, '', 'Documento', 'PARAM');
select pxp.f_insert_tgui ('Configuracion Alarmas', 'Para configurar las alarmas', 'CONALA', 'si', 0, 'sis_parametros/vista/config_alarma/ConfigAlarma.php', 2, '', 'ConfigAlarma', 'PARAM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Registro de Unidades de Medida', 'UME', 'si', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 2, '', 'UnidadMedida', 'PARAM');
select pxp.f_insert_tgui ('Gestion', 'Manejo de gestiones', 'GESTIO', 'si', 0, 'sis_parametros/vista/gestion/Gestion.php', 2, '', 'Gestion', 'PARAM');
select pxp.f_insert_tgui ('Catalogo', 'Catalogo', 'CATA', 'si', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 2, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERIOD', 'si', 0, 'sis_parametros/vista/periodo/Periodo.php', 2, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('Moneda', 'Monedas', 'MONPAR', 'si', 0, 'sis_parametros/vista/moneda/Moneda.php', 2, '', 'Moneda', 'PARAM');
select pxp.f_insert_tgui ('Tipos de Catálogos', 'Tipos de Catálogos', 'PACATI', 'si', 0, 'sis_parametros/vista/catalogo_tipo/CatalogoTipo.php', 2, '', 'CatalogoTipo', 'PARAM');
select pxp.f_insert_tgui ('Servicios', 'Para registro de los servicios', 'SERVIC', 'si', 0, 'sis_parametros/vista/servicio/Servicio.php', 2, '', 'Servicio', 'PARAM');
select pxp.f_insert_tgui ('EP', 'Elementos de la Estructura Programatica', 'CEP', 'si', 1, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Compras', 'Parametrizaciones re lacionadas con compras', 'CCOM', 'si', 2, '', 3, '', '', 'PARAM');
select pxp.f_insert_tgui ('Aprobadores', 'Aprobadores de Compras', 'APROC', 'si', 1, 'sis_parametros/vista/aprobador/Aprobador.php', 4, '', 'Aprobador', 'PARAM');
select pxp.f_insert_tgui ('Financiador', 'Financiadores de Compras', 'FIN', 'si', 1, 'sis_parametros/vista/financiador/Financiador.php', 3, '', 'Financiador', 'PARAM');
select pxp.f_insert_tgui ('Regional', 'Regionales de Compras', 'REGIO', 'si', 2, 'sis_parametros/vista/regional/Regional.php', 3, '', 'Regional', 'PARAM');
select pxp.f_insert_tgui ('Programa', 'Programas de Compras', 'PROG', 'si', 3, 'sis_parametros/vista/programa/Programa.php', 3, '', 'Programa', 'PARAM');
select pxp.f_insert_tgui ('Actividad', 'Actividad', 'ACT', 'si', 5, 'sis_parametros/vista/actividad/Actividad.php', 3, '', 'Actividad', 'PARAM');
select pxp.f_insert_tgui ('Programa-Proyecto-Actividad', 'programa proyecto actividad', 'PPA', 'si', 6, 'sis_parametros/vista/programa_proyecto_acttividad/ProgramaProyectoActtividad.php', 3, '', 'ProgramaProyectoActtividad', 'PARAM');
select pxp.f_insert_tgui ('Financiador-Regional-Programa-Proyecto', 'financiadores Regionales Programas Proyectos', 'FRPP', 'si', 7, 'sis_parametros/vista/ep/Ep.php', 3, '', 'Ep', 'PARAM');
select pxp.f_insert_tgui ('Empresa', 'Empresa', 'EMP', 'si', 0, 'sis_parametros/vista/empresa/Empresa.php', 2, '', 'Empresa', 'PARAM');
select pxp.f_insert_tgui ('Concepto de Ingreso/Gasto', 'Parametrizaciond e concepto de gasto o ingreso', 'CONIG', 'si', 2, 'sis_parametros/vista/concepto_ingas/ConceptoIngas.php', 4, '', 'ConceptoIngas', 'PARAM');
select pxp.f_insert_tgui ('Centro de Costo', 'Centro de costo', 'CCOST', 'si', 9, 'sis_parametros/vista/centro_costo/CentroCosto.php', 2, '', 'CentroCosto', 'PARAM');
select pxp.f_insert_tgui ('Tipo de Cambio', 'tipo de cambio', 'TCB', 'si', 0, 'sis_parametros/vista/tipo_cambio/TipoCambio.php', 2, '', 'TipoCambio', 'PARAM');
select pxp.f_insert_tgui ('Asistentes', 'Asistentes', 'ASI', 'si', 4, 'sis_parametros/vista/asistente/Asistente.php', 2, '', 'Asistente', 'PARAM');
select pxp.f_insert_tgui ('Documentos Fiscales', 'Listado de todos los Documentos fiscales', 'DF', 'si', 0, 'sis_parametros/vista/documento_fiscal/DocumentoFiscal.php', 2, '', 'DocumentoFiscal', 'PARAM');
select pxp.f_insert_tgui ('Plantillas', 'Plantillas', 'PLANT', 'si', 0, 'sis_parametros/vista/plantilla/Plantilla.php', 2, '', 'Plantilla', 'PARAM');
select pxp.f_insert_tgui ('Usuarios por Departamento', 'Usuarios por Departamento', 'DEPTO.1', 'no', 0, 'sis_parametros/vista/depto_usuario/DeptoUsuario.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Usuarios', 'Usuarios', 'DEPTO.1.1', 'no', 0, 'sis_seguridad/vista/usuario/Usuario.php', 4, '', 'usuario', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'DEPTO.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'DEPTO.1.1.2', 'no', 0, 'sis_seguridad/vista/usuario_rol/UsuarioRol.php', 5, '', 'usuario_rol', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'DEPTO.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 6, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Ubicacion Lugar', 'Ubicacion Lugar', 'LUG.1', 'no', 0, 'sis_parametros/vista/lugar/mapaLugar.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Items/Servicios ofertados', 'Items/Servicios ofertados', 'PROVEE.1', 'no', 0, 'sis_parametros/vista/proveedor_item_servicio/ProveedorItemServicio.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodos', 'Periodos', 'GESTIO.1', 'no', 0, 'sis_parametros/vista/periodo/Periodo.php', 3, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('subir Logo', 'subir Logo', 'EMP.1', 'no', 0, 'sis_parametros/vista/empresa/subirLogo.php', 3, '', 'subirLogo', 'PARAM');
select pxp.f_insert_tgui ('Generadores de Alarma', 'Configuracion funciones que generan alarmas', 'GAL', 'si', 0, 'sis_parametros/vista/generador_alarma/GeneradorAlarma.php', 2, '', 'GeneradorAlarma', 'PARAM');
select pxp.f_insert_tgui ('Grupos', 'Grupos', 'GQP', 'si', 8, 'sis_parametros/vista/grupo/Grupo.php', 3, '', 'Grupo', 'PARAM');
select pxp.f_insert_tgui ('Depto - UO', 'Depto - UO', 'DEPTO.2', 'no', 0, 'sis_parametros/vista/depto_uo/DeptoUo.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto - EP', 'Depto - EP', 'DEPTO.3', 'no', 0, 'sis_parametros/vista/depto_ep/DeptoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto UO - EP', 'Depto UO - EP', 'DEPTO.4', 'no', 0, 'sis_parametros/vista/depto_uo_ep/DeptoUoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Firmas Documentos', 'Firmas Documentos', 'DEPTO.5', 'no', 0, 'sis_parametros/vista/firma/Firma.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Subsistema', 'Subsistema', 'DEPTO.6', 'no', 0, 'id_subsistema', 3, '', 'Subsistema...', 'PARAM');
select pxp.f_insert_tgui ('EP\', 'EP\', 'DEPTO.1.1.3', 'no', 0, 'sis_seguridad/vista/usuario_grupo_ep/UsuarioGrupoEp.php', 5, '', ', 
          width:400,
          cls:', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INSTIT.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INSTIT.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVEE.3', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.3.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'UME.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'GESTIO.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'GESTIO.1.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'PERIOD.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'APROC.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'APROC.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'APROC.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'CONIG.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Organigrama', 'Organigrama', 'ASI.1', 'no', 0, 'sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php', 3, '', '60%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.2', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ASI.3', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'ASI.1.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 4, '', 'Cargo', 'PARAM');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'ASI.1.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'ASI.1.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 5, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'ASI.1.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 5, '', 'CargoCentroCosto', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.1.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ASI.1.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ASI.1.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DF.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'GQP.1', 'no', 0, 'sis_parametros/vista/grupo_ep/GrupoEp.php', 4, '', 'GrupoEp', 'PARAM');
select pxp.f_insert_tgui ('Entidad', 'Entidad', 'ENT', 'si', 0, 'sis_parametros/vista/entidad/Entidad.php', 2, '', 'Entidad', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DEPTO.1.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.3.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ASI.2.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 4, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.2.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ASI.2.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 5, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.2.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.2.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Depto - Cuenta Bancaria', 'Depto - Cuenta Bancaria', 'DEPTO.7', 'no', 0, 'sis_tesoreria/vista/depto_cuenta_bancaria/DeptoCuentaBancaria.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Monedas', 'Monedas', 'MNDS', 'si', 2, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'ALRMS', 'si', 3, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Empresa', 'Empresa', 'EMPS', 'si', 1, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Catalogos', 'Catalogos', 'CTLGS', 'si', 2, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Otros', 'Otros', 'OTROS', 'si', 50, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Comunicados', 'registro de comunicados ', 'COMAL', 'si', 1, 'sis_parametros/vista/alarma/Comunicado.php', 3, '', 'Comunicado', 'PARAM');
select pxp.f_insert_tgui ('Widget', 'Widget para dashboard', 'WIDGET', 'si', 10, 'sis_parametros/vista/widget/WidgetConfig.php', 3, '', 'WidgetConfig', 'PARAM');
select pxp.f_insert_tgui ('Archivos Excel', 'Archivos Excel', 'ARXLS', 'si', 10, 'sis_parametros/vista/plantilla_archivo_excel/PlantillaArchivoExcel.php', 3, '', 'PlantillaArchivoExcel', 'PARAM');
select pxp.f_insert_tgui ('Columnas Excel', 'columnas excel del archivo', 'COLXLS', 'si', 1, 'sis_parametros/vista/columnas_archivo_excel/ColumnasArchivoExcel.php', 4, '', 'ColumnasArchivoExcel', 'PARAM');
select pxp.f_insert_tgui ('Depto Relacionados', 'Depto Relacionados', 'DEPTO.8', 'no', 0, 'sis_parametros/vista/depto_depto/DeptoDepto.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Config. Variables', 'Config. Variables', 'DEPTO.9', 'no', 0, 'sis_parametros/vista/depto_var/DeptoVar.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Subir Plantilla', 'Subir Plantilla', 'DOCUME.1', 'no', 0, 'sis_parametros/vista/documento/subirPlantilla.php', 3, '', 'subirPlantilla', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'MONPAR.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Especialidad del Empleado', 'Especialidad del Empleado', 'APROC.1.3', 'no', 0, 'sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php', 6, '', 'FuncionarioEspecialidad', 'PARAM');
select pxp.f_insert_tgui ('Subir', 'Subir', 'CONIG.2', 'no', 0, 'sis_parametros/vista/concepto_ingas/subirImagenConcepto.php', 5, '', 'subirImagenConcepto', 'PARAM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Unidades de Medida', 'CONIG.3', 'no', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 5, '', 'UnidadMedida', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'CONIG.3.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 6, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Asignaciones Operativas', 'Asignaciones Operativas', 'ASI.1.3', 'no', 0, 'sis_organigrama/vista/uo_funcionario_ope/UoFuncionarioOpe.php', 4, '', 'Cuando el funcionario funcionalmente tiene otra dependencia diferente a la jerárquica', 'PARAM');
select pxp.f_insert_tgui ('Oficinas', 'Oficinas', 'ASI.1.1.3', 'no', 0, 'sis_organigrama/vista/oficina/Oficina.php', 5, '', 'Oficina', 'PARAM');
select pxp.f_insert_tgui ('Escalas Salariales', 'Escalas Salariales', 'ASI.1.1.4', 'no', 0, 'sis_organigrama/vista/escala_salarial/EscalaSalarial.php', 5, '', 'EscalaSalarial', 'PARAM');
select pxp.f_insert_tgui ('Servicios de la Oficina', 'Servicios de la Oficina', 'ASI.1.1.3.1', 'no', 0, 'sis_organigrama/vista/oficina_cuenta/OficinaCuenta.php', 6, '', 'OficinaCuenta', 'PARAM');
select pxp.f_insert_tgui ('Cargos', 'Cargos', 'ASI.1.2.2', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 5, '', 'Cargo', 'PARAM');
select pxp.f_insert_tgui ('Especialidad del Empleado', 'Especialidad del Empleado', 'ASI.1.2.1.3', 'no', 0, 'sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php', 6, '', 'FuncionarioEspecialidad', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.1.3.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Subir', 'Subir', 'WIDGET.1', 'no', 0, 'sis_parametros/vista/widget/subirImagen.php', 4, '', 'subirImagen', 'PARAM');
select pxp.f_insert_tgui ('Configuracion Lector', 'configuracion lector', 'CONFLECT', 'si', 10, 'sis_parametros/vista/conf_lector_mobile/ConfLectorMobile.php', 3, '', 'ConfLectorMobile', 'PARAM');
select pxp.f_insert_tgui ('Tipo Archivo', 'tipos de archivos', 'TIPOAR', 'si', 9, 'sis_parametros/vista/tipo_archivo/TipoArchivo.php', 3, '', 'TipoArchivo', 'PARAM');
select pxp.f_insert_tgui ('Tipo Centro de Costo', 'Tipo de Centro de Costo', 'TIPCC', 'si', 14, 'sis_parametros/vista/tipo_cc/TipoCcArb.php', 3, '', 'TipoCcArb', 'PARAM');
select pxp.f_insert_tgui ('Tipo Centro de Costo Trans.', 'Tipo Centro de Costo', 'TCC', 'si', 14, 'sis_parametros/vista/tipo_cc/TipoCc.php', 3, '', 'TipoCc', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'DEPTO.1.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 6, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'DEPTO.1.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 7, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'DEPTO.1.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 7, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'INSTIT.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 4, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'INSTIT.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 5, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'INSTIT.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 5, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVEE.2.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 4, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVEE.2.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 5, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVEE.2.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 5, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'APROC.1.1.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 9, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'APROC.1.1.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 10, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'APROC.1.1.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 10, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'ASI.1.2.1.1.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 9, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'ASI.1.2.1.1.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 10, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'ASI.1.2.1.1.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 10, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Usuarios', 'Usuarios', 'GQP.2', 'no', 0, 'sis_parametros/vista/usuarios_ep/UsuariosEp.php', 4, '', 'UsuariosEp', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'GQP.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'GQP.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 6, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'GQP.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 6, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'GQP.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 7, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'GQP.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 7, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('ConfLectorMobileDetalle', 'ConfLectorMobileDetalle', 'CONFLECT.1', 'no', 0, 'sis_parametros/vista/conf_lector_mobile_detalle/ConfLectorMobileDetalle.php', 4, '', 'ConfLectorMobileDetalle', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'TIPOAR.1', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 4, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'TIPOAR.1.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 5, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'TIPOAR.1.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 5, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('wsMensaje', 'web socket mensaje', 'WSME', 'si', 5, 'sis_parametros/vista/wsmensaje/Wsmensaje.php', 3, '', 'Wsmensaje', 'PARAM');
select pxp.f_insert_tgui ('Plantillas Var Deptos', 'Plantillas de Variables para Deptos', 'VARDEP', 'si', 2, 'sis_parametros/vista/subsistema_var/SubsistemaConf.php', 3, '', 'SubsistemaConf', 'PARAM');
select pxp.f_insert_tgui ('Proyecto EP', 'Proyecto EP proviene de ENDESIS', 'PRO', 'si', 5, 'sis_parametros/vista/proyecto/Proyecto.php', 3, '', 'Proyecto', 'PARAM');
select pxp.f_insert_tgui ('Categoria de Concepto', 'Categoria de Concepto', 'CATCON', 'si', 3, 'sis_parametros/vista/cat_concepto/CatConcepto.php', 4, '', 'CatConcepto', 'PARAM');
select pxp.f_insert_tgui ('Proveedor VoBo', 'Proveedor VoBo', 'PROVB', 'si', 4, 'sis_parametros/vista/proveedor/ProveedorVb.php', 4, '', 'ProveedorVb', 'PARAM');
select pxp.f_insert_tgui ('Proveedor Inicio', 'Proveedor Inicio de Trámite', 'PROVINI', 'si', 3, 'sis_parametros/vista/proveedor/ProveedorInicio.php', 4, '', 'ProveedorInicio', 'PARAM');
select pxp.f_insert_tgui ('Feriados', 'Registro de Feriados', 'FERIADO', 'si', 11, 'sis_parametros/vista/feriado/Feriado.php', 3, '', 'Feriado', 'PARAM');
select pxp.f_insert_tgui ('Usuario Externo', 'Usuario Externo', 'DEPTO.1.1.4', 'no', 0, 'sis_seguridad/vista/usuario_externo/UsuarioExterno.php', 5, '', 'UsuarioExterno', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DEPTO.1.1.4.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 6, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Cta Bancaria', 'Cta Bancaria', 'PROVEE.4', 'no', 0, 'sis_parametros/vista/proveedor_cta_bancaria/ProveedorCtaBancaria.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVEE.5', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 3, '', 'AntFormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVEE.6', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 3, '', 'FormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVEE.7', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 3, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Observaciones del WF', 'Observaciones del WF', 'PROVEE.8', 'no', 0, 'sis_workflow/vista/obs/Obs.php', 3, '', '80%', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVEE.4.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 4, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.4.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.4.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 6, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVEE.4.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 6, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVEE.4.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 7, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVEE.4.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 7, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVEE.6.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 4, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Subir ', 'Subir ', 'PROVEE.6.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 5, '', 'SubirArchivoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos de Origen', 'Documentos de Origen', 'PROVEE.6.1.2', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 5, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Histórico', 'Histórico', 'PROVEE.6.1.3', 'no', 0, 'sis_workflow/vista/documento_historico_wf/DocumentoHistoricoWf.php', 5, '', '30%', 'PARAM');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'PROVEE.6.1.4', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 5, '', '40%', 'PARAM');
select pxp.f_insert_tgui ('Pagos similares', 'Pagos similares', 'PROVEE.6.1.5', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepFilPlanPago.php', 5, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('73%', '73%', 'PROVEE.6.1.5.1', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepPlanPago.php', 6, '', 'RepPlanPago', 'PARAM');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'PROVEE.6.1.5.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 7, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'PROVEE.8.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 4, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'PROVEE.8.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 5, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Especialidad del Empleado', 'Especialidad del Empleado', 'PROVEE.8.1.2', 'no', 0, 'sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php', 5, '', 'FuncionarioEspecialidad', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.8.1.3', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVEE.8.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Join', 'Join', 'TIPOAR.2', 'no', 0, 'sis_parametros/vista/tipo_archivo_join/TipoArchivoJoin.php', 4, '', '40%', 'PARAM');
select pxp.f_insert_tgui ('Campos', 'Campos', 'TIPOAR.3', 'no', 0, 'sis_parametros/vista/tipo_archivo_campo/TipoArchivoCampo.php', 4, '', '40%', 'PARAM');
select pxp.f_insert_tgui ('Funcion', 'Funcion', 'VARDEP.1', 'no', 0, 'sis_seguridad/vista/funcion/Funcion.php', 4, '', 'funcion', 'PARAM');
select pxp.f_insert_tgui ('Variables', 'Variables', 'VARDEP.2', 'no', 0, 'sis_parametros/vista/subsistema_var/SubsistemaVar.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Video', 'Video', 'VARDEP.3', 'no', 0, 'sis_seguridad/vista/video/Video.php', 4, '', 'Video', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'VARDEP.4', 'no', 0, 'sis_seguridad/vista/gui/Gui.php', 4, '', 'gui', 'PARAM');
select pxp.f_insert_tgui ('Procedimientos', 'Procedimientos', 'VARDEP.1.1', 'no', 0, 'sis_seguridad/vista/procedimiento/Procedimiento.php', 5, '', 'procedimiento', 'PARAM');
select pxp.f_insert_tgui ('Procedimientos', 'Procedimientos', 'VARDEP.4.1', 'no', 0, 'sis_seguridad/vista/procedimiento_gui/ProcedimientoGui.php', 5, '', 'procedimiento_gui', 'PARAM');
select pxp.f_insert_tgui ('Cta Bancaria', 'Cta Bancaria', 'PROVB.1', 'no', 0, 'sis_parametros/vista/proveedor_cta_bancaria/ProveedorCtaBancaria.php', 5, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVB.2', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 5, '', 'AntFormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVB.3', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 5, '', 'FormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVB.4', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 5, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Observaciones del WF', 'Observaciones del WF', 'PROVB.5', 'no', 0, 'sis_workflow/vista/obs/Obs.php', 5, '', '80%', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVB.6', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVB.7', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 5, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVB.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVB.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVB.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVB.1.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 8, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVB.1.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 9, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVB.1.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 9, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVB.3.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 6, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Subir ', 'Subir ', 'PROVB.3.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 7, '', 'SubirArchivoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos de Origen', 'Documentos de Origen', 'PROVB.3.1.2', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 7, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Histórico', 'Histórico', 'PROVB.3.1.3', 'no', 0, 'sis_workflow/vista/documento_historico_wf/DocumentoHistoricoWf.php', 7, '', '30%', 'PARAM');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'PROVB.3.1.4', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 7, '', '40%', 'PARAM');
select pxp.f_insert_tgui ('Pagos similares', 'Pagos similares', 'PROVB.3.1.5', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepFilPlanPago.php', 7, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('73%', '73%', 'PROVB.3.1.5.1', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepPlanPago.php', 8, '', 'RepPlanPago', 'PARAM');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'PROVB.3.1.5.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 9, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'PROVB.5.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 6, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'PROVB.5.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 7, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Especialidad del Empleado', 'Especialidad del Empleado', 'PROVB.5.1.2', 'no', 0, 'sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php', 7, '', 'FuncionarioEspecialidad', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVB.5.1.3', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVB.5.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 8, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Cta Bancaria', 'Cta Bancaria', 'PROVINI.1', 'no', 0, 'sis_parametros/vista/proveedor_cta_bancaria/ProveedorCtaBancaria.php', 5, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVINI.2', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 5, '', 'AntFormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'PROVINI.3', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 5, '', 'FormEstadoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVINI.4', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 5, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Observaciones del WF', 'Observaciones del WF', 'PROVINI.5', 'no', 0, 'sis_workflow/vista/obs/Obs.php', 5, '', '80%', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVINI.6', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVINI.7', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 5, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVINI.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVINI.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVINI.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVINI.1.1.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 8, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVINI.1.1.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 9, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVINI.1.1.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 9, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Documentos del Proceso', 'Documentos del Proceso', 'PROVINI.3.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 6, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Subir ', 'Subir ', 'PROVINI.3.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 7, '', 'SubirArchivoWf', 'PARAM');
select pxp.f_insert_tgui ('Documentos de Origen', 'Documentos de Origen', 'PROVINI.3.1.2', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 7, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Histórico', 'Histórico', 'PROVINI.3.1.3', 'no', 0, 'sis_workflow/vista/documento_historico_wf/DocumentoHistoricoWf.php', 7, '', '30%', 'PARAM');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'PROVINI.3.1.4', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 7, '', '40%', 'PARAM');
select pxp.f_insert_tgui ('Pagos similares', 'Pagos similares', 'PROVINI.3.1.5', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepFilPlanPago.php', 7, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('73%', '73%', 'PROVINI.3.1.5.1', 'no', 0, 'sis_tesoreria/vista/plan_pago/RepPlanPago.php', 8, '', 'RepPlanPago', 'PARAM');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'PROVINI.3.1.5.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 9, '', '90%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'PROVINI.5.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 6, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'PROVINI.5.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 7, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Especialidad del Empleado', 'Especialidad del Empleado', 'PROVINI.5.1.2', 'no', 0, 'sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php', 7, '', 'FuncionarioEspecialidad', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVINI.5.1.3', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVINI.5.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 8, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'FERIADO.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Administrar', 'Administrar Funcionario', 'Adm', 'si', 8, 'sis_parametros/vista/administrador/Administrador.php', 3, '', 'Administrador', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'INSTIT.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 3, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INSTIT.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INSTIT.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'INSTIT.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 5, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'INSTIT.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 6, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'INSTIT.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 6, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'PROVEE.4.1.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 5, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.4.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.4.1.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVEE.4.1.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 7, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVEE.4.1.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 8, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVEE.4.1.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 8, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVEE.8.1.4', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 5, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'APROC.1.4', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 6, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'APROC.1.1.1.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 8, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.1.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 9, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.1.1.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 10, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'APROC.1.1.1.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 10, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'APROC.1.1.1.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 11, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'APROC.1.1.1.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 11, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'ASI.1.2.1.4', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 6, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'ASI.1.2.1.1.1.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 8, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.1.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 9, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.1.1.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 10, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'ASI.1.2.1.1.1.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 10, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'ASI.1.2.1.1.1.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 11, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'ASI.1.2.1.1.1.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 11, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'PROVB.1.1.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 7, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVB.1.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVB.1.1.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVB.1.1.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 9, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVB.1.1.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 10, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVB.1.1.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 10, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVB.5.1.4', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 7, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('InstitucionPersona', 'InstitucionPersona', 'PROVINI.1.1.2', 'no', 0, 'sis_parametros/vista/institucion_persona/InstitucionPersona.php', 7, '', 'Persona Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVINI.1.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVINI.1.1.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVINI.1.1.2.1.2', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 9, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'PROVINI.1.1.2.1.2.1', 'no', 0, 'sis_parametros/vista/archivo/upload.php', 10, '', 'subirArchivo', 'PARAM');
select pxp.f_insert_tgui ('ArchivoHistorico', 'ArchivoHistorico', 'PROVINI.1.1.2.1.2.2', 'no', 0, 'sis_parametros/vista/archivo/ArchivoHistorico.php', 10, '', 'ArchivoHistorico', 'PARAM');
select pxp.f_insert_tgui ('Archivo', 'Archivo', 'PROVINI.5.1.4', 'no', 0, 'sis_parametros/vista/archivo/Archivo.php', 7, '', 'Archivo', 'PARAM');
select pxp.f_insert_tgui ('Plantilla Tipo Centro de Costo', 'Plantilla Tipo de Centro de Costo', 'PTIPCC', 'si', 15, 'sis_parametros/vista/tipo_cc_plantilla/TipoCcArbPlantilla.php', 3, '', 'TipoCcArbPlantilla', 'PARAM');



/***********************************F-DAT-RCM-PARAM-1-27/10/2017*****************************************/


/***********************************I-DAT-EGS-PARAM-1-17/06/2019*****************************************/

select pxp.f_insert_tgui ('Plantilla Grilla', 'Plantilla Grilla', 'PLGR', 'si', 15, 'sis_parametros/vista/plantilla_grilla/PlantillaGrilla.php', 3, '', 'PlantillaGrilla', 'PARAM');
/***********************************F-DAT-EGS-PARAM-1-17/06/2019*****************************************/


/***********************************I-DAT-MANU-PARAM-1-25/07/2019*****************************************/

select pxp.f_insert_tgui ('Tazas Impuestos', 'Tazas Impuestos', 'TZIMP', 'si', 20, '/sis_parametros/vista/taza_impuesto/TazaImpuesto.php', 3, '', 'TazaImpuesto', 'PARAM');

/***********************************F-DAT-MANU-PARAM-1-25/07/2019*****************************************/
/***********************************I-DAT-EGS-PARAM-2-30/09/2019*****************************************/
INSERT INTO param.tunidad_medida ("id_usuario_reg","estado_reg", "codigo", "descripcion", "tipo")
VALUES
  (1, E'activo', E'dia', E'Días', E'Tiempo'),
  (1, E'activo', E'ha', E'Hectárea', E'Longitud'),
  (1, E'activo', E'm3', E'Metro cúbico', E'Longitud'),
  (1, E'activo', E'Gbl', E'Global', E'Longitud'),
  (1, E'activo', E'm2', E'Metro cuadrado', E'Longitud'),
  (1, E'activo', E'ml', E'Mililitro', E'Longitud'),
  (1, E'activo', E'Est', E'Estructuras', E'Masa'),
  (1, E'activo', E'puntos', E'Puntos', E'Masa');
/***********************************F-DAT-EGS-PARAM-2-30/09/2019*****************************************/


/***********************************I-DAT-SAZP-PARAM-82-14/11/2019*****************************************/
select pxp.f_insert_tgui ('Antiguedad', 'Registro parametros de antiguedad', 'ANTIG', 'si', 21, 'sis_parametros/vista/antiguedad/Antiguedad.php', 4, '', 'Antiguedad', 'PARAM');
/***********************************F-DAT-SAZP-PARAM-82-14/11/2019*****************************************/

/***********************************I-DAT-JRR-PARAM-0-26/11/2019*****************************************/
select pxp.f_insert_tgui ('Variable Global', 'Variable Global', 'VARGLOB', 'si', 1, 'sis_parametros/vista/variable_global/VariableGlobal.php', 3, '', 'VariableGlobal', 'PARAM');
select pxp.f_insert_testructura_gui ('VARGLOB', 'OTROS');
/***********************************F-DAT-JRR-PARAM-0-26/11/2019*****************************************/



/***********************************I-DAT-RAC-PARAM-0-20/04/2020*****************************************/


INSERT INTO param.tlenguaje ("id_usuario_reg", "codigo", "nombre", "defecto")
VALUES 
  (1, E'es', E'Español', E'si'),
  (1, E'en', E'English', E'no'),
  (1, E'fr', E'Français', E'no'),
  (1, E'pt', E'Potugues', E'no');


INSERT INTO param.tgrupo_idioma ("id_usuario_reg", "codigo", "nombre", "tipo")
VALUES 
  (1, E'BASICO', E'Grupo de traducciones basicas', E'comun');

  
/***********************************F-DAT-RAC-PARAM-0-20/04/2020*****************************************/

