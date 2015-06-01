<?php
/**
*@package pXP
*@file gen-MODTipoProceso.php
*@author  (admin)
*@date 21-02-2013 15:52:52
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoProceso extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoProceso(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_proceso_sel';
		$this->transaccion='WF_TIPPROC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('pm_relacionado','pm_relacionado','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_proceso','int4');
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('id_proceso_macro','int4');
		$this->captura('tabla','varchar');
		$this->captura('columna_llave','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_tipo_estado','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_proceso_macro','varchar');
		$this->captura('desc_tipo_estado','varchar');
		$this->captura('inicio','varchar');
		$this->captura('tipo_disparo','varchar');
		
		$this->captura('funcion_validacion_wf','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('codigo_llave','varchar');
		
		
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_ime';
		$this->transaccion='WF_TIPPROC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('columna_llave','columna_llave','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('tipo_disparo','tipo_disparo','varchar');
		$this->setParametro('funcion_validacion_wf','funcion_validacion_wf','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('codigo_llave','codigo_llave','varchar');
		
		
		
		
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_ime';
		$this->transaccion='WF_TIPPROC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('columna_llave','columna_llave','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('tipo_disparo','tipo_disparo','varchar');
		$this->setParametro('funcion_validacion_wf','funcion_validacion_wf','varchar');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('codigo_llave','codigo_llave','varchar');
        

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_ime';
		$this->transaccion='WF_TIPPROC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function obtenerSubsistemaTipoProceso(){
        //Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_proceso_ime';
		$this->transaccion='WF_TIPPROCSIS_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','integer');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
    }
			
}
?>