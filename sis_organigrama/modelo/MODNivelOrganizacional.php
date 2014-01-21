<?php
/**
*@package pXP
*@file gen-MODNivelOrganizacional.php
*@author  (admin)
*@date 13-01-2014 23:54:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODNivelOrganizacional extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarNivelOrganizacional(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_nivel_organizacional_sel';
		$this->transaccion='OR_NIVORG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_nivel_organizacional','int4');
		$this->captura('numero_nivel','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_nivel','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarNivelOrganizacional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_nivel_organizacional_ime';
		$this->transaccion='OR_NIVORG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('numero_nivel','numero_nivel','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_nivel','nombre_nivel','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarNivelOrganizacional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_nivel_organizacional_ime';
		$this->transaccion='OR_NIVORG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_nivel_organizacional','id_nivel_organizacional','int4');
		$this->setParametro('numero_nivel','numero_nivel','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_nivel','nombre_nivel','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarNivelOrganizacional(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_nivel_organizacional_ime';
		$this->transaccion='OR_NIVORG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_nivel_organizacional','id_nivel_organizacional','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>