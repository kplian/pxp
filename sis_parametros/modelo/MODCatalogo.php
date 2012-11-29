<?php
/**
*@package pXP
*@file gen-MODCatalogo.php
*@author  (admin)
*@date 16-11-2012 17:01:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCatalogo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCatalogo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_catalogo_sel';
		$this->transaccion='PM_CAT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_catalogo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_catalogo_tipo','integer');
		$this->captura('id_subsistema','integer');
        $this->captura('desc_subsistema','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_catalogo_tipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_ime';
		$this->transaccion='PM_CAT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_catalogo_tipo','id_catalogo_tipo','integer');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_ime';
		$this->transaccion='PM_CAT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo','id_catalogo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_catalogo_tipo','id_catalogo_tipo','integer');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCatalogo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_catalogo_ime';
		$this->transaccion='PM_CAT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_catalogo','id_catalogo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	//RCM, 29/11/2012, Listado de catálogos para combos específicos
	function listarCatalogoCombo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_catalogo_sel';
		$this->transaccion='PM_CATCMB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_catalogo','int4');
		$this->captura('id_catalogo_tipo','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('desc_catalogo_tipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>