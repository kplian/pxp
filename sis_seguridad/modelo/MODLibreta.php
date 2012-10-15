<?php
/**
*@package pXP
*@file gen-MODLibreta.php
*@author  (rac)
*@date 18-06-2012 16:21:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLibreta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLibreta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.f_libreta_sel';
		$this->transaccion='SG_LIB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_libreta','int4');
		$this->captura('nombre','varchar');
		$this->captura('telefono','int4');
		$this->captura('obs','text');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLibreta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.f_libreta_ime';
		$this->transaccion='SG_LIB_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('telefono','telefono','int4');
		$this->setParametro('obs','obs','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLibreta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.f_libreta_ime';
		$this->transaccion='SG_LIB_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_libreta','id_libreta','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('telefono','telefono','int4');
		$this->setParametro('obs','obs','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLibreta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.f_libreta_ime';
		$this->transaccion='SG_LIB_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_libreta','id_libreta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>