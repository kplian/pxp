<?php
/**
*@package pXP
*@file gen-MODTipoDocumentoEstado.php
*@author  (admin)
*@date 15-01-2014 03:12:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoDocumentoEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoDocumentoEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_documento_estado_sel';
		$this->transaccion='WF_DES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_documento_estado','int4');
		$this->captura('id_tipo_estado','int4');
		$this->captura('id_tipo_documento','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('momento','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_tipo_proceso','text');
		$this->captura('desc_tipo_estado','text');
		
		$this->captura('tipo_busqueda','varchar');
		$this->captura('regla','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoDocumentoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_estado_ime';
		$this->transaccion='WF_DES_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('momento','momento','varchar');
		
		$this->setParametro('tipo_busqueda','tipo_busqueda','varchar');
		$this->setParametro('regla','regla','codigo_html');
		
		
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoDocumentoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_estado_ime';
		$this->transaccion='WF_DES_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento_estado','id_tipo_documento_estado','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('momento','momento','varchar');
		
		$this->setParametro('tipo_busqueda','tipo_busqueda','varchar');
		$this->setParametro('regla','regla','codigo_html');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoDocumentoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_estado_ime';
		$this->transaccion='WF_DES_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento_estado','id_tipo_documento_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>