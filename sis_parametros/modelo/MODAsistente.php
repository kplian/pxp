<?php
/**
*@package pXP
*@file gen-MODAsistente.php
*@author  (admin)
*@date 05-04-2013 14:02:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAsistente extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAsistente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_asistente_sel';
		$this->transaccion='PM_ASIS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_asistente','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_funcionario1','text');
		$this->captura('desc_uo','text');
		$this->captura('recursivo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAsistente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_asistente_ime';
		$this->transaccion='PM_ASIS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		//$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','varchar');
		$this->setParametro('id_estructura_uo','id_estructura_uo','varchar');
		$this->setParametro('recursivo','recursivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAsistente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_asistente_ime';
		$this->transaccion='PM_ASIS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_asistente','id_asistente','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('recursivo','recursivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAsistente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_asistente_ime';
		$this->transaccion='PM_ASIS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_asistente','id_asistente','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>