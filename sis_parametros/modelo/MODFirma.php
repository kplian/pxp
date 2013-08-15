<?php
/**
*@package pXP
*@file gen-MODFirma.php
*@author  (admin)
*@date 11-07-2013 15:32:07
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFirma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFirma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_firma_sel';
		$this->transaccion='PM_FIR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_firma','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('desc_firma','varchar');
		$this->captura('monto_min','numeric');
		$this->captura('prioridad','int4');
		$this->captura('monto_max','numeric');
		$this->captura('id_documento','int4');
		$this->captura('id_funcionario','int4');
		$this->captura('id_depto','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
        $this->captura('desc_funcionario1','text');
        $this->captura('desc_documento','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_firma_ime';
		$this->transaccion='PM_FIR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_firma','desc_firma','varchar');
		$this->setParametro('monto_min','monto_min','numeric');
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('monto_max','monto_max','numeric');
		$this->setParametro('id_documento','id_documento','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_depto','id_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_firma_ime';
		$this->transaccion='PM_FIR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_firma','id_firma','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('desc_firma','desc_firma','varchar');
		$this->setParametro('monto_min','monto_min','numeric');
		$this->setParametro('prioridad','prioridad','int4');
		$this->setParametro('monto_max','monto_max','numeric');
		$this->setParametro('id_documento','id_documento','int4');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('id_depto','id_depto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFirma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_firma_ime';
		$this->transaccion='PM_FIR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_firma','id_firma','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>