<?php
/**
*@package pXP
*@file gen-MODNumTramite.php
*@author  (admin)
*@date 19-02-2013 13:51:54
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODNumTramite extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarNumTramite(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_num_tramite_sel';
		$this->transaccion='WF_NUMTRAM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_num_tramite','int4');
		$this->captura('id_proceso_macro','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_gestion','int4');
		$this->captura('num_siguiente','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_gestion','varchar');
		$this->captura('codificacion_siguiente','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();		
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarNumTramite(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_num_tramite_ime';
		$this->transaccion='WF_NUMTRAM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('num_siguiente','num_siguiente','int4');		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarNumTramite(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_num_tramite_ime';
		$this->transaccion='WF_NUMTRAM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_num_tramite','id_num_tramite','int4');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('num_siguiente','num_siguiente','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarNumTramite(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_num_tramite_ime';
		$this->transaccion='WF_NUMTRAM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_num_tramite','id_num_tramite','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>