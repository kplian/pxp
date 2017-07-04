<?php
/**
*@package pXP
*@file gen-MODMoneda.php
*@author  (admin)
*@date 05-02-2013 18:17:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMoneda extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMoneda(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_moneda_sel';
		$this->transaccion='PM_MONEDA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_moneda','int4');
		$this->captura('prioridad','int4');
		$this->captura('origen','varchar');
		$this->captura('tipo_actualizacion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('moneda','varchar');
		$this->captura('tipo_moneda','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('triangulacion','varchar');
		$this->captura('contabilidad','varchar');
		$this->captura('codigo_internacional','varchar');
		$this->captura('show_combo','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMoneda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_moneda_ime';
		$this->transaccion='PM_MONEDA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('origen','origen','varchar');
		$this->setParametro('tipo_actualizacion','tipo_actualizacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('moneda','moneda','varchar');
		$this->setParametro('tipo_moneda','tipo_moneda','varchar');
		$this->setParametro('triangulacion','triangulacion','varchar');
		$this->setParametro('contabilidad','contabilidad','varchar');
		$this->setParametro('codigo_internacional','codigo_internacional','varchar');
		$this->setParametro('show_combo','show_combo','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMoneda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_moneda_ime';
		$this->transaccion='PM_MONEDA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('origen','origen','varchar');
		$this->setParametro('tipo_actualizacion','tipo_actualizacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('moneda','moneda','varchar');
		$this->setParametro('tipo_moneda','tipo_moneda','varchar');
		$this->setParametro('triangulacion','triangulacion','varchar');
		$this->setParametro('contabilidad','contabilidad','varchar');
		$this->setParametro('codigo_internacional','codigo_internacional','varchar');
		$this->setParametro('show_combo','show_combo','varchar');
		
		
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMoneda(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_moneda_ime';
		$this->transaccion='PM_MONEDA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_moneda','id_moneda','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function getMonedaBase(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_moneda_ime';
		$this->transaccion='PM_MONBASE_GET';
		$this->tipo_procedimiento='IME';

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
		
}
?>