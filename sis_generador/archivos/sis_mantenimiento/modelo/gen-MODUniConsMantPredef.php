<?php
/**
*@package pXP
*@file gen-MODUniConsMantPredef.php
*@author  (admin)
*@date 02-11-2012 15:07:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsMantPredef extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsMantPredef(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_mant_predef_sel';
		$this->transaccion='GEM_MAPR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons_mant_predef','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('ult_fecha_mant','timestamp');
		$this->captura('id_unidad_medida','int4');
		$this->captura('id_uni_cons','int4');
		$this->captura('fecha_ini','timestamp');
		$this->captura('id_mant_predef','int4');
		$this->captura('frecuencia','int4');
		$this->captura('horas_dia','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarUniConsMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_mant_predef_ime';
		$this->transaccion='GEM_MAPR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('ult_fecha_mant','ult_fecha_mant','timestamp');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('fecha_ini','fecha_ini','timestamp');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('frecuencia','frecuencia','int4');
		$this->setParametro('horas_dia','horas_dia','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_mant_predef_ime';
		$this->transaccion='GEM_MAPR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_mant_predef','id_uni_cons_mant_predef','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('ult_fecha_mant','ult_fecha_mant','timestamp');
		$this->setParametro('id_unidad_medida','id_unidad_medida','int4');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		$this->setParametro('fecha_ini','fecha_ini','timestamp');
		$this->setParametro('id_mant_predef','id_mant_predef','int4');
		$this->setParametro('frecuencia','frecuencia','int4');
		$this->setParametro('horas_dia','horas_dia','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsMantPredef(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_mant_predef_ime';
		$this->transaccion='GEM_MAPR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_mant_predef','id_uni_cons_mant_predef','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>