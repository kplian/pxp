<?php
/**
*@package pXP
*@file gen-MODColumnaConceptoIngasDet.php
*@author  (egutierrez)
*@date 06-09-2019 13:01:53
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODColumnaConceptoIngasDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarColumnaConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_columna_concepto_ingas_det_sel';
		$this->transaccion='PM_COLCIGD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_columna_concepto_ingas_det','int4');
		$this->captura('id_columna','int4');
		$this->captura('id_concepto_ingas_det','int4');
		$this->captura('valor','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarColumnaConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_concepto_ingas_det_ime';
		$this->transaccion='PM_COLCIGD_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna','id_columna','int4');
		$this->setParametro('id_concepto_ingas_det','id_concepto_ingas_det','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarColumnaConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_concepto_ingas_det_ime';
		$this->transaccion='PM_COLCIGD_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_concepto_ingas_det','id_columna_concepto_ingas_det','int4');
		$this->setParametro('id_columna','id_columna','int4');
		$this->setParametro('id_concepto_ingas_det','id_concepto_ingas_det','int4');
		$this->setParametro('valor','valor','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarColumnaConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_concepto_ingas_det_ime';
		$this->transaccion='PM_COLCIGD_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna_concepto_ingas_det','id_columna_concepto_ingas_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarColumnaConceptoIngasDetCombo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_columna_concepto_ingas_det_sel';
		$this->transaccion='PM_COLCIGDCB_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		
		$this->captura('id','integer');
		$this->captura('valor','varchar');

		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>