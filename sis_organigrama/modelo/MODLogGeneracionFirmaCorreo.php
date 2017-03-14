<?php
/**
*@package pXP
*@file gen-MODLogGeneracionFirmaCorreo.php
*@author  (admin)
*@date 06-03-2017 21:21:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLogGeneracionFirmaCorreo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLogGeneracionFirmaCorreo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_log_generacion_firma_correo_sel';
		$this->transaccion='OR_LOGFIR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_log_generacion_firma_correo','int4');
		$this->captura('telefono_interno','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('telefono_personal','varchar');
		$this->captura('telefono_corporativo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('direccion','varchar');
		$this->captura('cargo','varchar');
		$this->captura('cargo_ingles','varchar');
		$this->captura('nombre','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarLogGeneracionFirmaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_log_generacion_firma_correo_ime';
		$this->transaccion='OR_LOGFIR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('telefono_interno','telefono_interno','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('telefono_personal','telefono_personal','varchar');
		$this->setParametro('telefono_corporativo','telefono_corporativo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('cargo','cargo','varchar');
		$this->setParametro('cargo_ingles','cargo_ingles','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLogGeneracionFirmaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_log_generacion_firma_correo_ime';
		$this->transaccion='OR_LOGFIR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_log_generacion_firma_correo','id_log_generacion_firma_correo','int4');
		$this->setParametro('telefono_interno','telefono_interno','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('telefono_personal','telefono_personal','varchar');
		$this->setParametro('telefono_corporativo','telefono_corporativo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('direccion','direccion','varchar');
		$this->setParametro('cargo','cargo','varchar');
		$this->setParametro('cargo_ingles','cargo_ingles','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLogGeneracionFirmaCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_log_generacion_firma_correo_ime';
		$this->transaccion='OR_LOGFIR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_log_generacion_firma_correo','id_log_generacion_firma_correo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>