<?php
/**
*@package pXP
*@file gen-FuncionesParametros.php
*@author  (admin)
*@date 08-08-2012 22:49:22
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de Parametros Generales
*/

class FuncionesParametros{
		
	function __construct(){
		foreach (glob('../../sis_parametros/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

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

			
}//marca_generador
?>