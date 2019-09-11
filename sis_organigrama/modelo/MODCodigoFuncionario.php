<?php
/**
*@package pXP
*@file gen-MODCodigoFuncionario.php
*@author  (miguel.mamani)
*@date 10-09-2019 19:35:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCodigoFuncionario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCodigoFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_codigo_funcionario_sel';
		$this->transaccion='OR_CFO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_codigo_funcionario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('fecha_asignacion','date');
		$this->captura('fecha_finalizacion','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarCodigoFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_codigo_funcionario_ime';
		$this->transaccion='OR_CFO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCodigoFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_codigo_funcionario_ime';
		$this->transaccion='OR_CFO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_codigo_funcionario','id_codigo_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCodigoFuncionario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_codigo_funcionario_ime';
		$this->transaccion='OR_CFO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_codigo_funcionario','id_codigo_funcionario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>