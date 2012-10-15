<?php
/**
*@package pXP
*@file gen-MODInstitucion.php
*@author  (gvelasquez)
*@date 21-09-2011 10:50:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODInstitucion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarInstitucion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_institucion_sel';
		$this->transaccion='PM_INSTIT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		
		//adiciona este parametro en caso de requerir instituciones tipo banco
		$this->setParametro('es_banco','es_banco','varchar');
		//Definicion de la lista del resultado del query
		$this->captura('id_institucion','int4');
		$this->captura('fax','varchar');
		$this->captura('estado_reg','varchar');
		
		$this->captura('casilla','varchar');
		$this->captura('direccion','varchar');
		$this->captura('doc_id','varchar');
		$this->captura('telefono2','varchar');
		$this->captura('id_persona','int4');
		$this->captura('email2','varchar');
		$this->captura('celular1','varchar');
		$this->captura('email1','varchar');
		
		$this->captura('nombre','varchar');
		$this->captura('observaciones','text');
		$this->captura('telefono1','varchar');
		$this->captura('celular2','varchar');
		$this->captura('codigo_banco','varchar');
		$this->captura('pag_web','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo','varchar');
		$this->captura('es_banco','varchar');
		$this->captura('desc_persona','text');
		$this->captura('cargo_representante','varchar');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarInstitucion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_ime';
		$this->transaccion='PM_INSTIT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fax','fax','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		
		$this->setParametro('casilla','casilla','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('doc_id','doc_id','varchar');
		$this->setParametro('telefono2','telefono2','varchar');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('email2','email2','varchar');
		$this->setParametro('celular1','celular1','varchar');
		$this->setParametro('email1','email1','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('observaciones','observaciones','text');
		$this->setParametro('telefono1','telefono1','varchar');
		$this->setParametro('celular2','celular2','varchar');
		$this->setParametro('codigo_banco','codigo_banco','varchar');
		$this->setParametro('pag_web','pag_web','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('es_banco','es_banco','varchar');
		$this->setParametro('cargo_representante','cargo_representante','varchar');
		                        

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarInstitucion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_ime';
		$this->transaccion='PM_INSTIT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('fax','fax','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		
		$this->setParametro('casilla','casilla','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('doc_id','doc_id','varchar');
		$this->setParametro('telefono2','telefono2','varchar');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('email2','email2','varchar');
		$this->setParametro('celular1','celular1','varchar');
		$this->setParametro('email1','email1','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('observaciones','observaciones','text');
		$this->setParametro('telefono1','telefono1','varchar');
		$this->setParametro('celular2','celular2','varchar');
		$this->setParametro('codigo_banco','codigo_banco','varchar');
		$this->setParametro('pag_web','pag_web','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('es_banco','es_banco','varchar');
		$this->setParametro('cargo_representante','cargo_representante','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarInstitucion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_institucion_ime';
		$this->transaccion='PM_INSTIT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_institucion','id_institucion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>