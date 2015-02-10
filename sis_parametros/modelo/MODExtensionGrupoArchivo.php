<?php
/**
*@package pXP
*@file gen-MODExtensionGrupoArchivo.php
*@author  (admin)
*@date 23-12-2013 20:33:46
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODExtensionGrupoArchivo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarExtensionGrupoArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_extension_grupo_archivo_sel';
		$this->transaccion='PM_EXT_G_AR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_extension_grupo_archivo','int4');
		$this->captura('id_extension','int4');
		$this->captura('id_grupo_archivo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_extension','varchar');
		$this->captura('desc_grupo_archivo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarExtensionGrupoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_grupo_archivo_ime';
		$this->transaccion='PM_EXT_G_AR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_extension','id_extension','int4');
		$this->setParametro('id_grupo_archivo','id_grupo_archivo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarExtensionGrupoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_grupo_archivo_ime';
		$this->transaccion='PM_EXT_G_AR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_extension_grupo_archivo','id_extension_grupo_archivo','int4');
		$this->setParametro('id_extension','id_extension','int4');
		$this->setParametro('id_grupo_archivo','id_grupo_archivo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarExtensionGrupoArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_extension_grupo_archivo_ime';
		$this->transaccion='PM_EXT_G_AR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_extension_grupo_archivo','id_extension_grupo_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>