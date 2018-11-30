<?php
/**
*@package pXP
*@file gen-MODBuzon.php
*@author  (eddy.gutierrez)
*@date 25-07-2018 23:43:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODBuzon extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarBuzon(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_buzon_sel';
		$this->transaccion='PM_BUZ_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_buzon','int4');
		$this->captura('fecha','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('sugerencia','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarBuzon(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_buzon_ime';
		$this->transaccion='PM_BUZ_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('sugerencia','sugerencia','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarBuzon(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_buzon_ime';
		$this->transaccion='PM_BUZ_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_buzon','id_buzon','int4');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('sugerencia','sugerencia','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarBuzon(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_buzon_ime';
		$this->transaccion='PM_BUZ_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_buzon','id_buzon','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>