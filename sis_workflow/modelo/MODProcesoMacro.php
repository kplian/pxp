<?php
/**
*@package pXP
*@file gen-MODProcesoMacro.php
*@author  (admin)
*@date 19-02-2013 13:51:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProcesoMacro extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.f_proceso_macro_sel';
		$this->transaccion='WF_PROMAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proceso_macro','int4');
		$this->captura('id_subsistema','int4');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('inicio','varchar');
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
			
	function insertarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProcesoMacro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_macro_ime';
		$this->transaccion='WF_PROMAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>