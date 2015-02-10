<?php
/**
*@package pXP
*@file MODEp.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 19:20:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_ep_sel';
		$this->transaccion='PM_FRPP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_ep','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_financiador','int4');
		$this->captura('id_prog_pory_acti','int4');
		$this->captura('id_regional','int4');
		$this->captura('sw_presto','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_programa','varchar');
		$this->captura('codigo_proyecto','varchar');
		$this->captura('codigo_actividad','varchar');
		
		$this->captura('nombre_programa','varchar');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('nombre_actividad','varchar');
		$this->captura('codigo_financiador','varchar');
		$this->captura('codigo_regional','varchar');
		$this->captura('nombre_financiador','varchar');
		$this->captura('nombre_regional','varchar');
		$this->captura('ep','text');
		$this->captura('desc_ppa','text');
		
	
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_ep_ime';
		$this->transaccion='PM_FRPP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_financiador','id_financiador','int4');
		$this->setParametro('id_prog_pory_acti','id_prog_pory_acti','int4');
		$this->setParametro('id_regional','id_regional','int4');
		$this->setParametro('sw_presto','sw_presto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_ep_ime';
		$this->transaccion='PM_FRPP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_financiador','id_financiador','int4');
		$this->setParametro('id_prog_pory_acti','id_prog_pory_acti','int4');
		$this->setParametro('id_regional','id_regional','int4');
		$this->setParametro('sw_presto','sw_presto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_ep_ime';
		$this->transaccion='PM_FRPP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ep','id_ep','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>