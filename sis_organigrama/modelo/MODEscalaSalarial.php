<?php
/**
*@package pXP
*@file gen-MODEscalaSalarial.php
*@author  (admin)
*@date 14-01-2014 00:28:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEscalaSalarial extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEscalaSalarial(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_escala_salarial_sel';
		$this->transaccion='OR_ESCSAL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_escala_salarial','int4');
		$this->captura('aprobado','varchar');
		$this->captura('id_categoria_salarial','int4');
		$this->captura('fecha_fin','date');
		$this->captura('estado_reg','varchar');
		$this->captura('haber_basico','numeric');
		$this->captura('fecha_ini','date');
		$this->captura('nombre','varchar');
		$this->captura('nro_casos','int4');
		$this->captura('codigo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarEscalaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_escala_salarial_ime';
		$this->transaccion='OR_ESCSAL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('aprobado','aprobado','varchar');
		$this->setParametro('id_categoria_salarial','id_categoria_salarial','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('haber_basico','haber_basico','numeric');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nro_casos','nro_casos','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEscalaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_escala_salarial_ime';
		$this->transaccion='OR_ESCSAL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_escala_salarial','id_escala_salarial','int4');
		$this->setParametro('aprobado','aprobado','varchar');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('haber_basico','haber_basico','numeric');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('nro_casos','nro_casos','int4');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEscalaSalarial(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_escala_salarial_ime';
		$this->transaccion='OR_ESCSAL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_escala_salarial','id_escala_salarial','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>