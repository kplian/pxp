<?php
/**
*@package pXP
*@file gen-MODPersonaEquipo.php
*@author  (admin)
*@date 14-02-2017 21:43:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPersonaEquipo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPersonaEquipo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='campe.ft_persona_equipo_sel';
		$this->transaccion='CAMPE_PEQUI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_persona_equipo','int4');
		$this->captura('id_equipo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('numero','varchar');
		$this->captura('id_persona','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_person','text');
		$this->captura('cargo','varchar');

/*
		$this->captura('id_persona','integer');
		$this->captura('ap_materno','varchar');
		$this->captura('ap_paterno','varchar');
		$this->captura('nombre','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('nombre_completo2','text');
		$this->captura('ci','varchar');
		$this->captura('correo','varchar');
		$this->captura('celular1','varchar');
		$this->captura('num_documento','integer');
		$this->captura('telefono1','varchar');
		$this->captura('telefono2','varchar');
		$this->captura('celular2','varchar');
		$this->captura('extension','varchar');
		$this->captura('tipo_documento','varchar');
		$this->captura('expedicion','varchar');*/


		$this->setParametro('id_partido_detalle','id_partido_detalle','int4');


		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPersonaEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='campe.ft_persona_equipo_ime';
		$this->transaccion='CAMPE_PEQUI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_equipo','id_equipo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('numero','numero','varchar');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('cargo','cargo','varchar');


		$this->setParametro('ap_materno','ap_materno','varchar');
		$this->setParametro('ap_paterno','ap_paterno','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('ci','ci','varchar');
		$this->setParametro('correo','correo','varchar');
		$this->setParametro('celular1','celular1','varchar');
		$this->setParametro('telefono1','telefono1','varchar');
		$this->setParametro('telefono2','telefono2','varchar');
		$this->setParametro('celular2','celular2','varchar');

		$this->setParametro('tipo_documento','tipo_documento','varchar');
		$this->setParametro('expedicion','expedicion','varchar');


		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPersonaEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='campe.ft_persona_equipo_ime';
		$this->transaccion='CAMPE_PEQUI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_persona_equipo','id_persona_equipo','int4');
		$this->setParametro('id_equipo','id_equipo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('numero','numero','varchar');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('cargo','cargo','varchar');


		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPersonaEquipo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='campe.ft_persona_equipo_ime';
		$this->transaccion='CAMPE_PEQUI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_persona_equipo','id_persona_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}



	function goleadores(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='campe.ft_persona_equipo_sel';
		$this->transaccion='CAMPE_PEQUI_GOLE';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->count = false;

		//Definicion de la lista del resultado del query
		$this->captura('desc_person','text');
		$this->captura('desc_equipo','varchar');
		$this->captura('conteo','int4');




		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

			
}
?>