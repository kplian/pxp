<?php
/**
*@package pXP
*@file gen-MODProveedorCtaBancaria.php
*@author  (gsarmiento)
*@date 30-10-2015 20:07:41
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProveedorCtaBancaria extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProveedorCtaBancaria(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_proveedor_cta_bancaria_sel';
		$this->transaccion='PM_PCTABAN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proveedor_cta_bancaria','int4');
		$this->captura('id_banco_beneficiario','int4');
		$this->captura('banco_beneficiario','varchar');
		$this->captura('fw_aba_cta','varchar');
		$this->captura('swift_big','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('banco_intermediario','varchar');
		$this->captura('nro_cuenta','varchar');
		$this->captura('id_proveedor','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarProveedorCtaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_proveedor_cta_bancaria_ime';
		$this->transaccion='PM_PCTABAN_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_banco_beneficiario','id_banco_beneficiario','int4');
		$this->setParametro('fw_aba_cta','fw_aba_cta','varchar');
		$this->setParametro('swift_big','swift_big','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('banco_intermediario','banco_intermediario','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('id_proveedor','id_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProveedorCtaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_proveedor_cta_bancaria_ime';
		$this->transaccion='PM_PCTABAN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor_cta_bancaria','id_proveedor_cta_bancaria','int4');
		$this->setParametro('id_banco_beneficiario','id_banco_beneficiario','int4');
		$this->setParametro('fw_aba_cta','fw_aba_cta','varchar');
		$this->setParametro('swift_big','swift_big','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('banco_intermediario','banco_intermediario','varchar');
		$this->setParametro('nro_cuenta','nro_cuenta','varchar');
		$this->setParametro('id_proveedor','id_proveedor','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProveedorCtaBancaria(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_proveedor_cta_bancaria_ime';
		$this->transaccion='PM_PCTABAN_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proveedor_cta_bancaria','id_proveedor_cta_bancaria','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>