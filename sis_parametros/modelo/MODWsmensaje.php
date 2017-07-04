<?php
/**
*@package pXP
*@file gen-MODWsmensaje.php
*@author  (favio.figueroa)
*@date 16-06-2017 21:47:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODWsmensaje extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarWsmensaje(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_wsmensaje_sel';
		$this->transaccion='PM_WSM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_wsmensaje','int4');
		$this->captura('id_usuario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('titulo','varchar');
		$this->captura('tipo','varchar');
		$this->captura('mensaje','text');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarWsmensaje(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_wsmensaje_ime';
		$this->transaccion='PM_WSM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('mensaje','mensaje','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarWsmensaje(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_wsmensaje_ime';
		$this->transaccion='PM_WSM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_wsmensaje','id_wsmensaje','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('mensaje','mensaje','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarWsmensaje(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_wsmensaje_ime';
		$this->transaccion='PM_WSM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_wsmensaje','id_wsmensaje','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>