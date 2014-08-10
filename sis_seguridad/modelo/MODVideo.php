<?php
/**
*@package pXP
*@file gen-MODVideo.php
*@author  (admin)
*@date 23-04-2014 13:14:54
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODVideo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarVideo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_video_sel');
		$this->setTransaccion('SG_TUTO_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_video','int4');
		$this->captura('id_subsistema','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('url','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('titulo','varchar');
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
		return $this->getRespuesta();
	}
			
	function insertarVideo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_video_ime');
		$this->setTransaccion('SG_TUTO_INS');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('url','url','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('titulo','titulo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function modificarVideo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_video_ime');
		$this->setTransaccion('SG_TUTO_MOD');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_video','id_video','int4');
		$this->setParametro('id_subsistema','id_subsistema','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('url','url','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('titulo','titulo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function eliminarVideo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_video_ime');
		$this->setTransaccion('SG_TUTO_ELI');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_video','id_video','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
}
?>