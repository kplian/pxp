<?php
/**
*@package pXP
*@file gen-MODUoFuncionarioOpe.php
*@author  (admin)
*@date 19-05-2015 17:53:09
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUoFuncionarioOpe extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUoFuncionarioOpe(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_uo_funcionario_ope_sel';
		$this->transaccion='OR_UOFO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_uo_funcionario_ope','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_uo','int4');
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
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
        $this->captura('desc_funcionario1','text');
        $this->captura('desc_funcionario2','text');
        $this->captura('num_doc','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarUoFuncionarioOpe(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_ope_ime';
		$this->transaccion='OR_UOFO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUoFuncionarioOpe(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_ope_ime';
		$this->transaccion='OR_UOFO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uo_funcionario_ope','id_uo_funcionario_ope','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha_asignacion','fecha_asignacion','date');
		$this->setParametro('fecha_finalizacion','fecha_finalizacion','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUoFuncionarioOpe(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_uo_funcionario_ope_ime';
		$this->transaccion='OR_UOFO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uo_funcionario_ope','id_uo_funcionario_ope','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>