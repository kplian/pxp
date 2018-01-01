<?php
/**
*@package pXP
*@file gen-MODAdministrador.php
*@author  (admin)
*@date 29-12-2017 16:10:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAdministrador extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAdministrador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_administrador_sel';
		$this->transaccion='PM_ADMFUNLU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_administrador','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_lugar','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');
		$this->captura('desc_funcionario','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAdministrador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_administrador_ime';
		$this->transaccion='PM_ADMFUNLU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAdministrador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_administrador_ime';
		$this->transaccion='PM_ADMFUNLU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_administrador','id_administrador','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAdministrador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_administrador_ime';
		$this->transaccion='PM_ADMFUNLU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_administrador','id_administrador','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>