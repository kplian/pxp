<?php
/**
*@package pXP
*@file gen-MODGeneradorAlarma.php
*@author  (admin)
*@date 26-04-2013 10:31:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODGeneradorAlarma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarGeneradorAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_generador_alarma_sel';
		$this->transaccion='PM_GAL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_generador_alarma','int4');
		$this->captura('funcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarGeneradorAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_generador_alarma_ime';
		$this->transaccion='PM_GAL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('funcion','funcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarGeneradorAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_generador_alarma_ime';
		$this->transaccion='PM_GAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_generador_alarma','id_generador_alarma','int4');
		$this->setParametro('funcion','funcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarGeneradorAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_generador_alarma_ime';
		$this->transaccion='PM_GAL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_generador_alarma','id_generador_alarma','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>