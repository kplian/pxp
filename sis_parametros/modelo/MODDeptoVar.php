<?php
/**
*@package pXP
*@file gen-MODDeptoVar.php
*@author  (admin)
*@date 22-11-2016 20:17:52
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDeptoVar extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDeptoVar(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_depto_var_sel';
		$this->transaccion='PM_DEVA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_depto_var','int4');
		$this->captura('valor','varchar');
		$this->captura('id_depto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_subsistema_var','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_subsistema_var','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDeptoVar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_var_ime';
		$this->transaccion='PM_DEVA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_subsistema_var','id_subsistema_var','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDeptoVar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_var_ime';
		$this->transaccion='PM_DEVA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_var','id_depto_var','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_subsistema_var','id_subsistema_var','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDeptoVar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_var_ime';
		$this->transaccion='PM_DEVA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_var','id_depto_var','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>