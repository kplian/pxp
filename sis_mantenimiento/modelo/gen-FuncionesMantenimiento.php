<?php
/**
*@package pXP
*@file gen-FuncionesMantenimiento.php
*@author  (admin)
*@date 02-11-2012 15:11:40
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de SISTEMA DE GESTION DE MANTENIMIENTO
*/

class FuncionesMantenimiento{
		
	function __construct(){
		foreach (glob('../../sis_mantenimiento/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODCalendarioPlanificado
	* Fecha: 02-11-2012 15:11:40
	* Autor: admin*/
	function listarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->listarCalendarioPlanificado();
		return $res;
	}
			
	function insertarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->insertarCalendarioPlanificado();
		return $res;
	}
			
	function modificarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->modificarCalendarioPlanificado();
		return $res;
	}
			
	function eliminarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->eliminarCalendarioPlanificado();
		return $res;
	}
	/*FinClase: MODCalendarioPlanificado*/

			
}//marca_generador
?>