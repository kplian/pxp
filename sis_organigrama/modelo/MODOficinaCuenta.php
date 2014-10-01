<?php
/**
*@package pXP
*@file gen-MODOficinaCuenta.php
*@author  (jrivera)
*@date 31-07-2014 22:57:29
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODOficinaCuenta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarOficinaCuenta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_oficina_cuenta_sel';
		$this->transaccion='OR_OFCU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_oficina_cuenta','int4');
		$this->captura('id_oficina','int4');
		$this->captura('descripcion','text');
		$this->captura('estado_reg','varchar');
		$this->captura('nro_medidor','varchar');
		$this->captura('nro_cuenta','varchar');
		$this->captura('tiene_medidor','varchar');
		$this->captura('nombre_cuenta','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('oficina','varchar');
		$this->captura('lugar','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarOficinaCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_cuenta_ime';
		$this->transaccion='OR_OFCU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_oficina','id_oficina','int4');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_medidor','nro_medidor','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('tiene_medidor','tiene_medidor','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarOficinaCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_cuenta_ime';
		$this->transaccion='OR_OFCU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_oficina_cuenta','id_oficina_cuenta','int4');
		$this->setParametro('id_oficina','id_oficina','int4');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_medidor','nro_medidor','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('tiene_medidor','tiene_medidor','varchar');
		$this->setParametro('nombre_cuenta','nombre_cuenta','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarOficinaCuenta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_cuenta_ime';
		$this->transaccion='OR_OFCU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_oficina_cuenta','id_oficina_cuenta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>