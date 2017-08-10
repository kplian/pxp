<?php
/**
*@package pXP
*@file gen-MODTipoArchivoCampo.php
*@author  (favio.figueroa)
*@date 09-08-2017 19:39:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoArchivoCampo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoArchivoCampo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_archivo_campo_sel';
		$this->transaccion='PM_TIPCAM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_archivo_campo','int4');
		$this->captura('nombre','varchar');
		$this->captura('alias','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('renombrar','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_tipo_archivo','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarTipoArchivoCampo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_campo_ime';
		$this->transaccion='PM_TIPCAM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('alias','alias','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('renombrar','renombrar','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoArchivoCampo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_campo_ime';
		$this->transaccion='PM_TIPCAM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo_campo','id_tipo_archivo_campo','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('alias','alias','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('renombrar','renombrar','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoArchivoCampo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_campo_ime';
		$this->transaccion='PM_TIPCAM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo_campo','id_tipo_archivo_campo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>