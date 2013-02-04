<?php
/**
*@package pXP
*@file gen-MODDeptoUo.php
*@author  (m)
*@date 19-10-2011 12:59:45
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDeptoUo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDeptoUo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_depto_uo_sel';
		$this->transaccion='PM_DEPUO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_depto','id_depto','integer');
		//Definicion de la lista del resultado del query
		$this->captura('id_depto_uo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_depto','int4');
		$this->captura('id_uo','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_depto','varchar');
		$this->captura('desc_uo','varchar');
		$this->captura('desc_depto_uo','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDeptoUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_uo_ime';
		$this->transaccion='PM_DEPUO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDeptoUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_uo_ime';
		$this->transaccion='PM_DEPUO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_uo','id_depto_uo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDeptoUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_depto_uo_ime';
		$this->transaccion='PM_DEPUO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_depto_uo','id_depto_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>