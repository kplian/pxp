<?php
/**
*@package pXP
*@file gen-MODPrograma.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 23:53:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPrograma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPrograma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_programa_sel';
		$this->transaccion='PM_PROG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_programa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_programa','varchar');
		$this->captura('id_programa_actif','int4');
		$this->captura('codigo_programa','varchar');
		$this->captura('descripcion_programa','text');
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
			
	function insertarPrograma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_ime';
		$this->transaccion='PM_PROG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_programa','nombre_programa','varchar');
		$this->setParametro('id_programa_actif','id_programa_actif','int4');
		$this->setParametro('codigo_programa','codigo_programa','varchar');
		$this->setParametro('descripcion_programa','descripcion_programa','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPrograma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_ime';
		$this->transaccion='PM_PROG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_programa','id_programa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_programa','nombre_programa','varchar');
		$this->setParametro('id_programa_actif','id_programa_actif','int4');
		$this->setParametro('codigo_programa','codigo_programa','varchar');
		$this->setParametro('descripcion_programa','descripcion_programa','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPrograma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_ime';
		$this->transaccion='PM_PROG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_programa','id_programa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>