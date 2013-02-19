<?php
/**
*@package pXP
*@file MODCentroCosto.php
*@author  Gonzalo Sarmiento Sejas
*@date 18-02-2013 14:08:14
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCentroCosto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCentroCosto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_centro_costo_sel';
		$this->transaccion='PM_CCOST_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_centro_costo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo_pres','varchar');
		$this->captura('id_fuente_financiammiento','int4');
		$this->captura('id_parametro','int4');
		$this->captura('id_uo','int4');
		$this->captura('estado','varchar');
		$this->captura('cod_prg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_concepto_colectivo','int4');
		$this->captura('cod_fin','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_ep','int4');
		$this->captura('id_categoria_prog','int4');
		$this->captura('nombre_agrupador','varchar');
		$this->captura('cod_pry','varchar');
		$this->captura('cod_act','varchar');
		$this->captura('id_gestion','int4');
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
			
	function insertarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CCOST_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_pres','tipo_pres','varchar');
		$this->setParametro('id_fuente_financiammiento','id_fuente_financiammiento','int4');
		$this->setParametro('id_parametro','id_parametro','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('cod_prg','cod_prg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_colectivo','id_concepto_colectivo','int4');
		$this->setParametro('cod_fin','cod_fin','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_categoria_prog','id_categoria_prog','int4');
		$this->setParametro('nombre_agrupador','nombre_agrupador','varchar');
		$this->setParametro('cod_pry','cod_pry','varchar');
		$this->setParametro('cod_act','cod_act','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CCOST_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_pres','tipo_pres','varchar');
		$this->setParametro('id_fuente_financiammiento','id_fuente_financiammiento','int4');
		$this->setParametro('id_parametro','id_parametro','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('cod_prg','cod_prg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_colectivo','id_concepto_colectivo','int4');
		$this->setParametro('cod_fin','cod_fin','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_categoria_prog','id_categoria_prog','int4');
		$this->setParametro('nombre_agrupador','nombre_agrupador','varchar');
		$this->setParametro('cod_pry','cod_pry','varchar');
		$this->setParametro('cod_act','cod_act','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_centro_costo_ime';
		$this->transaccion='PM_CCOST_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_centro_costo','id_centro_costo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>