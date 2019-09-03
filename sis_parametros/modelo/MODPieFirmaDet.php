<?php
/**
*@package pXP
*@file gen-MODReporteColumna.php
*@author  (admin)
*@date 18-01-2014 02:56:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
#56         02/09/2019      MZM             CREACION
 * */

class MODPieFirmaDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPieFirmaDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_pie_firma_det_sel';
		$this->transaccion='PM_PIEFIRDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_pie_firma_det','int4');
		$this->captura('id_pie_firma','int4');
		$this->captura('id_cargo','int4');
		$this->captura('nombre','varchar');
		$this->captura('orden','int4');
		$this->captura('estado_reg','varchar');
		
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		
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
			
	function insertarPieFirmaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_det_ime';
		$this->transaccion='PM_PIEFIRDET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_pie_firma','id_pie_firma','int4');
		$this->setParametro('id_cargo','id_cargo','int4');
		$this->setParametro('orden','orden','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPieFirmaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_det_ime';
		$this->transaccion='PM_PIEFIRDET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_pie_firma_det','id_pie_firma_det','int4');
		$this->setParametro('id_pie_firma','id_pie_firma','int4');
		$this->setParametro('id_cargo','id_cargo','int4');
		
		$this->setParametro('orden','orden','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPieFirmaDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_det_ime';
		$this->transaccion='PM_PIEFIRDET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_pie_firma_det','id_pie_firma_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>