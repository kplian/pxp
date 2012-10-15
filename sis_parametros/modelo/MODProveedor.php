<?php
/**
*@package pXP
*@file gen-MODProveedor.php
*@author  (mzm)
*@date 15-11-2011 10:44:58
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProveedor extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProveedor(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_tproveedor_sel';
		$this->transaccion='PM_PROVEE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proveedor','int4');
		$this->captura('id_persona','int4');
		$this->captura('codigo','varchar');
		
		$this->captura('numero_sigma','varchar');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_institucion','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','date');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','date');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('nombre','varchar');
		$this->captura('nit','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

    function listarProveedorCombos(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_tproveedor_sel';
		$this->transaccion='PM_PROVEEV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
	
        $this->captura('id_proveedor','INTEGER');
		$this->captura('id_persona','INTEGER');
		$this->captura('codigo','VARCHAR');
		$this->captura('numero_sigma','VARCHAR');
		$this->captura('tipo','VARCHAR');
		$this->captura('id_institucion','INTEGER');
		$this->captura('desc_proveedor','VARCHAR');
		$this->captura('nit','VARCHAR');
	
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

			
	function insertarProveedor(){ 
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tproveedor_ime';
		$this->transaccion='PM_PROVEE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('numero_sigma','numero_sigma','varchar');
		$this->setParametro('tipo','tipo','varchar');
		//$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('nit','nit','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tproveedor_ime';
		$this->transaccion='PM_PROVEE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('numero_sigma','numero_sigma','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('nit','nit','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProveedor(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tproveedor_ime';
		$this->transaccion='PM_PROVEE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor','id_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>