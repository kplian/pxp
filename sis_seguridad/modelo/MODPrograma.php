<?php
/**
*@package pXP
*@file gen-MODPrograma.php
*@author  (w)
*@date 13-08-2011 16:32:52
*@description Clase que env�a los par�metros requeridos a la Base de datos para la ejecuci�n de las funciones, y que recibe la respuesta del resultado de la ejecuci�n de las mismas
*/

class MODPrograma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPrograma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_programa_sel';
		$this->transaccion='SG_PROGRA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->setParametro('estado_reg','estado_reg','varchar');
			
		//Definicion de la lista del resultado del query
		$this->captura('id_programa','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
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
		$this->procedimiento='segu.ft_programa_ime';
		$this->transaccion='SG_PROGRA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPrograma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_programa_ime';
		$this->transaccion='SG_PROGRA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_programa','id_programa','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPrograma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_programa_ime';
		$this->transaccion='SG_PROGRA_ELI';
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