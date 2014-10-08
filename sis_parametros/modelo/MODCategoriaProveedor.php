<?php
/**
*@package pXP
*@file gen-MODCategoriaProveedor.php
*@author  (gsarmiento)
*@date 06-10-2014 14:06:09
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCategoriaProveedor extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCategoriaProveedor(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_categoria_proveedor_sel';
		$this->transaccion='PM_CATPRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_categoria_proveedor','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_categoria','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarCategoriaProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_categoria_proveedor_ime';
		$this->transaccion='PM_CATPRO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_categoria','nombre_categoria','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCategoriaProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_categoria_proveedor_ime';
		$this->transaccion='PM_CATPRO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_categoria_proveedor','id_categoria_proveedor','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_categoria','nombre_categoria','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCategoriaProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_categoria_proveedor_ime';
		$this->transaccion='PM_CATPRO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_categoria_proveedor','id_categoria_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>