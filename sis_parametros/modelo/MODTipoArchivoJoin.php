<?php
/**
*@package pXP
*@file gen-MODTipoArchivoJoin.php
*@author  (favio.figueroa)
*@date 09-08-2017 20:03:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoArchivoJoin extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoArchivoJoin(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_archivo_join_sel';
		$this->transaccion='PM_TAJOIN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_archivo_join','int4');
		$this->captura('tipo','varchar');
		$this->captura('condicion','varchar');
		$this->captura('tabla','varchar');
		$this->captura('id_tipo_archivo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('alias','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoArchivoJoin(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_join_ime';
		$this->transaccion='PM_TAJOIN_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('condicion','condicion','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('alias','alias','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoArchivoJoin(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_join_ime';
		$this->transaccion='PM_TAJOIN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo_join','id_tipo_archivo_join','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('condicion','condicion','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('alias','alias','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoArchivoJoin(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_join_ime';
		$this->transaccion='PM_TAJOIN_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo_join','id_tipo_archivo_join','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>