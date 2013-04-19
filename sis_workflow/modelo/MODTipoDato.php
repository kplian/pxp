<?php
/**
*@package pXP
*@file gen-MODTipoDato.php
*@author  (admin)
*@date 18-04-2013 23:08:25
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoDato extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoDato(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.f_tipo_dato_sel';
		$this->transaccion='WF_TDT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_dato','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('presicion','bool');
		$this->captura('descripcion','varchar');
		$this->captura('tipo','varchar');
		$this->captura('tamano','bool');
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
			
	function insertarTipoDato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_tipo_dato_ime';
		$this->transaccion='WF_TDT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('presicion','presicion','bool');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('tamano','tamano','bool');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoDato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_tipo_dato_ime';
		$this->transaccion='WF_TDT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_dato','id_tipo_dato','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('presicion','presicion','bool');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('tamano','tamano','bool');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoDato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_tipo_dato_ime';
		$this->transaccion='WF_TDT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_dato','id_tipo_dato','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>