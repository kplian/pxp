<?php
/**
*@package pXP
*@file gen-MODFeriado.php
*@author  (admin)
*@date 27-10-2017 13:52:45
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFeriado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFeriado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_feriado_sel';
		$this->transaccion='PM_FERIA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_feriado','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('tipo','varchar');
		$this->captura('fecha','date');
		$this->captura('id_lugar','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_lugar','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFeriado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_feriado_ime';
		$this->transaccion='PM_FERIA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('id_lugar','id_lugar','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFeriado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_feriado_ime';
		$this->transaccion='PM_FERIA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_feriado','id_feriado','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('id_lugar','id_lugar','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFeriado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_feriado_ime';
		$this->transaccion='PM_FERIA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_feriado','id_feriado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>