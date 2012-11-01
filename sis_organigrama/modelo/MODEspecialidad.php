<?php
/**
*@package pXP
*@file gen-MODEspecialidad.php
*@author  (admin)
*@date 17-08-2012 17:29:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEspecialidad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEspecialidad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.f_especialidad_sel';
		$this->transaccion='RH_ESPCIA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_especialidad','int4');
		$this->captura('codigo','varchar');
		$this->captura('id_especialidad_nivel','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_especialidad_nivel','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_especialidad_ime';
		$this->transaccion='RH_ESPCIA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_especialidad_nivel','id_especialidad_nivel','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_especialidad_ime';
		$this->transaccion='RH_ESPCIA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_especialidad_nivel','id_especialidad_nivel','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.f_especialidad_ime';
		$this->transaccion='RH_ESPCIA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_especialidad','id_especialidad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>