<?php
/**
*@package pXP
*@file gen-MODCatalogo.php
*@author  (admin)
*@date 16-05-2014 22:55:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCatalogo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCatalogo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_catalogo_sel';
		$this->transaccion='WF_CATALO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_catalogo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_proceso_macro','int4');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_ai','int4');
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
			
	function insertarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_catalogo_ime';
		$this->transaccion='WF_CATALO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_usuario_ai','id_usuario_ai','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_catalogo_ime';
		$this->transaccion='WF_CATALO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo','id_catalogo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_usuario_ai','id_usuario_ai','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_catalogo_ime';
		$this->transaccion='WF_CATALO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo','id_catalogo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>