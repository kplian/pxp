<?php
/**
*@package pXP
*@file gen-MODConceptoIngasDet.php
*@author  (admin)
*@date 22-07-2019 14:37:28
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
  ISSUE			AUTHOR			FECHA				DESCRIPCION
 * #39 ETR		EGS				31/07/2019			Creacion
 * */

class MODConceptoIngasDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_concepto_ingas_det_sel';
		$this->transaccion='PM_COIND_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

        $this->setParametro('groupBy','groupBy','varchar');	 //#24
        $this->setParametro('groupDir','groupDir','varchar'); //#24
				
		//Definicion de la lista del resultado del query
		$this->captura('id_concepto_ingas_det','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_concepto_ingas','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
        $this->captura('agrupador','varchar');
        $this->captura('id_concepto_ingas_det_fk','int4');
        $this->captura('desc_agrupador','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_det_ime';
		$this->transaccion='PM_COIND_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
        $this->setParametro('agrupador','agrupador','varchar');
        $this->setParametro('id_concepto_ingas_det_fk','id_concepto_ingas_det_fk','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_det_ime';
		$this->transaccion='PM_COIND_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas_det','id_concepto_ingas_det','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
        $this->setParametro('agrupador','agrupador','varchar');
        $this->setParametro('id_concepto_ingas_det_fk','id_concepto_ingas_det_fk','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConceptoIngasDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_det_ime';
		$this->transaccion='PM_COIND_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas_det','id_concepto_ingas_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>