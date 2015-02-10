<?php
/**
*@package pXP
*@file gen-MODTemporalCargo.php
*@author  (admin)
*@date 14-01-2014 00:28:33
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTemporalCargo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTemporalCargo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_temporal_cargo_sel';
		$this->transaccion='OR_TCARGO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_temporal_cargo','int4');
		$this->captura('id_temporal_jerarquia_aprobacion','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado','varchar');
		$this->captura('estado_reg','varchar');
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
			
	function insertarTemporalCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_temporal_cargo_ime';
		$this->transaccion='OR_TCARGO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_temporal_jerarquia_aprobacion','id_temporal_jerarquia_aprobacion','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTemporalCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_temporal_cargo_ime';
		$this->transaccion='OR_TCARGO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_temporal_cargo','id_temporal_cargo','int4');
		$this->setParametro('id_temporal_jerarquia_aprobacion','id_temporal_jerarquia_aprobacion','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTemporalCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_temporal_cargo_ime';
		$this->transaccion='OR_TCARGO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_temporal_cargo','id_temporal_cargo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>