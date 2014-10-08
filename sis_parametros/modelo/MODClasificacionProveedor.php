<?php
/**
*@package pXP
*@file gen-MODClasificacionProveedor.php
*@author  (gsarmiento)
*@date 06-10-2014 13:31:43
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODClasificacionProveedor extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarClasificacionProveedor(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_clasificacion_proveedor_sel';
		$this->transaccion='PM_CLAPRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_clasificacion_proveedor','int4');
		$this->captura('nombre_clasificacion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
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
			
	function insertarClasificacionProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_clasificacion_proveedor_ime';
		$this->transaccion='PM_CLAPRO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre_clasificacion','nombre_clasificacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarClasificacionProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_clasificacion_proveedor_ime';
		$this->transaccion='PM_CLAPRO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_clasificacion_proveedor','id_clasificacion_proveedor','int4');
		$this->setParametro('nombre_clasificacion','nombre_clasificacion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarClasificacionProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_clasificacion_proveedor_ime';
		$this->transaccion='PM_CLAPRO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_clasificacion_proveedor','id_clasificacion_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>