<?php
/**
*@package pXP
*@file gen-MODPieFirma.php
*@author  (egutierrez)
*@date 07-08-2019 15:43:48
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
ISSUE       FECHA           AUTHOR          DESCRIPCION
#56         02/09/2019      MZM             CREACION
 */

class MODPieFirma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPieFirma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_pie_firma_sel';
		$this->transaccion='PM_PIEFIR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_pie_firma','int4');
		$this->captura('nombre','varchar');
		$this->captura('orientacion','varchar');
		$this->captura('estado_reg','varchar');
		
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
			
	function insertarPieFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_ime';
		$this->transaccion='PM_PIEFIR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('orientacion','orientacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPieFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_ime';
		$this->transaccion='PM_PIEFIR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_pie_firma','id_pie_firma','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('orientacion','orientacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPieFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_pie_firma_ime';
		$this->transaccion='PM_PIEFIR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_pie_firma','id_pie_firma','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>