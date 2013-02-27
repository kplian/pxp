<?php
/**
*@package pXP
*@file gen-MODCentroCosto.php
*@author  (admin)
*@date 19-02-2013 22:53:59
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCentroCosto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCentroCosto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CEC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_uo','varchar');
		$this->captura('nombre_uo','varchar');
		$this->captura('ep','text');
		$this->captura('gestion','integer');
		$this->captura('codigo_cc','text');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CEC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>