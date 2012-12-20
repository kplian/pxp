<?php
/**
*@package pXP
*@file gen-MODTipoHorario.php
*@author  (admin)
*@date 17-08-2012 16:28:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoHorario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoHorario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.f_tipo_horario_sel';
		$this->transaccion='RH_RHTIHO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_horario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
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
			
	function insertarTipoHorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tipo_horario_ime';
		$this->transaccion='RH_RHTIHO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoHorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tipo_horario_ime';
		$this->transaccion='RH_RHTIHO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_horario','id_tipo_horario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoHorario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_tipo_horario_ime';
		$this->transaccion='RH_RHTIHO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_horario','id_tipo_horario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>