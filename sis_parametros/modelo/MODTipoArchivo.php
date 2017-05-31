<?php
/**
*@package pXP
*@file gen-MODTipoArchivo.php
*@author  (admin)
*@date 05-12-2016 15:03:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoArchivo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_tipo_archivo_sel';
		$this->transaccion='PM_TIPAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_archivo','int4');
		$this->captura('nombre_id','varchar');
		$this->captura('multiple','varchar');
		$this->captura('codigo','varchar');
		$this->captura('tipo_archivo','varchar');
		$this->captura('tabla','varchar');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('extensiones_permitidas','varchar');
		$this->captura('ruta_guardar','varchar');
		$this->captura('tamano','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_ime';
		$this->transaccion='PM_TIPAR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre_id','nombre_id','varchar');
		$this->setParametro('multiple','multiple','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('tipo_archivo','tipo_archivo','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('extensiones_permitidas','extensiones_permitidas','varchar');
		$this->setParametro('ruta_guardar','ruta_guardar','varchar');
		$this->setParametro('tamano','tamano','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_ime';
		$this->transaccion='PM_TIPAR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');
		$this->setParametro('nombre_id','nombre_id','varchar');
		$this->setParametro('multiple','multiple','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('tipo_archivo','tipo_archivo','varchar');
		$this->setParametro('tabla','tabla','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('extensiones_permitidas','extensiones_permitidas','varchar');
		$this->setParametro('ruta_guardar','ruta_guardar','varchar');
        $this->setParametro('tamano','tamano','numeric');


		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_tipo_archivo_ime';
		$this->transaccion='PM_TIPAR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_archivo','id_tipo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>