<?php
/**
*@package pXP
*@file gen-MODColumnaEstado.php
*@author  (admin)
*@date 07-05-2014 21:41:18
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODColumnaEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarColumnaEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_columna_estado_sel';
		$this->transaccion='WF_COLEST_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_columna_estado','int4');
		$this->captura('id_tipo_estado','int4');
		$this->captura('id_tipo_columna','int4');		
		$this->captura('estado_reg','varchar');
		$this->captura('momento','varchar');
		$this->captura('nombre_estado','varchar');		
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('regla','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarColumnaEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_columna_estado_ime';
		$this->transaccion='WF_COLEST_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_tipo_columna','id_tipo_columna','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('momento','momento','varchar');
		$this->setParametro('regla','regla','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarColumnaEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_columna_estado_ime';
		$this->transaccion='WF_COLEST_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_estado','id_columna_estado','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_tipo_columna','id_tipo_columna','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('momento','momento','varchar');
		$this->setParametro('regla','regla','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarColumnaEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_columna_estado_ime';
		$this->transaccion='WF_COLEST_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_estado','id_columna_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>