<?php
/**
*@package pXP
*@file gen-MODCategoriaSalarial.php
*@author  (admin)
*@date 13-01-2014 23:53:05
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCategoriaSalarial extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCategoriaSalarial(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_categoria_salarial_sel';
		$this->transaccion='OR_CATSAL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_categoria_salarial','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarCategoriaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_categoria_salarial_ime';
		$this->transaccion='OR_CATSAL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCategoriaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_categoria_salarial_ime';
		$this->transaccion='OR_CATSAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_categoria_salarial','id_categoria_salarial','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('incremento','incremento','numeric');
		$this->setParametro('fecha_ini','fecha_ini','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCategoriaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_categoria_salarial_ime';
		$this->transaccion='OR_CATSAL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_categoria_salarial','id_categoria_salarial','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>