<?php
/**
*@package pXP
*@file gen-MODIssues.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:15
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:15								CREACION

*/

class MODIssues extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarIssues(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_issues_sel';
		$this->transaccion='SG_ISS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_issues','int4');
		$this->captura('id_programador','int4');
		$this->captura('html_url','text');
		$this->captura('number_issues','int4');
		$this->captura('title','text');
		$this->captura('author','varchar');
		$this->captura('state','varchar');
		$this->captura('created_at','date');
		$this->captura('updated_at','date');
		$this->captura('closed_at','date');
		$this->captura('id_subsistema','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
    
			
}
?>