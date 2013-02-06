<?php
/**
*@package pXP
*@file MODActividad.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 15:45:34
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarActividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_actividad_sel';
		$this->transaccion='PM_ACT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo_actividad','varchar');
		$this->captura('descripcion_actividad','varchar');
		$this->captura('nombre_actividad','varchar');
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
			
	function insertarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_actividad_ime';
		$this->transaccion='PM_ACT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_actividad','codigo_actividad','varchar');
		$this->setParametro('descripcion_actividad','descripcion_actividad','varchar');
		$this->setParametro('nombre_actividad','nombre_actividad','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_actividad_ime';
		$this->transaccion='PM_ACT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_actividad','codigo_actividad','varchar');
		$this->setParametro('descripcion_actividad','descripcion_actividad','varchar');
		$this->setParametro('nombre_actividad','nombre_actividad','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_actividad_ime';
		$this->transaccion='PM_ACT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>