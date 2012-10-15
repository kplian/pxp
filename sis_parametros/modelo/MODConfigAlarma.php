<?php
/**
*@package pXP
*@file gen-MODConfigAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODConfigAlarma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarConfigAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_config_alarma_sel';
		$this->transaccion='PM_CONALA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->captura('id_config_alarma','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('dias','int4');
		$this->captura('id_subsistema','int4');
		$this->captura('desc_subsis','text');
		$this->captura('id_usuario_reg','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');		
		$this->captura('usr_reg','text');
		$this->captura('usr_mod','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarAlarmaTabla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_config_alarma_sel';
		$this->transaccion='PM_ALATABLA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->captura('table_schema','varchar');
		$this->captura('table_name','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}		
	function insertarConfigAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_config_alarma_ime';
		$this->transaccion='PM_CONALA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('dias','dias','int4');
		$this->setParametro('id_subsistema','id_subsistema','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarConfigAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_config_alarma_ime';
		$this->transaccion='PM_CONALA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_config_alarma','id_config_alarma','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('dias','dias','int4');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarConfigAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_config_alarma_ime';
		$this->transaccion='PM_CONALA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_config_alarma','id_config_alarma','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>