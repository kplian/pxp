<?php
/**
*@package pXP
*@file gen-MODEspecialidadNivel.php
*@author  (admin)
*@date 26-08-2012 00:05:28
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEspecialidadNivel extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEspecialidadNivel(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_especialidad_nivel_sel';
		$this->transaccion='RH_RHNIES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_especialidad_nivel','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
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
			
	function insertarEspecialidadNivel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_especialidad_nivel_ime';
		$this->transaccion='RH_RHNIES_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEspecialidadNivel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_especialidad_nivel_ime';
		$this->transaccion='RH_RHNIES_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_especialidad_nivel','id_especialidad_nivel','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEspecialidadNivel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_especialidad_nivel_ime';
		$this->transaccion='RH_RHNIES_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_especialidad_nivel','id_especialidad_nivel','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>