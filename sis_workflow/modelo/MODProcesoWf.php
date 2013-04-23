<?php
/**
*@package pXP
*@file gen-MODProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProcesoWf extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProcesoWf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.f_proceso_wf_sel';
		$this->transaccion='WF_PWF_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proceso_wf','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('nro_tramite','varchar');
		$this->captura('id_estado_wf_prev','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_persona','int4');
		$this->captura('valor_cl','int8');
		$this->captura('id_institucion','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_proceso','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_estado_wf_prev','id_estado_wf_prev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('valor_cl','valor_cl','int8');
		$this->setParametro('id_institucion','id_institucion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_estado_wf_prev','id_estado_wf_prev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('valor_cl','valor_cl','int8');
		$this->setParametro('id_institucion','id_institucion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>