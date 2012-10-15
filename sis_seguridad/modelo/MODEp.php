<?php
/**
*@package pXP
*@file gen-MODEp.php
*@author  (w)
*@date 18-10-2011 02:09:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_ep_sel';
		$this->transaccion='SG_ESP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_ep','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_actividad','int4');
		$this->captura('nombre_actividad','varchar');
		$this->captura('id_programa','int4');
		$this->captura('nombre_programa','varchar');
		$this->captura('id_proyecto','int4');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_ep_ime';
		$this->transaccion='SG_ESP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_programa','id_programa','int4');
		$this->setParametro('id_proyecto','id_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_ep_ime';
		$this->transaccion='SG_ESP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_programa','id_programa','int4');
		$this->setParametro('id_proyecto','id_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_ep_ime';
		$this->transaccion='SG_ESP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ep','id_ep','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>