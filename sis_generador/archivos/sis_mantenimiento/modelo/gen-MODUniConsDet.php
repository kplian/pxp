<?php
/**
*@package pXP
*@file gen-MODUniConsDet.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_det_sel';
		$this->transaccion='GM_UCDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons_det','int4');
		$this->captura('id_unidad_medida','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('codigo','int4');
		$this->captura('nombre','int4');
		$this->captura('descripcion','int4');
		$this->captura('valor','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('codigo','codigo','int4');
		$this->setParametro('nombre','nombre','int4');
		$this->setParametro('descripcion','descripcion','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_det','id_uni_cons_det','int4');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('codigo','codigo','int4');
		$this->setParametro('nombre','nombre','int4');
		$this->setParametro('descripcion','descripcion','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_det_ime';
		$this->transaccion='GM_UCDET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_det','id_uni_cons_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>