<?php
/**
*@package pXP
*@file gen-MODBranches.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:12								CREACION

*/

class MODBranches extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarBranches(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_branches_sel';
		$this->transaccion='SG_BAS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_branches','int4');
		$this->captura('name','varchar');
		$this->captura('sha','text');
		$this->captura('url','text');
		$this->captura('protected','bool');
		$this->captura('id_subsistema','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
}
?>