<?php
/**
*@package pXP
*@file gen-MODConceptoIngasAgrupador.php
*@author  (egutierrez)
*@date 02-09-2019 21:07:26
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConceptoIngasAgrupador extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConceptoIngasAgrupador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_concepto_ingas_agrupador_sel';
		$this->transaccion='PM_COINAGR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_concepto_ingas_agrupador','int4');
		$this->captura('descripcion','varchar');
		$this->captura('tipo_agrupador','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarConceptoIngasAgrupador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_agrupador_ime';
		$this->transaccion='PM_COINAGR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo_agrupador','tipo_agrupador','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConceptoIngasAgrupador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_agrupador_ime';
		$this->transaccion='PM_COINAGR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas_agrupador','id_concepto_ingas_agrupador','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo_agrupador','tipo_agrupador','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConceptoIngasAgrupador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_concepto_ingas_agrupador_ime';
		$this->transaccion='PM_COINAGR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_concepto_ingas_agrupador','id_concepto_ingas_agrupador','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    function insertarAgrupador(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_concepto_ingas_agrupador_ime';
        $this->transaccion='PM_INSAGR_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_concepto_ingas','id_concepto_ingas','int4');
        $this->setParametro('id_concepto_ingas_agrupador','id_concepto_ingas_agrupador','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>