<?php
/**
*@package pXP
*@file MODProgramaProyectoActtividad.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 16:04:45
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProgramaProyectoActtividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProgramaProyectoActtividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_programa_proyecto_acttividad_sel';
		$this->transaccion='PM_PPA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_prog_pory_acti','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_proyecto','int4');
		$this->captura('id_actividad','int4');
		$this->captura('id_programa','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_programa','text');
		$this->captura('desc_proyecto','text');
		$this->captura('desc_actividad','text');
		$this->captura('codigo_ppa','text');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarProgramaProyectoActtividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_proyecto_acttividad_ime';
		$this->transaccion='PM_PPA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_proyecto','id_proyecto','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_programa','id_programa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProgramaProyectoActtividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_proyecto_acttividad_ime';
		$this->transaccion='PM_PPA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_prog_pory_acti','id_prog_pory_acti','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_proyecto','id_proyecto','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_programa','id_programa','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProgramaProyectoActtividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_programa_proyecto_acttividad_ime';
		$this->transaccion='PM_PPA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_prog_pory_acti','id_prog_pory_acti','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>