<?php
/**
*@package pXP
*@file gen-MODCargoCentroCosto.php
*@author  (admin)
*@date 15-01-2014 13:05:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCargoCentroCosto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCargoCentroCosto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_cargo_centro_costo_sel';
		$this->transaccion='OR_CARCC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_cargo_centro_costo','int4');
		$this->captura('id_cargo','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_centro_costo','int4');
		$this->captura('porcentaje','numeric');
		$this->captura('fecha_ini','date');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_centro_costo','text');
        $this->captura('id_ot','int4');
        $this->captura('desc_orden','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCargoCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_centro_costo_ime';
		$this->transaccion='OR_CARCC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo','id_cargo','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('porcentaje','porcentaje','numeric');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_ot','id_ot','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCargoCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_centro_costo_ime';
		$this->transaccion='OR_CARCC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo_centro_costo','id_cargo_centro_costo','int4');
		$this->setParametro('id_cargo','id_cargo','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_centro_costo','id_centro_costo','int4');
		$this->setParametro('porcentaje','porcentaje','numeric');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_ot','id_ot','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCargoCentroCosto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_centro_costo_ime';
		$this->transaccion='OR_CARCC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo_centro_costo','id_cargo_centro_costo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>