<?php
/**
*@package pXP
*@file gen-MODMovimiento.php
*@author  (rac)
*@date 16-08-2012 00:59:54
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimiento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='tesor.f_movimiento_sel';
		$this->transaccion='TSR_MOV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nro_movimiento','int4');
		$this->captura('fecha','timestamp');
		$this->captura('id_persona_des','int4');
		$this->captura('id_concepto','int4');
		$this->captura('id_persona_or','int4');
		$this->captura('monto','numeric');
		$this->captura('detalle','text');
		$this->captura('estado','varchar');
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
			
	function insertarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.f_movimiento_ime';
		$this->transaccion='TSR_MOV_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_movimiento','nro_movimiento','int4');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('id_persona_des','id_persona_des','int4');
		$this->setParametro('id_concepto','id_concepto','int4');
		$this->setParametro('id_persona_or','id_persona_or','int4');
		$this->setParametro('monto','monto','numeric');
		$this->setParametro('detalle','detalle','text');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.f_movimiento_ime';
		$this->transaccion='TSR_MOV_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento','id_movimiento','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_movimiento','nro_movimiento','int4');
		$this->setParametro('fecha','fecha','timestamp');
		$this->setParametro('id_persona_des','id_persona_des','int4');
		$this->setParametro('id_concepto','id_concepto','int4');
		$this->setParametro('id_persona_or','id_persona_or','int4');
		$this->setParametro('monto','monto','numeric');
		$this->setParametro('detalle','detalle','text');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.f_movimiento_ime';
		$this->transaccion='TSR_MOV_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento','id_movimiento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>