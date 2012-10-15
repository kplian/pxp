<?php
/**
*@package pXP
*@file gen-FuncionesMantenimiento.php
*@author  (rac)
*@date 15-08-2012 15:28:09
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de SISTEMA DE GESTION DE MANTENIMIENTO
*/

class FuncionesMantenimiento{
		
	function __construct(){
		foreach (glob('../../sis_mantenimiento/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODTipoVariable
	* Fecha: 15-08-2012 15:28:09
	* Autor: rac*/
	function listarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->listarTipoVariable();
		return $res;
	}
			
	function insertarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->insertarTipoVariable();
		return $res;
	}
			
	function modificarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->modificarTipoVariable();
		return $res;
	}
			
	function eliminarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->eliminarTipoVariable();
		return $res;
	}
	/*FinClase: MODTipoVariable*/

			
}//marca_generador
?>