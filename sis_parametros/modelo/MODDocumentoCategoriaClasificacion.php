<?php
/**
*@package pXP
*@file gen-MODDocumentoCategoriaClasificacion.php
*@author  (gsarmiento)
*@date 06-10-2014 16:00:33
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDocumentoCategoriaClasificacion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDocumentoCategoriaClasificacion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_documento_categoria_clasificacion_sel';
		$this->transaccion='PM_DOCATCLA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_documento_categoria_clasificacion','int4');
		$this->captura('id_categoria','int4');
		$this->captura('nombre_categoria','varchar');
		$this->captura('id_clasificacion','int4');
		$this->captura('nombre_clasificacion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('documento','varchar');
		$this->captura('presentar_legal','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_ai','int4');
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
			
	function insertarDocumentoCategoriaClasificacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_categoria_clasificacion_ime';
		$this->transaccion='PM_DOCATCLA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_categoria','id_categoria','int4');
		$this->setParametro('id_clasificacion','id_clasificacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('documento','documento','varchar');
		$this->setParametro('presentar_legal','presentar_legal','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDocumentoCategoriaClasificacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_categoria_clasificacion_ime';
		$this->transaccion='PM_DOCATCLA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_categoria_clasificacion','id_documento_categoria_clasificacion','int4');
		$this->setParametro('id_categoria','id_categoria','int4');
		$this->setParametro('id_clasificacion','id_clasificacion','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('documento','documento','varchar');
		$this->setParametro('presentar_legal','presentar_legal','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDocumentoCategoriaClasificacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_documento_categoria_clasificacion_ime';
		$this->transaccion='PM_DOCATCLA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_categoria_clasificacion','id_documento_categoria_clasificacion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>