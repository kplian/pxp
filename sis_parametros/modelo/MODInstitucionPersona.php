<?php
/**
*@package pXP
*@file gen-MODInstitucionPersona.php
*@author  fprudencio
*@date 03-12-2017 10:50:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODInstitucionPersona extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarInstitucionPersona(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_institucion_persona_sel';
		$this->transaccion='PM_INSTIPER_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		
		//Definicion de la lista del resultado del query
		$this->captura('id_institucion_persona','int4');
		$this->captura('id_institucion','int4');
		$this->captura('nombre_institucion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_persona','int4');
		$this->captura('desc_persona','text');
		$this->captura('cargo_institucion','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarInstitucionPersona(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_persona_ime';
		$this->transaccion='PM_INSTIPER_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('cargo_institucion','cargo_institucion','varchar');
		                        

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarInstitucionPersona(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_persona_ime';
		$this->transaccion='PM_INSTIPER_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_institucion_persona','id_institucion_persona','int4');
		$this->setParametro('cargo_institucion','cargo_institucion','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarInstitucionPersona(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_persona_ime';
		$this->transaccion='PM_INSTIPER_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_institucion_persona','id_institucion_persona','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>