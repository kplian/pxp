<?php
/**
*@package pXP
*@file gen-MODPlantillaCorreo.php
*@author  (jrivera)
*@date 20-08-2014 21:52:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPlantillaCorreo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_plantilla_correo_sel';
		$this->transaccion='WF_PCORREO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_plantilla_correo','int4');
		$this->captura('id_tipo_estado','int4');
		$this->captura('regla','text');
		$this->captura('plantilla','text');
		$this->captura('correos','text');
		$this->captura('codigo_plantilla','varchar');
		$this->captura('documentos','text');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('asunto','varchar');
				
		$this->captura('requiere_acuse','varchar');
		$this->captura('mensaje_acuse','varchar');
		$this->captura('url_acuse','varchar');
		$this->captura('mensaje_link_acuse','varchar');
		$this->captura('mandar_automaticamente','varchar');
		
		$this->captura('funcion_acuse_recibo','varchar');
		$this->captura('funcion_creacion_correo','varchar');

		$this->captura('cc','text');
		$this->captura('bcc','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_plantilla_correo_ime';
		$this->transaccion='WF_PCORREO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('regla','regla','text');
		$this->setParametro('plantilla','plantilla','codigo_html');
		$this->setParametro('correos','correos','text');
		$this->setParametro('codigo_plantilla','codigo_plantilla','varchar');
		$this->setParametro('documentos','documentos','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('asunto','asunto','varchar');
		$this->setParametro('requiere_acuse','requiere_acuse','varchar');
		$this->setParametro('mensaje_acuse','mensaje_acuse','varchar');
		$this->setParametro('url_acuse','url_acuse','codigo_html');	
		$this->setParametro('mensaje_link_acuse','mensaje_link_acuse','varchar');
		$this->setParametro('mandar_automaticamente','mandar_automaticamente','varchar');
		$this->setParametro('funcion_acuse_recibo','funcion_acuse_recibo','varchar');
		$this->setParametro('funcion_creacion_correo','funcion_creacion_correo','varchar');
		$this->setParametro('cc','cc','text');
		$this->setParametro('bcc','bcc','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_plantilla_correo_ime';
		$this->transaccion='WF_PCORREO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('regla','regla','text');
		$this->setParametro('plantilla','plantilla','codigo_html');
		$this->setParametro('correos','correos','text');
		$this->setParametro('codigo_plantilla','codigo_plantilla','varchar');
		$this->setParametro('documentos','documentos','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('asunto','asunto','varchar');
		$this->setParametro('requiere_acuse','requiere_acuse','varchar');
		$this->setParametro('mensaje_acuse','mensaje_acuse','varchar');
		$this->setParametro('url_acuse','url_acuse','varchar');	
		$this->setParametro('mensaje_link_acuse','mensaje_link_acuse','varchar');
		$this->setParametro('mandar_automaticamente','mandar_automaticamente','varchar');
		$this->setParametro('funcion_acuse_recibo','funcion_acuse_recibo','varchar');
		$this->setParametro('funcion_creacion_correo','funcion_creacion_correo','varchar');
		$this->setParametro('cc','cc','text');
		$this->setParametro('bcc','bcc','text');


		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlantillaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_plantilla_correo_ime';
		$this->transaccion='WF_PCORREO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_correo','id_plantilla_correo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>