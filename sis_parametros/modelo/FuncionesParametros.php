<?php
class FuncionesParametros
{
	
	function __construct(){
		foreach (glob('../../sis_parametros/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}
	
	/**	GESTION **/
	function ValidaGestion(CTParametro $parametro){
		$gestion=new MODGestion($parametro);
		$res=$gestion->ValidaGestion();
		return $res;
	}
	
	
	function listarGestion(CTParametro $parametro){
		$gestion=new  MODGestion($parametro);
		$res=$gestion->listarGestion();
		return $res;
	}
	
	function insertarGestion(CTParametro $parametro){
		$gestion=new  MODGestion($parametro);
		$res=$gestion->insertarGestion();
		return $res;
	}
	
	function modificarGestion(CTParametro $parametro){
		$gestion=new  MODGestion($parametro);
		$res=$gestion->modificarGestion();
		return $res;
	}
	
	function eliminarGestion(CTParametro $parametro){
		$gestion=new  MODGestion($parametro);
		$res=$gestion->eliminarGestion();
		return $res;
	}
	
	
	/**	PERIODO **/
	function ValidaPeriodo(CTParametro $parametro){
		$periodo=new MODPeriodo($parametro);
		$res=$periodo->ValidaPeriodo();
		return $res;
	}
	
	
	function listarPeriodo(CTParametro $parametro){
		$periodo=new  MODPeriodo($parametro);
		$res=$periodo->listarPeriodo();
		return $res;
	}
	
	function insertarPeriodo(CTParametro $parametro){
		$periodo=new  MODPeriodo($parametro);
		$res=$periodo->insertarPeriodo();
		return $res;
	}
	
	function modificarPeriodo(CTParametro $parametro){
		$periodo=new  MODPeriodo($parametro);
		$res=$periodo->modificarPeriodo();
		return $res;
	}
	
	function eliminarPeriodo(CTParametro $parametro){
		$periodo=new  MODPeriodo($parametro);
		$res=$periodo->eliminarPeriodo();
		return $res;
	}
	
	
	/***** MONEDA ****/
	function ValidaMoneda(CTParametro $parametro){
		$moneda=new MODMoneda($parametro);
		$res=$moneda->ValidaMoneda();
		return $res;
	}
	
	
	function listarMoneda(CTParametro $parametro){
		$moneda=new  MODMoneda($parametro);
		$res=$moneda->listarMoneda();
		return $res;
	}
	
	function insertarMoneda(CTParametro $parametro){
		$moneda=new  MODMoneda($parametro);
		$res=$moneda->insertarMoneda();
		return $res;
	}
	
	function modificarMoneda(CTParametro $parametro){
		$moneda=new  MODMoneda($parametro);
		$res=$moneda->modificarMoneda();
		return $res;
	}
	
	function eliminarMoneda(CTParametro $parametro){
		$moneda=new  MODMoneda($parametro);
		$res=$moneda->eliminarMoneda();
		return $res;
	}
	
	/*Clase: MODLugar
	* Fecha: 29-08-2011 09:19:28
	* Autor: rac*/
	function listarLugar(CTParametro $parametro){
		$obj=new MODLugar($parametro);
		$res=$obj->listarLugar();
		return $res;
	}
	
	function listarLugarArb(CTParametro $parametro){
		$obj=new MODLugar($parametro);
		$res=$obj->listarLugarArb();
		return $res;
	}
			
	function insertarLugar(CTParametro $parametro){
		$obj=new MODLugar($parametro);
		$res=$obj->insertarLugar();
		return $res;
	}
			
	function modificarLugar(CTParametro $parametro){
		$obj=new MODLugar($parametro);
		$res=$obj->modificarLugar();
		return $res;
	}
			
	function eliminarLugar(CTParametro $parametro){
		$obj=new MODLugar($parametro);
		$res=$obj->eliminarLugar();
		return $res;
	}
	/*FinClase: MODLugar*/


	/*Clase: MODInstitucion
	* Fecha: 21-09-2011 10:50:03
	* Autor: gvelasquez*/
	function listarInstitucion(CTParametro $parametro){
		$obj=new MODInstitucion($parametro);
		$res=$obj->listarInstitucion();
		return $res;
	}
			
	function insertarInstitucion(CTParametro $parametro){
		$obj=new MODInstitucion($parametro);
		$res=$obj->insertarInstitucion();
		return $res;
	}
			
	function modificarInstitucion(CTParametro $parametro){
		$obj=new MODInstitucion($parametro);
		$res=$obj->modificarInstitucion();
		return $res;
	}
			
	function eliminarInstitucion(CTParametro $parametro){
		$obj=new MODInstitucion($parametro);
		$res=$obj->eliminarInstitucion();
		return $res;
	}
	/*FinClase: MODInstitucion*/
	
		/*Clase: MODProyecto
	* Fecha: 26-10-2011 11:40:13
	* Autor: rac*/
	function listarProyecto(CTParametro $parametro){
		$obj=new MODProyectoEP($parametro);
		$res=$obj->listarProyecto();
		return $res;
	}
			
	function insertarProyecto(CTParametro $parametro){
		$obj=new MODProyectoEP($parametro);
		$res=$obj->insertarProyecto();
		return $res;
	}
			
	function modificarProyecto(CTParametro $parametro){
		$obj=new MODProyectoEP($parametro);
		$res=$obj->modificarProyecto();
		return $res;
	}
			
	function eliminarProyecto(CTParametro $parametro){
		$obj=new MODProyectoEP($parametro);
		$res=$obj->eliminarProyecto();
		return $res;
	}
	/*FinClase: MODProyecto*/

	
	/*Clase: MODProveedor
	* Fecha: 15-11-2011 10:44:58
	* Autor: mzm*/
	function listarProveedor(CTParametro $parametro){
		$obj=new MODProveedor($parametro);
		$res=$obj->listarProveedor();
		return $res;
	}
	
	function listarProveedorCombos(CTParametro $parametro){
		$obj=new MODProveedor($parametro);
		$res=$obj->listarProveedorCombos();
		return $res;
	}
			
	function insertarProveedor(CTParametro $parametro){
		$obj=new MODProveedor($parametro);
		$res=$obj->insertarProveedor();
		return $res;
	}
			
	function modificarProveedor(CTParametro $parametro){
		$obj=new MODProveedor($parametro);
		$res=$obj->modificarProveedor();
		return $res;
	}
			
	function eliminarProveedor(CTParametro $parametro){
		$obj=new MODProveedor($parametro);
		$res=$obj->eliminarProveedor();
		return $res;
	}
	/*FinClase: MODProveedor*/
    	/*Clase: MODAlarma
	* Fecha: 18-11-2011 11:59:10
	* Autor: fprudencio*/
	function listarAlarma(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->listarAlarma();
		return $res;
	}
	
	function listarAlarmaCorrespondeciaPendiente(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->listarAlarmaCorrespondeciaPendiente();
		return $res;
	}
	
	
	function alarmaPendiente(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->alarmaPendiente();
		return $res;
	}		
	function insertarAlarma(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->insertarAlarma();
		return $res;
	}
			
	function modificarAlarma(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->modificarAlarma();
		return $res;
	}
	
	function modificarEnvioCorreo(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->modificarEnvioCorreo();
		return $res;
	}
			
	function eliminarAlarma(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->eliminarAlarma();
		return $res;
	}
	
	function GeneraAlarma(CTParametro $parametro){
		$obj=new MODAlarma($parametro);
		$res=$obj->GeneraAlarma();
		return $res;
	}
	
	
	/*FinClase: MODAlarma*/

	/*Clase: MODDepto
	* Fecha: 2011
	* Autor: mzm*/
	function ValidaDepto(CTParametro $parametro){
		$depto=new MODDepto($parametro);
		$res=$depto->ValidaDepto();
		return $res;
	}
	
	function listarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->listarDepto();
		return $res;
	}
	
	function insertarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->insertarDepto();
		return $res;
	}
	
	function modificarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->modificarDepto();
		return $res;
	}
	
	function eliminarDepto(CTParametro $parametro){
		$depto=new  MODDepto($parametro);
		$res=$depto->eliminarDepto();
		return $res;
	}
	/*FinClase: MODDepto*/
	
	/*Clase: MODDocumento
	* Fecha: 2011
	* Autor: mzm*/
	function ValidaDocumento(CTParametro $parametro){
		$documento=new MODDocumento($parametro);
		$res=$documento->Valida();
		return $res;
	}
	
	function listarDocumento(CTParametro $parametro){
		$documento=new  MODDocumento($parametro);
		$res=$documento->listarDocumento();
		return $res;
	}
	
	function insertarDocumento(CTParametro $parametro){
		$documento=new  MODDocumento($parametro);
		$res=$documento->insertarDocumento();
		return $res;
	}
	
	function modificarDocumento(CTParametro $parametro){
		$documento=new  MODDocumento($parametro);
		$res=$documento->modificarDocumento();
		return $res;
	}
	
	function eliminarDocumento(CTParametro $parametro){
		$documento=new  MODDocumento($parametro);
		$res=$documento->eliminarDocumento();
		return $res;
	}
	/*FinClase: MODDocumento*/

	/*Clase: MODDeptoUo
	* Fecha: 19-10-2011 12:59:45
	* Autor: mzm*/
	function listarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->listarDeptoUo();
		return $res;
	}
			
	function insertarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->insertarDeptoUo();
		return $res;
	}
			
	function modificarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->modificarDeptoUo();
		return $res;
	}
			
	function eliminarDeptoUo(CTParametro $parametro){
		$obj=new MODDeptoUo($parametro);
		$res=$obj->eliminarDeptoUo();
		return $res;
	}
	
	/*Clase: MODDeptoUsuario
	* Fecha: 24-11-2011 18:26:47
	* Autor: mzm*/
	function listarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->listarDeptoUsuario();
		return $res;
	}
			
	function insertarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->insertarDeptoUsuario();
		return $res;
	}
			
	function modificarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->modificarDeptoUsuario();
		return $res;
	}
			
	function eliminarDeptoUsuario(CTParametro $parametro){
		$obj=new MODDeptoUsuario($parametro);
		$res=$obj->eliminarDeptoUsuario();
		return $res;
	}
	/*FinClase: MODDeptoUsuario*/
		
    	/*Clase: MODConfigAlarma
	* Fecha: 18-11-2011 11:59:10
	* Autor: fprudencio*/
	function listarConfigAlarma(CTParametro $parametro){
		$obj=new MODConfigAlarma($parametro);
		$res=$obj->listarConfigAlarma();
		return $res;
	}
	function listarAlarmaTabla(CTParametro $parametro){
		$obj=new MODConfigAlarma($parametro);
		$res=$obj->listarAlarmaTabla();
		return $res;
	}
	function insertarConfigAlarma(CTParametro $parametro){
		$obj=new MODConfigAlarma($parametro);
		$res=$obj->insertarConfigAlarma();
		return $res;
	}
			
	function modificarConfigAlarma(CTParametro $parametro){
		$obj=new MODConfigAlarma($parametro);
		$res=$obj->modificarConfigAlarma();
		return $res;
	}
			
	function eliminarConfigAlarma(CTParametro $parametro){
		$obj=new MODConfigAlarma($parametro);
		$res=$obj->eliminarConfigAlarma();
		return $res;
	}
	
	
	
	/*FinClase: MODConfigAlarma*/
	/*Clase: MODUnidadMedida
	* Fecha: 08-08-2012 22:49:22
	* Autor: admin*/
	function listarUnidadMedida(CTParametro $parametro){
		$obj=new MODUnidadMedida($parametro);
		$res=$obj->listarUnidadMedida();
		return $res;
	}
			
	function insertarUnidadMedida(CTParametro $parametro){
		$obj=new MODUnidadMedida($parametro);
		$res=$obj->insertarUnidadMedida();
		return $res;
	}
			
	function modificarUnidadMedida(CTParametro $parametro){
		$obj=new MODUnidadMedida($parametro);
		$res=$obj->modificarUnidadMedida();
		return $res;
	}
			
	function eliminarUnidadMedida(CTParametro $parametro){
		$obj=new MODUnidadMedida($parametro);
		$res=$obj->eliminarUnidadMedida();
		return $res;
	}
	/*FinClase: MODUnidadMedida*/


	/*Clase: MODProveedorItemServicio
	* Fecha: 15-08-2012 18:56:19
	* Autor: admin*/
	function listarProveedorItemServicio(CTParametro $parametro){
		$obj=new MODProveedorItemServicio($parametro);
		$res=$obj->listarProveedorItemServicio();
		return $res;
	}
			
	function insertarProveedorItemServicio(CTParametro $parametro){
		$obj=new MODProveedorItemServicio($parametro);
		$res=$obj->insertarProveedorItemServicio();
		return $res;
	}
			
	function modificarProveedorItemServicio(CTParametro $parametro){
		$obj=new MODProveedorItemServicio($parametro);
		$res=$obj->modificarProveedorItemServicio();
		return $res;
	}
			
	function eliminarProveedorItemServicio(CTParametro $parametro){
		$obj=new MODProveedorItemServicio($parametro);
		$res=$obj->eliminarProveedorItemServicio();
		return $res;
	}
	/*FinClase: MODProveedorItemServicio*/


	/*Clase: MODServicio
	* Fecha: 16-08-2012 23:48:42
	* Autor: admin*/
	function listarServicio(CTParametro $parametro){
		$obj=new MODServicio($parametro);
		$res=$obj->listarServicio();
		return $res;
	}
			
	function insertarServicio(CTParametro $parametro){
		$obj=new MODServicio($parametro);
		$res=$obj->insertarServicio();
		return $res;
	}
			
	function modificarServicio(CTParametro $parametro){
		$obj=new MODServicio($parametro);
		$res=$obj->modificarServicio();
		return $res;
	}
			
	function eliminarServicio(CTParametro $parametro){
		$obj=new MODServicio($parametro);
		$res=$obj->eliminarServicio();
		return $res;
	}
	/*FinClase: MODServicio*/


}//marca_generador
?>