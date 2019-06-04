<?php
/**
*@package pXP
*@file gen-MODTipoConceptoIngas.php
*@author  (egutierrez)
*@date 29-04-2019 13:28:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoConceptoIngas extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoConceptoIngas(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_concepto_ingas_sel';
		$this->transaccion='PM_TICOING_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_concepto_ingas','int4');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_concepto_ingas','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarTipoConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_concepto_ingas_ime';
		$this->transaccion='PM_TICOING_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_concepto_ingas_ime';
		$this->transaccion='PM_TICOING_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_concepto_ingas','id_tipo_concepto_ingas','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoConceptoIngas(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_concepto_ingas_ime';
		$this->transaccion='PM_TICOING_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_concepto_ingas','id_tipo_concepto_ingas','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarTipoConceptoIngasCombo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_concepto_ingas_sel';
		$this->transaccion='PM_TICOINGCOM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_concepto_ingas','int4');
		$this->captura('nombre_tipcoing','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_concepto_ingas','int4');

		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>