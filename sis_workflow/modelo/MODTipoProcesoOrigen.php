<?php
/**
*@package pXP
*@file gen-MODTipoProcesoOrigen.php
*@author  (admin)
*@date 09-06-2014 17:03:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoProcesoOrigen extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoProcesoOrigen(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_proceso_origen_sel';
		$this->transaccion='WF_TPO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_proceso_origin','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('id_tipo_estado','int4');
		$this->captura('id_proceso_macro','int4');
		$this->captura('funcion_validacion_wf','text');
		$this->captura('tipo_disparo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_tipo_estado','varchar');
		$this->captura('desc_proceso_macro','varchar');
		$this->captura('desc_tipo_proceso','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoProcesoOrigen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_origen_ime';
		$this->transaccion='WF_TPO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('funcion_validacion_wf','funcion_validacion_wf','text');
		$this->setParametro('tipo_disparo','tipo_disparo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoProcesoOrigen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_origen_ime';
		$this->transaccion='WF_TPO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso_origin','id_tipo_proceso_origin','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('funcion_validacion_wf','funcion_validacion_wf','text');
		$this->setParametro('tipo_disparo','tipo_disparo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoProcesoOrigen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_origen_ime';
		$this->transaccion='WF_TPO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso_origin','id_tipo_proceso_origin','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>