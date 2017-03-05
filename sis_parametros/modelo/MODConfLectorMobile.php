<?php
/**
*@package pXP
*@file gen-MODConfLectorMobile.php
*@author  (admin)
*@date 27-02-2017 01:01:56
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConfLectorMobile extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConfLectorMobile(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_conf_lector_mobile_sel';
		$this->transaccion='PM_CONFLEC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_conf_lector_mobile','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarConfLectorMobile(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_ime';
		$this->transaccion='PM_CONFLEC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConfLectorMobile(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_ime';
		$this->transaccion='PM_CONFLEC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_conf_lector_mobile','id_conf_lector_mobile','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConfLectorMobile(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_ime';
		$this->transaccion='PM_CONFLEC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_conf_lector_mobile','id_conf_lector_mobile','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function prueba(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_ime';
		$this->transaccion='PM_CONFLEC_PRU';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
		$this->setParametro('code','code','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>