<?php
/**
*@package pXP
*@file gen-MODExtension.php
*@author  (admin)
*@date 23-12-2013 20:12:46
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODExtension extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarExtension(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_extension_sel';
		$this->transaccion='PM_EXT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_extension','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('peso_max_upload_mb','numeric');
		$this->captura('extension','varchar');
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
			
	function insertarExtension(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_ime';
		$this->transaccion='PM_EXT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('peso_max_upload_mb','peso_max_upload_mb','numeric');
		$this->setParametro('extension','extension','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarExtension(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_ime';
		$this->transaccion='PM_EXT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_extension','id_extension','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('peso_max_upload_mb','peso_max_upload_mb','numeric');
		$this->setParametro('extension','extension','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarExtension(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_ime';
		$this->transaccion='PM_EXT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_extension','id_extension','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>