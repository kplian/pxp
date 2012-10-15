<?php
/**
*@package pXP
*@file gen-MODLugar.php
*@author  (rac)
*@date 29-08-2011 09:19:28
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLugar extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLugar(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_lugar_sel';
		$this->transaccion='PM_LUG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_lugar','int4');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_lugar_fk','int4');
		$this->captura('nombre','varchar');
		$this->captura('sw_impuesto','varchar');
		$this->captura('sw_municipio','varchar');
		$this->captura('tipo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
	
	
	function listarLugarArb(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_lugar_sel';
		$this-> setCount(false);
		$this->transaccion='PM_LUG_ARB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_padre','id_padre','varchar');		
		//$this->setParametro('id_subsistema','id_subsistema','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_lugar','int4');
		$this->captura('codigo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_lugar_fk','int4');
		$this->captura('nombre','varchar');
		$this->captura('sw_impuesto','varchar');
		$this->captura('sw_municipio','varchar');
		$this->captura('tipo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('tipo_nodo','varchar');
		$this->captura('codigo_largo','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLugar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_lugar_ime';
		$this->transaccion='PM_LUG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_lugar_fk','id_lugar_fk','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('sw_impuesto','sw_impuesto','varchar');
		$this->setParametro('sw_municipio','sw_municipio','varchar');
		$this->setParametro('tipo','tipo','varchar');
	

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLugar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_lugar_ime';
		$this->transaccion='PM_LUG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_lugar_fk','id_lugar_fk','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('sw_impuesto','sw_impuesto','varchar');
		$this->setParametro('sw_municipio','sw_municipio','varchar');
		$this->setParametro('tipo','tipo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLugar(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_lugar_ime';
		$this->transaccion='PM_LUG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_lugar','id_lugar','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>