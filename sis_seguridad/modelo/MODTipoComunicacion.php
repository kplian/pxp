<?php
/**
*@package pXP
*@file gen-MODTipoComunicacion.php
*@author  (admin)
*@date 08-01-2013 18:57:15
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoComunicacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoComunicacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.f_tipo_comunicacion_sel');
		$this->setTransaccion('SG_TICOM_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_comunicacion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
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
		return $this->getRespuesta();
	}
			
	function insertarTipoComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.f_tipo_comunicacion_ime');
		$this->setTransaccion('SG_TICOM_INS');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function modificarTipoComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.f_tipo_comunicacion_ime');
		$this->setTransaccion('SG_TICOM_MOD');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_comunicacion','id_tipo_comunicacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function eliminarTipoComunicacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.f_tipo_comunicacion_ime');
		$this->setTransaccion('SG_TICOM_ELI');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_comunicacion','id_tipo_comunicacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
}
?>