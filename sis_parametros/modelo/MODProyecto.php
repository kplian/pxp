<?php
/**
*@package pXP
*@file MODProyecto.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 17:04:17
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProyecto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_proyecto_sel';
		$this->transaccion='PM_PROY_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proyecto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('hidro','varchar');
		$this->captura('id_proyecto_cat_prog','int4');
		$this->captura('codigo_proyecto','varchar');
		$this->captura('descripcion_proyecto','text');
		$this->captura('nombre_proyecto','varchar');
		$this->captura('nombre_corto','varchar');
		$this->captura('id_proyecto_actif','int4');
		$this->captura('codigo_sisin','int8');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proyecto_ime';
		$this->transaccion='PM_PROY_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('hidro','hidro','varchar');
		$this->setParametro('id_proyecto_cat_prog','id_proyecto_cat_prog','int4');
		$this->setParametro('codigo_proyecto','codigo_proyecto','varchar');
		$this->setParametro('descripcion_proyecto','descripcion_proyecto','text');
		$this->setParametro('nombre_proyecto','nombre_proyecto','varchar');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
		$this->setParametro('id_proyecto_actif','id_proyecto_actif','int4');
		$this->setParametro('codigo_sisin','codigo_sisin','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proyecto_ime';
		$this->transaccion='PM_PROY_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proyecto','id_proyecto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('hidro','hidro','varchar');
		$this->setParametro('id_proyecto_cat_prog','id_proyecto_cat_prog','int4');
		$this->setParametro('codigo_proyecto','codigo_proyecto','varchar');
		$this->setParametro('descripcion_proyecto','descripcion_proyecto','text');
		$this->setParametro('nombre_proyecto','nombre_proyecto','varchar');
		$this->setParametro('nombre_corto','nombre_corto','varchar');
		$this->setParametro('id_proyecto_actif','id_proyecto_actif','int4');
		$this->setParametro('codigo_sisin','codigo_sisin','int8');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_proyecto_ime';
		$this->transaccion='PM_PROY_ELI';
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