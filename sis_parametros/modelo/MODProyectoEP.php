<?php
/**
*@package pXP
*@file gen-MODProyecto.php
*@author  (rac)
*@date 26-10-2011 11:40:13
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/
class MODProyectoEP extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_tpm_proyecto_sel';
		$this->transaccion='PM_PRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		//para filtrar proyecto tipo hidro = si
		$this->setParametro('hidro','hidro','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proyecto','int4');
		$this->captura('id_usuario','int4');
		$this->captura('descripcion_proyecto','text');
		$this->captura('codigo_sisin','int8');
		$this->captura('hora_ultima_modificacion','time');
		$this->captura('codigo_proyecto','varchar');
		$this->captura('hora_registro','time');
		$this->captura('nombre_corto','varchar');
		$this->captura('fecha_ultima_modificacion','date');
		$this->captura('fecha_registro','date');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('id_proyecto_actif','int4');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tpm_proyecto_ime';
		$this->transaccion='PM_PRO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('descripcion_proyecto','descripcion_proyecto','text');
		$this->setParametro('codigo_sisin','codigo_sisin','int8');
		$this->setParametro('hora_ultima_modificacion','hora_ultima_modificacion','time');
		$this->setParametro('codigo_proyecto','codigo_proyecto','varchar');
		$this->setParametro('hora_registro','hora_registro','time');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
		$this->setParametro('fecha_ultima_modificacion','fecha_ultima_modificacion','date');
		$this->setParametro('fecha_registro','fecha_registro','date');
		$this->setParametro('nombre_proyecto','nombre_proyecto','varchar');
		$this->setParametro('id_proyecto_actif','id_proyecto_actif','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tpm_proyecto_ime';
		$this->transaccion='PM_PRO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proyecto','id_proyecto','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('descripcion_proyecto','descripcion_proyecto','text');
		$this->setParametro('codigo_sisin','codigo_sisin','int8');
		$this->setParametro('hora_ultima_modificacion','hora_ultima_modificacion','time');
		$this->setParametro('codigo_proyecto','codigo_proyecto','varchar');
		$this->setParametro('hora_registro','hora_registro','time');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
		$this->setParametro('fecha_ultima_modificacion','fecha_ultima_modificacion','date');
		$this->setParametro('fecha_registro','fecha_registro','date');
		$this->setParametro('nombre_proyecto','nombre_proyecto','varchar');
		$this->setParametro('id_proyecto_actif','id_proyecto_actif','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_tpm_proyecto_ime';
		$this->transaccion='PM_PRO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proyecto','id_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
		
}
?>