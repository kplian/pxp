<?php
/**
*@package pXP
*@file gen-MODDeptoDepto.php
*@author  (admin)
*@date 08-09-2015 14:02:42
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDeptoDepto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDeptoDepto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_depto_depto_sel';
		$this->transaccion='PM_DEDE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_depto_depto','int4');
		$this->captura('id_depto_origen','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('obs','text');
		$this->captura('id_depto_destino','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_depto_destino','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDeptoDepto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_depto_ime';
		$this->transaccion='PM_DEDE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_origen','id_depto_origen','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obs','obs','text');
		$this->setParametro('id_depto_destino','id_depto_destino','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDeptoDepto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_depto_ime';
		$this->transaccion='PM_DEDE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_depto','id_depto_depto','int4');
		$this->setParametro('id_depto_origen','id_depto_origen','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obs','obs','text');
		$this->setParametro('id_depto_destino','id_depto_destino','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDeptoDepto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_depto_ime';
		$this->transaccion='PM_DEDE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_depto','id_depto_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>