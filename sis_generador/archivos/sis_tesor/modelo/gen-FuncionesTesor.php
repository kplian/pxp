<?php
/**
*@package pXP
*@file gen-FuncionesTesor.php
*@author  (rac)
*@date 16-08-2012 01:18:04
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de Tesoreria
*/

class FuncionesTesor{
		
	function __construct(){
		foreach (glob('../../sis_tesor/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODConcepto
	* Fecha: 16-08-2012 01:18:04
	* Autor: rac*/
	function listarConcepto(CTParametro $parametro){
		$obj=new MODConcepto($parametro);
		$res=$obj->listarConcepto();
		return $res;
	}
			
	function insertarConcepto(CTParametro $parametro){
		$obj=new MODConcepto($parametro);
		$res=$obj->insertarConcepto();
		return $res;
	}
			
	function modificarConcepto(CTParametro $parametro){
		$obj=new MODConcepto($parametro);
		$res=$obj->modificarConcepto();
		return $res;
	}
			
	function eliminarConcepto(CTParametro $parametro){
		$obj=new MODConcepto($parametro);
		$res=$obj->eliminarConcepto();
		return $res;
	}
	/*FinClase: MODConcepto*/

			
}//marca_generador
?>