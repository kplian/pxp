<?php
/**
*@package pXP
*@file gen-MODTablaMigrar.php
*@author  (admin)
*@date 16-01-2014 18:06:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTablaMigrar extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTablaMigrar(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_tabla_migrar_sel';
		$this->transaccion='SG_TBLMIG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tabla_migrar','int4');
		$this->captura('nombre_tabla','varchar');
		$this->captura('nombre_funcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarTablaMigrar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_tabla_migrar_ime';
		$this->transaccion='SG_TBLMIG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre_tabla','nombre_tabla','varchar');
		$this->setParametro('nombre_funcion','nombre_funcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTablaMigrar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_tabla_migrar_ime';
		$this->transaccion='SG_TBLMIG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla_migrar','id_tabla_migrar','int4');
		$this->setParametro('nombre_tabla','nombre_tabla','varchar');
		$this->setParametro('nombre_funcion','nombre_funcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTablaMigrar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_tabla_migrar_ime';
		$this->transaccion='SG_TBLMIG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tabla_migrar','id_tabla_migrar','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>