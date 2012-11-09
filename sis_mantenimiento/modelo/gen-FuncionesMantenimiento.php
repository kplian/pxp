<?php
/**
*@package pXP
*@file gen-FuncionesMantenimiento.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de Mantenimiento Industrial - Plantas y Estaciones
*/

class FuncionesMantenimiento{
		
	function __construct(){
		foreach (glob('../../sis_mantenimiento/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODUniConsDet
	* Fecha: 08-11-2012 21:12:55
	* Autor: admin*/
	function listarUniConsDet(CTParametro $parametro){
		$obj=new MODUniConsDet($parametro);
		$res=$obj->listarUniConsDet();
		return $res;
	}
			
	function insertarUniConsDet(CTParametro $parametro){
		$obj=new MODUniConsDet($parametro);
		$res=$obj->insertarUniConsDet();
		return $res;
	}
			
	function modificarUniConsDet(CTParametro $parametro){
		$obj=new MODUniConsDet($parametro);
		$res=$obj->modificarUniConsDet();
		return $res;
	}
			
	function eliminarUniConsDet(CTParametro $parametro){
		$obj=new MODUniConsDet($parametro);
		$res=$obj->eliminarUniConsDet();
		return $res;
	}
	/*FinClase: MODUniConsDet*/

			
}//marca_generador
?>