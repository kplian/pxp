<?php
/**
*@package pXP
*@file gen-MODUniConsComp.php
*@author  (rac)
*@date 09-08-2012 01:38:28
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsComp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsComp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.f_uni_cons_comp_sel';
		$this->transaccion='GEM_UCC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_comp_equipo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('opcional','varchar');
		$this->captura('id_uni_cons_padre','int4');
		$this->captura('cantidad','int4');
		$this->captura('id_uni_const_hijo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarUniConsComp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_comp_ime';
		$this->transaccion='GEM_UCC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('opcional','opcional','varchar');
		$this->setParametro('id_uni_cons_padre','id_uni_cons_padre','int4');
		$this->setParametro('cantidad','cantidad','int4');
		$this->setParametro('id_uni_const_hijo','id_uni_const_hijo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsComp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_comp_ime';
		$this->transaccion='GEM_UCC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_comp_equipo','id_comp_equipo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('opcional','opcional','varchar');
		$this->setParametro('id_uni_cons_padre','id_uni_cons_padre','int4');
		$this->setParametro('cantidad','cantidad','int4');
		$this->setParametro('id_uni_const_hijo','id_uni_const_hijo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsComp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.f_uni_cons_comp_ime';
		$this->transaccion='GEM_UCC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_comp_equipo','id_comp_equipo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>