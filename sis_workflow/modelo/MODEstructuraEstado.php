<?php
/**
*@package pXP
*@file gen-MODEstructuraEstado.php
*@author  (FRH)
*@date 21-02-2013 15:25:45
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEstructuraEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEstructuraEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_estructura_estado_sel';
		$this->transaccion='WF_ESTES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_estructura_estado','int4');
		$this->captura('id_tipo_estado_padre','int4');
		$this->captura('id_tipo_estado_hijo','int4');
		$this->captura('prioridad','int4');
		$this->captura('regla','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_estado_padre','text');
		$this->captura('desc_tipo_estado_hijo','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		return $this->respuesta;
	}
			
	function insertarEstructuraEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_estructura_estado_ime';
		$this->transaccion='WF_ESTES_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado_padre','id_tipo_estado_padre','int4');
		$this->setParametro('id_tipo_estado_hijo','id_tipo_estado_hijo','int4');
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('regla','regla','codigo_html');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEstructuraEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_estructura_estado_ime';
		$this->transaccion='WF_ESTES_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_estructura_estado','id_estructura_estado','int4');
		$this->setParametro('id_tipo_estado_padre','id_tipo_estado_padre','int4');
		$this->setParametro('id_tipo_estado_hijo','id_tipo_estado_hijo','int4');
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('regla','regla','codigo_html');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEstructuraEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_estructura_estado_ime';
		$this->transaccion='WF_ESTES_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_estructura_estado','id_estructura_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>