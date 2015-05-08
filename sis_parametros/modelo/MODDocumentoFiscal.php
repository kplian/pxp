<?php
/**
*@package pXP
*@file gen-MODDocumentoFiscal.php
*@author  (admin)
*@date 03-04-2013 15:48:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDocumentoFiscal extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDocumentoFiscal(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_documento_fiscal_sel';
		$this->transaccion='PM_DOCFIS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_documento_fiscal','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nro_documento','int4');
		$this->captura('razon_social','varchar');
		$this->captura('nro_autorizacion','varchar');
		$this->captura('estado','varchar');
		$this->captura('nit','varchar');
		$this->captura('codigo_control','varchar');
		$this->captura('formulario','varchar');
		$this->captura('tipo_retencion','varchar');
		$this->captura('id_plantilla','int4');
		$this->captura('fecha_doc','date');
		$this->captura('dui','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_plantilla','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDocumentoFiscal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_fiscal_ime';
		$this->transaccion='PM_DOCFIS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_documento','nro_documento','int4');
		$this->setParametro('razon_social','razon_social','varchar');
		$this->setParametro('nro_autorizacion','nro_autorizacion','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('codigo_control','codigo_control','varchar');
		$this->setParametro('formulario','formulario','varchar');
		$this->setParametro('tipo_retencion','tipo_retencion','varchar');
		$this->setParametro('id_plantilla','id_plantilla','int4');
		$this->setParametro('fecha_doc','fecha_doc','date');
		$this->setParametro('dui','dui','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDocumentoFiscal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_fiscal_ime';
		$this->transaccion='PM_DOCFIS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_fiscal','id_documento_fiscal','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nro_documento','nro_documento','int4');
		$this->setParametro('razon_social','razon_social','varchar');
		$this->setParametro('nro_autorizacion','nro_autorizacion','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('nit','nit','varchar');
		$this->setParametro('codigo_control','codigo_control','varchar');
		$this->setParametro('formulario','formulario','varchar');
		$this->setParametro('tipo_retencion','tipo_retencion','varchar');
		$this->setParametro('id_plantilla','id_plantilla','int4');
		$this->setParametro('fecha_doc','fecha_doc','date');
		$this->setParametro('dui','dui','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDocumentoFiscal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_fiscal_ime';
		$this->transaccion='PM_DOCFIS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_fiscal','id_documento_fiscal','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function obtenerRazonSocialxNIT(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_fiscal_ime';
		$this->transaccion='PM_OBTNIT_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nit','nit','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>