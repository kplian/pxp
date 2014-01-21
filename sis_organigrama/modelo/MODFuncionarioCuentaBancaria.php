<?php
/**
*@package pXP
*@file gen-MODFuncionarioCuentaBancaria.php
*@author  (admin)
*@date 20-01-2014 14:16:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncionarioCuentaBancaria extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncionarioCuentaBancaria(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_funcionario_cuenta_bancaria_sel';
		$this->transaccion='OR_FUNCUE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcionario_cuenta_bancaria','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_institucion','int4');
		$this->captura('nro_cuenta','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('fecha_ini','date');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFuncionarioCuentaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_cuenta_bancaria_ime';
		$this->transaccion='OR_FUNCUE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncionarioCuentaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_cuenta_bancaria_ime';
		$this->transaccion='OR_FUNCUE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_cuenta_bancaria','id_funcionario_cuenta_bancaria','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncionarioCuentaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_cuenta_bancaria_ime';
		$this->transaccion='OR_FUNCUE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_cuenta_bancaria','id_funcionario_cuenta_bancaria','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>