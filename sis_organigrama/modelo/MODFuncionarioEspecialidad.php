<?php
/**
*@package pXP
*@file gen-MODFuncionarioEspecialidad.php
*@author  (admin)
*@date 17-08-2012 17:48:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncionarioEspecialidad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncionarioEspecialidad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_funcionario_especialidad_sel';
		$this->transaccion='RH_RHESFU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcionario_especialidad','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_especialidad','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('fecha','date');
		$this->captura('numero_especialidad','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');
		
		
		//$this->captura('desc_especialidad','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFuncionarioEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_especialidad_ime';
		$this->transaccion='RH_RHESFU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('numero_especialidad','numero_especialidad','varchar');
		$this->setParametro('descripcion','descripcion','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncionarioEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_especialidad_ime';
		$this->transaccion='RH_RHESFU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_especialidad','id_funcionario_especialidad','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_especialidad','id_especialidad','int4');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('numero_especialidad','numero_especialidad','varchar');
		$this->setParametro('descripcion','descripcion','text');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncionarioEspecialidad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_funcionario_especialidad_ime';
		$this->transaccion='RH_RHESFU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_especialidad','id_funcionario_especialidad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>