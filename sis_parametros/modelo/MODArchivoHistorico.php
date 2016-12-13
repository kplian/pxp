<?php
/**
*@package pXP
*@file gen-MODArchivoHistorico.php
*@author  (admin)
*@date 07-12-2016 21:54:02
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODArchivoHistorico extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarArchivoHistorico(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_archivo_historico_sel';
		$this->transaccion='PM_ARHIS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_archivo_historico','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('version','int4');
		$this->captura('id_archivo','varchar');
		$this->captura('id_tabla','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
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
			
	function insertarArchivoHistorico(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_archivo_historico_ime';
		$this->transaccion='PM_ARHIS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('version','version','int4');
		$this->setParametro('id_archivo','id_archivo','varchar');
		$this->setParametro('id_tabla','id_tabla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarArchivoHistorico(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_archivo_historico_ime';
		$this->transaccion='PM_ARHIS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_historico','id_archivo_historico','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('version','version','int4');
		$this->setParametro('id_archivo','id_archivo','varchar');
		$this->setParametro('id_tabla','id_tabla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarArchivoHistorico(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_archivo_historico_ime';
		$this->transaccion='PM_ARHIS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_historico','id_archivo_historico','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>