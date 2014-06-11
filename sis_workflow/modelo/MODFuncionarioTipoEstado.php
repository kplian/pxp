<?php
/**
*@package pXP
*@file gen-MODFuncionarioTipoEstado.php
*@author  (admin)
*@date 15-03-2013 16:19:04
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFuncionarioTipoEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFuncionarioTipoEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_funcionario_tipo_estado_sel';
		$this->transaccion='WF_FUNCTEST_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_funcionario_tipo_estado','int4');
		$this->captura('id_labores_tipo_proceso','int4');
		$this->captura('id_tipo_estado','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_depto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
        $this->captura('desc_funcionario1','varchar');
        $this->captura('desc_depto','varchar');
		$this->captura('desc_labores','varchar');
		$this->captura('regla','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFuncionarioTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_funcionario_tipo_estado_ime';
		$this->transaccion='WF_FUNCTEST_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_labores_tipo_proceso','id_labores_tipo_proceso','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('regla','regla','codigo_html');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFuncionarioTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_funcionario_tipo_estado_ime';
		$this->transaccion='WF_FUNCTEST_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_tipo_estado','id_funcionario_tipo_estado','int4');
		$this->setParametro('id_labores_tipo_proceso','id_labores_tipo_proceso','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('regla','regla','codigo_html');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFuncionarioTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_funcionario_tipo_estado_ime';
		$this->transaccion='WF_FUNCTEST_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_funcionario_tipo_estado','id_funcionario_tipo_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>