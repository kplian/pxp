<?php
/**
*@package pXP
*@file gen-MODOficina.php
*@author  (admin)
*@date 15-01-2014 16:05:34
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODOficina extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarOficina(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_oficina_sel';
		$this->transaccion='OR_OFI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_oficina','int4');
		$this->captura('aeropuerto','varchar');
		$this->captura('id_lugar','int4');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_lugar','varchar');
		$this->captura('zona_franca','varchar');
		$this->captura('frontera','varchar');
		$this->captura('correo_oficina','varchar');
		$this->captura('direccion','varchar');
		$this->captura('telefono','VARCHAR');
        $this->captura('orden','NUMERIC');
        


		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarOficina(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_ime';
		$this->transaccion='OR_OFI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('aeropuerto','aeropuerto','varchar');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('zona_franca','zona_franca','varchar');
		$this->setParametro('frontera','frontera','varchar');
        $this->setParametro('correo_oficina','correo_oficina','varchar');
        $this->setParametro('direccion','direccion','varchar');
        $this->setParametro('telefono','telefono','varchar');
        $this->setParametro('orden','orden','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarOficina(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_ime';
		$this->transaccion='OR_OFI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_oficina','id_oficina','int4');
		$this->setParametro('aeropuerto','aeropuerto','varchar');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('zona_franca','zona_franca','varchar');
		$this->setParametro('frontera','frontera','varchar');
        $this->setParametro('correo_oficina','correo_oficina','varchar');
		$this->setParametro('direccion','direccion','varchar');
        $this->setParametro('telefono','telefono','varchar');
        $this->setParametro('orden','orden','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarOficina(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_oficina_ime';
		$this->transaccion='OR_OFI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_oficina','id_oficina','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>