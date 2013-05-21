<?php
/**
*@package pXP
*@file gen-MODDeptoEp.php
*@author  (admin)
*@date 29-04-2013 20:34:21
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDeptoEp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDeptoEp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_depto_ep_sel';
		$this->transaccion='PM_DEEP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setParametro('id_depto','id_depto','int4');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_depto_ep','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_depto','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('ep','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDeptoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_ep_ime';
		$this->transaccion='PM_DEEP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_depto','id_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDeptoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_ep_ime';
		$this->transaccion='PM_DEEP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_ep','id_depto_ep','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_depto','id_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDeptoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_ep_ime';
		$this->transaccion='PM_DEEP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_ep','id_depto_ep','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>