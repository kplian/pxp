<?php
/**
*@package pXP
*@file gen-MODCalendarioPlanificado.php
*@author  (admin)
*@date 02-11-2012 15:11:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCalendarioPlanificado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_calendario_planificado_sel';
		$this->transaccion='GEM_CALE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_calendario_planificado','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('tipo','varchar');
		$this->captura('fecha_fin','int4');
		$this->captura('observaciones','int4');
		$this->captura('fecha_ini','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','int4');
		$this->setParametro('observaciones','observaciones','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_calendario_planificado','id_calendario_planificado','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha_fin','fecha_fin','int4');
		$this->setParametro('observaciones','observaciones','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCalendarioPlanificado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_calendario_planificado_ime';
		$this->transaccion='GEM_CALE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_calendario_planificado','id_calendario_planificado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>