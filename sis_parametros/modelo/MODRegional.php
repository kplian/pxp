<?php
/**
*@package pXP
*@file MODRegional.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 23:27:42
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODRegional extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarRegional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_regional_sel';
		$this->transaccion='PM_REGIO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_regional','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_regional_actif','int4');
		$this->captura('nombre_regional','varchar');
		$this->captura('codigo_regional','varchar');
		$this->captura('descripcion_regional','text');
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
			
	function insertarRegional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_regional_ime';
		$this->transaccion='PM_REGIO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_regional_actif','id_regional_actif','int4');
		$this->setParametro('nombre_regional','nombre_regional','varchar');
		$this->setParametro('codigo_regional','codigo_regional','varchar');
		$this->setParametro('descripcion_regional','descripcion_regional','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarRegional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_regional_ime';
		$this->transaccion='PM_REGIO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_regional','id_regional','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_regional_actif','id_regional_actif','int4');
		$this->setParametro('nombre_regional','nombre_regional','varchar');
		$this->setParametro('codigo_regional','codigo_regional','varchar');
		$this->setParametro('descripcion_regional','descripcion_regional','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarRegional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_regional_ime';
		$this->transaccion='PM_REGIO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_regional','id_regional','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>