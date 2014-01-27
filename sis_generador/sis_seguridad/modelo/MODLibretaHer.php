<?php
/**
*@package pXP
*@file gen-MODLibretaHer.php
*@author  (rac)
*@date 18-06-2012 16:45:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLibretaHer extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLibretaHer(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_libreta_her_sel';
		$this->transaccion='SG_LIB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_libreta_her','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('telefono','int4');
		$this->captura('nombre','varchar');
		$this->captura('obs','text');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLibretaHer(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_libreta_her_ime';
		$this->transaccion='SG_LIB_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('telefono','telefono','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('obs','obs','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLibretaHer(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_libreta_her_ime';
		$this->transaccion='SG_LIB_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_libreta_her','id_libreta_her','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('telefono','telefono','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('obs','obs','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLibretaHer(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_libreta_her_ime';
		$this->transaccion='SG_LIB_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_libreta_her','id_libreta_her','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		
		
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>