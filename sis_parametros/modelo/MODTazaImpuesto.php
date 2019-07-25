<?php
/**
*@package pXP
*@file gen-MODTazaImpuesto.php
*@author  (mguerra)
*@date 25-07-2019 19:23:20
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTazaImpuesto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTazaImpuesto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_taza_impuesto_sel';
		$this->transaccion='PM_TAZIMP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_taza_impuesto','int4');
		$this->captura('tipo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('factor_impuesto_pre','numeric');
		$this->captura('factor_impuesto','numeric');
		$this->captura('estado_reg','varchar');
		$this->captura('observacion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarTazaImpuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_taza_impuesto_ime';
		$this->transaccion='PM_TAZIMP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('factor_impuesto_pre','factor_impuesto_pre','numeric');
		$this->setParametro('factor_impuesto','factor_impuesto','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('observacion','observacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTazaImpuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_taza_impuesto_ime';
		$this->transaccion='PM_TAZIMP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_taza_impuesto','id_taza_impuesto','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('factor_impuesto_pre','factor_impuesto_pre','numeric');
		$this->setParametro('factor_impuesto','factor_impuesto','numeric');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('observacion','observacion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTazaImpuesto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_taza_impuesto_ime';
		$this->transaccion='PM_TAZIMP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_taza_impuesto','id_taza_impuesto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>