----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select wf.f_insert_tproceso_macro ('SOPTE', 'Soporte tecnico', 'si', 'activo', 'Work Flow');
select wf.f_insert_ttipo_proceso ('', 'Solicitud de soporte', 'ST', '', '', 'activo', 'si', 'SOPTE');
select wf.f_insert_ttipo_estado ('borrador', 'Borrador', 'si', 'no', 'no', 'listado', '', 'ninguno', '', '', 'activo', 'ST', '');
select wf.f_insert_ttipo_estado ('pendiente', 'Pendiente de asignacion', 'no', 'no', 'no', 'listado', '', 'ninguno', '', '', 'activo', 'ST', '');
select wf.f_insert_ttipo_estado ('asginado', 'TEC Asignado ', 'no', 'no', 'no', 'listado', '', 'ninguno', '', '', 'activo', 'ST', '');
select wf.f_insert_ttipo_estado ('finalizado', 'Finalizado', 'no', 'no', 'si', 'anterior', '', 'ninguno', '', '', 'activo', 'ST', '');
select wf.f_insert_testructura_estado ('borrador', 'ST', 'pendiente', 'ST', 1, '', 'activo');
select wf.f_insert_testructura_estado ('pendiente', 'ST', 'asginado', 'ST', 1, '', 'activo');
select wf.f_insert_testructura_estado ('asginado', 'ST', 'asginado', 'ST', 1, '', 'activo');
select wf.f_insert_testructura_estado ('asginado', 'ST', 'finalizado', 'ST', 1, '', 'activo');