<?php
/**
*@package pXP
*@file gen-MODProyecto.php
*@author  (w)
*@date 17-10-2011 06:35:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProyecto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_proyecto_sel';
		$this->transaccion='SG_PROY_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('estado_reg','estado_reg','varchar');	
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proyecto','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
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
		$this->procedimiento='segu.ft_proyecto_ime';
		$this->transaccion='SG_PROY_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_proyecto_ime';
		$this->transaccion='SG_PROY_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proyecto','id_proyecto','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_proyecto_ime';
		$this->transaccion='SG_PROY_ELI';
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