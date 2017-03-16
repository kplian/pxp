<?php
/**
*@package pXP
*@file gen-MODConfLectorMobileDetalle.php
*@author  (admin)
*@date 27-02-2017 01:07:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConfLectorMobileDetalle extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConfLectorMobileDetalle(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_conf_lector_mobile_detalle_sel';
		$this->transaccion='PM_CONFLEM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_conf_lector_mobile_detalle','int4');
		$this->captura('control','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('activity','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_conf_lector_mobile','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarConfLectorMobileDetalle(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_detalle_ime';
		$this->transaccion='PM_CONFLEM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('control','control','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('activity','activity','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_conf_lector_mobile','id_conf_lector_mobile','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConfLectorMobileDetalle(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_detalle_ime';
		$this->transaccion='PM_CONFLEM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_conf_lector_mobile_detalle','id_conf_lector_mobile_detalle','int4');
		$this->setParametro('control','control','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('activity','activity','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_conf_lector_mobile','id_conf_lector_mobile','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConfLectorMobileDetalle(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_conf_lector_mobile_detalle_ime';
		$this->transaccion='PM_CONFLEM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_conf_lector_mobile_detalle','id_conf_lector_mobile_detalle','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>