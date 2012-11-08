<?php
/**
*@package pXP
*@file gen-MODProveedorItemServicio.php
*@author  (admin)
*@date 15-08-2012 18:56:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProveedorItemServicio extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProveedorItemServicio(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_proveedor_item_servicio_sel';
		$this->transaccion='PM_PRITSE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proveedor_item','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_servicio','int4');
		$this->captura('id_proveedor','int4');
		$this->captura('id_item','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_servicio','varchar');
		$this->captura('desc_item','varchar');
		$this->captura('item_servicio','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProveedorItemServicio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proveedor_item_servicio_ime';
		$this->transaccion='PM_PRITSE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_servicio','id_servicio','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('item_servicio','item_servicio','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProveedorItemServicio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proveedor_item_servicio_ime';
		$this->transaccion='PM_PRITSE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor_item','id_proveedor_item','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_servicio','id_servicio','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('item_servicio','item_servicio','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProveedorItemServicio(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proveedor_item_servicio_ime';
		$this->transaccion='PM_PRITSE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor_item','id_proveedor_item','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>