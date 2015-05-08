<?php
/**
*@package pXP
*@file gen-MODDeptoUsuario.php
*@author  (mzm)
*@date 24-11-2011 18:26:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDeptoUsuario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDeptoUsuario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.f_tdepto_usuario_sel';
		$this->transaccion='OR_DEPUSU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->setParametro('id_depto','id_depto','integer');	
		
		$this->captura('id_depto_usuario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_depto','int4');
		$this->captura('id_usuario','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_usuario','text');
		$this->captura('cargo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDeptoUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tdepto_usuario_ime';
		$this->transaccion='OR_DEPUSU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('cargo','cargo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDeptoUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tdepto_usuario_ime';
		$this->transaccion='OR_DEPUSU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_usuario','id_depto_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('cargo','cargo','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDeptoUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tdepto_usuario_ime';
		$this->transaccion='OR_DEPUSU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_usuario','id_depto_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>