<?php
/**
*@package pXP
*@file FuncionesSeguridad.php
*@author Kplian (admin)
*@date 04/06/2011
*@description Clase Principal del esquema SEGU que incluye todas las clases del modelo para ejecucion de metodos y funciones de las tablas del mismo esquema
*/
class FuncionesSeguridad
{
	function __construct()
	{	
		foreach (glob('../../sis_seguridad/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}	
	}
	
	/*Clase: MODUsuario
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function ValidaUsuario(CTParametro $parametro){
		$usuario=new MODUsuario($parametro);
		$res=$usuario->ValidaUsuario();
		return $res;
	}
	
	function listarUsuario(CTParametro $parametro){
		$usuario=new  MODUsuario($parametro);
		$res=$usuario->listarUsuario();
		return $res;
	}
	
	function insertarUsuario(CTParametro $parametro){
		$usuario=new  MODUsuario($parametro);
		$res=$usuario->insertarUsuario();
		return $res;
	}
	
	function modificarUsuario(CTParametro $parametro){
		$usuario=new  MODUsuario($parametro);
		$res=$usuario->modificarUsuario();
		return $res;
	}
	
	function eliminarUsuario(CTParametro $parametro){
		$usuario=new  MODUsuario($parametro);
		$res=$usuario->eliminarUsuario();
		return $res;
	}
	/*FinClase: MODUsuario*/
	
	/*Clase: MODPrimo
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function obtenerPrimo(CTParametro $parametro){
		$primo=new MODPrimo($parametro);
		$res=$primo->ObtenerPrimo();
		return $res;
	}
	/*FinClase: MODPrimo*/
	
	/*Clase: MODGui
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarMenu(CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->listarMenu();
		return $res;
	}
	
	function listarGui(CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->listarGui();
		return $res;
	}
	
	function insertarGui(CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->insertarGui();
		return $res;
	}
	
	function modificarGui(CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->modificarGui();
		return $res;
	}
	
	
	function guardarGuiDragDrop( CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->guardarGuiDragDrop();
		return $res;
	}
	
	function eliminarGui( CTParametro $parametro){
		$gui=new MODGui($parametro);
		$res=$gui->eliminarGui();
		return $res;
	}
	/*FinClase: MODGui*/
	
	/*Clase: MODPersona
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarPersona(CTParametro $parametro){
	
		$persona=new  MODPersona($parametro);
		$res=$persona->listarPersona();
		return $res;
	}
	
	function listarPersonaFoto(CTParametro $parametro){
	
		$persona=new  MODPersona($parametro);
		$res=$persona->listarPersonaFoto();
		return $res;
	}
	
	
	function insertarPersona(CTParametro $parametro){
		
		$persona=new  MODPersona($parametro);
		$res=$persona->insertarPersona();
		return $res;
	}
	
	function modificarPersona(CTParametro $parametro){
		
		
		$persona=new  MODPersona($parametro);
		$res=$persona->modificarPersona();
		return $res;
	}
	
	function subirFotoPersona(CTParametro $parametro){
		$persona=new  MODPersona($parametro);
		$res=$persona->subirFotoPersona();
		return $res;
	}
	
	
	function eliminarPersona(CTParametro $parametro){
		$persona=new  MODPersona($parametro);
		$res=$persona->eliminarPersona();
		return $res;
	}
	/*FinClase: MODPersona*/
	
	
	/*Clase: MODActividad
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarActividad(CTParametro $parametro){
		$regional=new MODActividad($parametro);
		$res=$regional->listarActividad();
		return $res;
	}
	
	function insertarActividad(CTParametro $parametro){
		$regional=new MODActividad($parametro);
		$res=$regional->insertarActividad();
		return $res;
	}
	
	function modificarActividad(CTParametro $parametro){
		$regional=new MODActividad($parametro);
		$res=$regional->modificarActividad();
		return $res;
	}
	
	function eliminarActividad(CTParametro $parametro){
		$regional=new MODActividad($parametro);
		$res=$regional->eliminarActividad();
		return $res;
	}
	/*FinClase: MODActividad*/
	
	/*Clase: MODProyecto
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarProyecto(CTParametro $parametro){
		$regional=new MODProyecto($parametro);
		$res=$regional->listarProyecto();
		return $res;
	}
	
	function insertarProyecto(CTParametro $parametro){
		$regional=new MODProyecto($parametro);
		$res=$regional->insertarProyecto();
		return $res;
	}
	
	function modificarProyecto(CTParametro $parametro){
		$regional=new MODProyecto($parametro);
		$res=$regional->modificarProyecto();
		return $res;
	}
	
	function eliminarProyecto(CTParametro $parametro){
		$regional=new MODProyecto($parametro);
		$res=$regional->eliminarProyecto();
		return $res;
	}
	/*FinClase: MODProyecto*/
	
	/*Clase: MODClasificador
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarClasificador(CTParametro $parametro){
		$clasificador=new MODClasificador($parametro);
		$res=$clasificador->listarClasificador();
		return $res;
	}
	
	function insertarClasificador(CTParametro $parametro){
		$clasificador=new MODClasificador($parametro);
		$res=$clasificador->insertarClasificador();
		return $res;
	}
	
	function modificarClasificador(CTParametro $parametro){
		$clasificador=new MODClasificador($parametro);
		$res=$clasificador->modificarClasificador();
		return $res;
	}
	
	function eliminarClasificador(CTParametro $parametro){
		$clasificador=new MODClasificador($parametro);
		$res=$clasificador->eliminarClasificador();
		return $res;
	}
	/*FinClase: MODClasificador*/
	
	/*Clase: MODEstructuraDato
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarEstructuraDato(CTParametro $parametro){
		$estructura_dato=new MODEstructuraDato();
		$res=$estructura_dato->listarEstructuraDato($parametro);
		return $res;
	}
	
	function insertarEstructuraDato(CTParametro $parametro){
		$estructura_dato=new MODEstructuraDato();
		$res=$estructura_dato->insertarEstructuraDato($parametro);
		return $res;
	}
	
	function modificarEstructuraDato(CTParametro $parametro){
		$estructura_dato=new MODEstructuraDato();
		$res=$estructura_dato->modificarEstructuraDato($parametro);
		return $res;
	}
	
	function eliminarEstructuraDato(CTParametro $parametro){
		$estructura_dato=new MODEstructuraDato();
		$res=$estructura_dato->eliminarEstructuraDato($parametro);
		return $res;
	}
	/*FinClase: MODEstructuraDato*/
	
	/*Clase: MODRegional
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarRegional(CTParametro $parametro){
		$regional=new MODRegional($parametro);
		$res=$regional->listarRegional();
		return $res;
	}
	
	function insertarRegional(CTParametro $parametro){
		$regional=new MODRegional($parametro);
		$res=$regional->insertarRegional();
		return $res;
	}
	
	function modificarRegional(CTParametro $parametro){
		$regional=new MODRegional($parametro);
		$res=$regional->modificarRegional();
		return $res;
	}
	
	function eliminarRegional(CTParametro $parametro){
		$regional=new MODRegional($parametro);
		$res=$regional->eliminarRegional();
		return $res;
	}
	/*FinClase: MODRegional*/
	
	/*Clase: MODRol
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarRol(CTParametro $parametro){
		$rol=new MODRol($parametro);
		$res=$rol->listarRol();
		return $res;
	}
	
	function insertarRol(CTParametro $parametro){
		$rol=new MODRol($parametro);
		$res=$rol->insertarRol();
		return $res;
	}
	
	function modificarRol(CTParametro $parametro){
		$rol=new MODRol($parametro);
		$res=$rol->modificarRol();
		return $res;
	}
	
	function eliminarRol(CTParametro $parametro){
		$rol=new MODRol($parametro);
		$res=$rol->eliminarRol();
		return $res;
	}
	/*FinClase: MODRol*/
	
	/*Clase: MODUsuarioRol
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarUsuarioRol(CTParametro $parametro){
		$usuario_rol=new MODUsuarioRol($parametro);
		$res=$usuario_rol->listarUsuarioRol();
		return $res;
	}
	
	function insertarUsuarioRol(CTParametro $parametro){
		$usuario_rol=new MODUsuarioRol($parametro);
		$res=$usuario_rol->insertarUsuarioRol();
		return $res;
	}
	
	function modificarUsuarioRol(CTParametro $parametro){
		$usuario_rol=new MODUsuarioRol($parametro);
		$res=$usuario_rol->modificarUsuarioRol();
		return $res;
	}
	
	function eliminarUsuarioRol(CTParametro $parametro){
		$usuario_rol=new MODUsuarioRol($parametro);
		$res=$usuario_rol->eliminarUsuarioRol();
		return $res;
	}
	/*FinClase: MODUsuarioRol*/
	
	/*Clase: MODUsuarioRegional
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarUsuarioRegional(CTParametro $parametro){
		$usuario_regional=new MODUsuarioRegional();
		$res=$usuario_regional->listarUsuarioRegional($parametro);
		return $res;
	}
	
	function insertarUsuarioRegional(CTParametro $parametro){
		$usuario_regional=new MODUsuarioRegional();
		$res=$usuario_regional->insertarUsuarioRegional($parametro);
		return $res;
	}
	
	function modificarUsuarioRegional(CTParametro $parametro){
		$usuario_regional=new MODUsuarioRegional();
		$res=$usuario_regional->modificarUsuarioRegional($parametro);
		return $res;
	}
	
	function eliminarUsuarioRegional(CTParametro $parametro){
		$usuario_regional=new MODUsuarioRegional();
		$res=$usuario_regional->eliminarUsuarioRegional($parametro);
		return $res;
	}
	/*FinClase: MODUsuarioRegional*/
	
	/*Clase: MODUsuarioProyecto
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarUsuarioProyecto(CTParametro $parametro){
		$usuario_proyecto=new MODUsuarioProyecto();
		$res=$usuario_proyecto->listarUsuarioProyecto($parametro);
		return $res;
	}
	
	function insertarUsuarioProyecto(CTParametro $parametro){
		$usuario_proyecto=new MODUsuarioProyecto();
		$res=$usuario_proyecto->insertarUsuarioProyecto($parametro);
		return $res;
	}
	
	function modificarUsuarioProyecto(CTParametro $parametro){
		$usuario_proyecto=new MODUsuarioProyecto();
		$res=$usuario_proyecto->modificarUsuarioProyecto($parametro);
		return $res;
	}
	
	function eliminarUsuarioProyecto(CTParametro $parametro){
		$usuario_proyecto=new MODUsuarioProyecto();
		$res=$usuario_proyecto->eliminarUsuarioProyecto($parametro);
		return $res;
	}
	/*FinClase: MODUsuarioProyecto*/
	
	/*Clase: MODUsuarioActividad
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarUsuarioActividad(CTParametro $parametro){
		$usuario_actividad=new MODUsuarioActividad();
		$res=$usuario_actividad->listarUsuarioActividad($parametro);
		return $res;
	}
	
	function insertarUsuarioActividad(CTParametro $parametro){
		$usuario_actividad=new MODUsuarioActividad();
		$res=$usuario_actividad->insertarUsuarioActividad($parametro);
		return $res;
	}
	
	function modificarUsuarioActividad(CTParametro $parametro){
		$usuario_actividad=new MODUsuarioActividad();
		$res=$usuario_actividad->modificarUsuarioActividad($parametro);
		return $res;
	}
	
	function eliminarUsuarioActividad(CTParametro $parametro){
		$usuario_actividad=new MODUsuarioActividad();
		$res=$usuario_actividad->eliminarUsuarioActividad($parametro);
		return $res;
	}
	/*FinClase: MODUsuarioActividad*/

	/*Clase: MODTipoDocumento
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarTipoDocumento(CTParametro $parametro){
		$tipo_documento=new MODTipoDocumento($parametro);
		$res=$tipo_documento->listarTipoDocumento();
		return $res;
	}
	
	function insertarTipoDocumento(CTParametro $parametro){
		$tipo_documento=new MODTipoDocumento($parametro);
		$res=$tipo_documento->insertarTipoDocumento();
		return $res;
	}
	
	function modificarTipoDocumento(CTParametro $parametro){
		$tipo_documento=new MODTipoDocumento($parametro);
		$res=$tipo_documento->modificarTipoDocumento();
		return $res;
	}
	
	function eliminarTipoDocumento(CTParametro $parametro){
		$tipo_documento=new MODTipoDocumento($parametro);
		$res=$tipo_documento->eliminarTipoDocumento();
		return $res;
	}
	/*FinClase: MODTipoDocumento*/

	/*Clase: MODProcedimiento
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarProcedimientoCmb(CTParametro $parametro){
		$procedimiento=new MODProcedimiento($parametro);
		$res=$procedimiento->listarProcedimientoCmb();
		return $res;
	}
	
	function insertarProcedimiento(CTParametro $parametro){
		$procedimiento=new MODProcedimiento();
		$res=$procedimiento->insertarProcedimiento($parametro);
		return $res;
	}
	
	function modificarProcedimiento(CTParametro $parametro){
		$procedimiento=new MODProcedimiento();
		$res=$procedimiento->modificarProcedimiento($parametro);
		return $res;
	}
	
	function eliminarProcedimiento(CTParametro $parametro){
		$procedimiento=new MODProcedimiento();
		$res=$procedimiento->eliminarProcedimiento($parametro);
		return $res;
	}
	
	function listarProced(CTParametro $parametro){
		$procedimiento=new MODProcedimiento();
		$res=$procedimiento->listarProced($parametro);
		return $res;
	}
	/*FinClase: MODProcedimiento*/

	/*Clase: MODFuncion
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarFuncion(CTParametro $parametro){
		$funcion=new MODFuncion($parametro);
		$res=$funcion->listarFuncion();
		return $res;
	}
	
	function insertarFuncion(CTParametro $parametro){
		$funcion=new MODFuncion($parametro);
		$res=$funcion->insertarFuncion();
		return $res;
	}
	
	function modificarFuncion(CTParametro  $parametro){
		$funcion=new MODFuncion($parametro);
		$res=$funcion->modificarFuncion();
		return $res;
	}
	
	function eliminarFuncion(CTParametro $parametro){
		$funcion=new MODFuncion($parametro);
		$res=$funcion->eliminarFuncion();
		return $res;
	}
	
	function sincFunciones(CTParametro  $parametro){
		$funcion=new MODFuncion($parametro);
		$res=$funcion->sincFunciones();
		return $res;
	}
	/*FinClase: MODFuncion*/
	
	/*Clase: MODLog
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarLog(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarLog();
		return $res;
	}
	function listarLogHorario(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarLogHorario();
		return $res;
	}
	function listarLogMonitor(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarLogMonitor();
		return $res;
	}
	function listarMonitorEsquema(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarMonitorEsquema();
		return $res;
	}
	function listarMonitorTabla(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarMonitorTabla();
		return $res;
	}
	function listarMonitorFuncion(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarMonitorFuncion();
		return $res;
	}
	function listarMonitorIndice(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarMonitorIndice();
		return $res;
	}
	function listarMonitorRecursos(CTParametro $parametro){
		$log=new MODLog($parametro);
		$res=$log->listarMonitorRecursos();
		return $res;
	}
	/*FinClase: MODLog*/
	
	/*Clase: MODProcedimientoGui
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarProcedimientoGui(CTParametro $parametro){
		$procedimiento_gui=new MODProcedimientoGui($parametro);
		$res=$procedimiento_gui->listarProcedimientoGui();
		return $res;
	}
	
	function insertarProcedimientoGui(CTParametro $parametro){
		$procedimiento_gui=new MODProcedimientoGui($parametro);
		$res=$procedimiento_gui->insertarProcedimientoGui();
		return $res;
	}
	
	function modificarProcedimientoGui(CTParametro $parametro){
		$procedimiento_gui=new MODProcedimientoGui($parametro);
		$res=$procedimiento_gui->modificarProcedimientoGui();
		return $res;
	}
	
	function eliminarProcedimientoGui(CTParametro $parametro){
		$procedimiento_gui=new MODProcedimientoGui($parametro);
		$res=$procedimiento_gui->eliminarProcedimientoGui();
		return $res;
	}
	/*FinClase: MODProcedimientoGui*/
	
	/*Clase: MODGuiRol
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarGuiRol(CTParametro $parametro){
		$gui_rol=new MODGuiRol($parametro);
		$res=$gui_rol->listarGuiRol();
		return $res;
	}
	
    function insertarGuiRol(CTParametro $parametro){
		$gui_rol=new MODGuiRol($parametro);
		$res=$gui_rol->insertarGuiRol();
		return $res;
	}
	/*FinClase: MODGuiRol*/

	/*Clase: MODSesion
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function insertarSesion($sid, $ip, $id_usuario,$datos){
    	$gui_rol=new MODSesion();
		$res=$gui_rol->insertarSesion($sid, $ip, $id_usuario,$datos);
		return $res;
	}
	
   function recuparaSidBase($id_usuario){
    	$gui_rol=new MODSesion();
		$res=$gui_rol->recuparaSidBase($id_usuario);
		return $res;
	}
	/*FinClase: MODSesion*/

	/*Clase: MODSubsistema
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarSubsistema(CTParametro $parametro){
		$ss=new  MODSubsistema($parametro);
		$res=$ss->listarSubsistema();
		return $res;
	}
	
	function insertarSubsistema(CTParametro $parametro){
		$ss=new  MODSubsistema($parametro);
		$res=$ss->insertarSubsistema();
		return $res;
	}
	
	function modificarSubsistema(CTParametro $parametro){
		$ss=new  MODSubsistema($parametro);
		$res=$ss->modificarSubsistema();
		return $res;
	}
	
	function eliminarSubsistema(CTParametro $parametro){
		$ss=new  MODSubsistema($parametro);
		$res=$ss->eliminarSubsistema();
		return $res;
	}
	
	function exportarDatosSeguridad(CTParametro $parametro){
		$ss=new  MODSubsistema($parametro);
		$res=$ss->exportarDatosSeguridad();
		return $res;
	}
	/*FinClase: MODSubsistema*/

	/*Clase: MODPatronEvento
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarPatronEvento(CTParametro $parametro){
		$ss=new  MODPatronEvento($parametro);
		$res=$ss->listarPatronEvento();
		return $res;
	}
	
	function insertarPatronEvento(CTParametro $parametro){
		$ss=new  MODPatronEvento($parametro);
		$res=$ss->insertarPatronEvento();
		return $res;
	}
	
	function modificarPatronEvento(CTParametro $parametro){
		$ss=new  MODPatronEvento($parametro);
		$res=$ss->modificarPatronEvento();
		return $res;
	}
	
	function eliminarPatronEvento(CTParametro $parametro){
		$ss=new  MODPatronEvento($parametro);
		$res=$ss->eliminarPatronEvento();
		return $res;
	}
	/*FinClase: MODPatronEvento*/
	
	/*Clase: MODHorarioTrabajo
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarHorarioTrabajo(CTParametro $parametro){
		$ss=new  MODHorarioTrabajo($parametro);
		$res=$ss->listarHorarioTrabajo();
		return $res;
	}
	
	function insertarHorarioTrabajo(CTParametro $parametro){
		$ss=new  MODHorarioTrabajo($parametro);
		$res=$ss->insertarHorarioTrabajo();
		return $res;
	}
	
	function modificarHorarioTrabajo(CTParametro $parametro){
		$ss=new  MODHorarioTrabajo($parametro);
		$res=$ss->modificarHorarioTrabajo();
		return $res;
	}
	
	function eliminarHorarioTrabajo(CTParametro $parametro){
		$ss=new  MODHorarioTrabajo($parametro);
		$res=$ss->eliminarHorarioTrabajo();
		return $res;
	}
	/*FinClase: MODHorarioTrabajo*/
	
	/*Clase: MODBloqueoNotificacion
	* Fecha: 17-10-2011 07:01:56
	* Autor: admin*/
	function listarNotificacion(CTParametro $parametro){
		$ss=new  MODBloqueoNotificacion($parametro);
		$res=$ss->listarNotificacion();
		return $res;
	}
	function listarBloqueo(CTParametro $parametro){
		$ss=new  MODBloqueoNotificacion($parametro);
		$res=$ss->listarBloqueo();
		return $res;
	}
	function cambiarEstadoBloqueoNotificacion(CTParametro $parametro){
		$ss=new  MODBloqueoNotificacion($parametro);
		$res=$ss->cambiarEstadoBloqueoNotificacion();
		return $res;
	}
	/*FinClase: MODBloqueoNotificacion*/
	
	/*Clase: MODPrograma
	* Fecha: 17-10-2011 06:48:53
	* Autor: w*/
	function listarPrograma(CTParametro $parametro){
		$obj=new MODPrograma($parametro);
		$res=$obj->listarPrograma();
		return $res;
	}
			
	function insertarPrograma(CTParametro $parametro){
		$obj=new MODPrograma($parametro);
		$res=$obj->insertarPrograma();
		return $res;
	}
			
	function modificarPrograma(CTParametro $parametro){
		$obj=new MODPrograma($parametro);
		$res=$obj->modificarPrograma();
		return $res;
	}
			
	function eliminarPrograma(CTParametro $parametro){
		$obj=new MODPrograma($parametro);
		$res=$obj->eliminarPrograma();
		return $res;
	}
	/*FinClase: MODPrograma*/
	
	
	
	/*FinClase: MODBloqueoNotificacion*/
	
	/*Clase: MODEP
	* Fecha: 17-10-2011 06:48:53
	* Autor: w*/
	function listarEp(CTParametro $parametro){
		$obj=new MODEp($parametro);
		$res=$obj->listarEp();
		return $res;
	}
			
	function insertarEp(CTParametro $parametro){
		$obj=new MODEp($parametro);
		$res=$obj->insertarEp();
		return $res;
	}
			
	function modificarEp(CTParametro $parametro){
		$obj=new MODEp($parametro);
		$res=$obj->modificarEp();
		return $res;
	}
			
	function eliminarEp(CTParametro $parametro){
		$obj=new MODEp($parametro);
		$res=$obj->eliminarEp();
		return $res;
	}
	/*FinClase: MODPrograma*/
	
	/*Clase: MODConfigurar
	* Fecha: 01-12-2011 11:46
	* Autor: mflores*/
	function configurar(CTParametro $parametro)
	{
		$obj=new MODConfigurar($parametro);
		$res=$obj->configurar();
		return $res;
	}
	/*FinClase: MODConfigurar*/
	
	/*Clase: MODLibreta
	* Fecha: 18-06-2012 16:21:29
	* Autor: rac*/
	function listarLibreta(CTParametro $parametro){
		$obj=new MODLibreta($parametro);
		$res=$obj->listarLibreta();
		return $res;
	}
			
	function insertarLibreta(CTParametro $parametro){
		$obj=new MODLibreta($parametro);
		$res=$obj->insertarLibreta();
		return $res;
	}
			
	function modificarLibreta(CTParametro $parametro){
		$obj=new MODLibreta($parametro);
		$res=$obj->modificarLibreta();
		return $res;
	}
			
	function eliminarLibreta(CTParametro $parametro){
		$obj=new MODLibreta($parametro);
		$res=$obj->eliminarLibreta();
		return $res;
	}
	/*FinClase: MODLibreta*/


	/*Clase: MODLibretaHer
	* Fecha: 18-06-2012 16:45:50
	* Autor: rac*/
	function listarLibretaHer(CTParametro $parametro){
		$obj=new MODLibretaHer($parametro);
		$res=$obj->listarLibretaHer();
		return $res;
	}
			
	function insertarLibretaHer(CTParametro $parametro){
		$obj=new MODLibretaHer($parametro);
		$res=$obj->insertarLibretaHer();
		return $res;
	}
			
	function modificarLibretaHer(CTParametro $parametro){
		$obj=new MODLibretaHer($parametro);
		$res=$obj->modificarLibretaHer();
		return $res;
	}
			
	function eliminarLibretaHer(CTParametro $parametro){
		$obj=new MODLibretaHer($parametro);
		$res=$obj->eliminarLibretaHer();
		return $res;
	}
	/*FinClase: MODLibretaHer*/


}//marca_generador
?>