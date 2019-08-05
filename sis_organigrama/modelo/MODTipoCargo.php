<?php
/**
*@package pXP
*@file gen-MODTipoCargo.php
*@author  (rarteaga)
*@date 15-07-2019 19:39:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 *  HISTORIAL DE MODIFICACIONES:
    #ISSUE                FECHA                AUTOR                DESCRIPCION
    #46                05/08/2019              EGS                 e agrega campo id_contrato
*/

class MODTipoCargo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoCargo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_tipo_cargo_sel';
		$this->transaccion='OR_TCAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_cargo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_escala_salarial_min','int4');
		$this->captura('id_escala_salarial_max','int4');
		$this->captura('factor_disp','numeric');
		$this->captura('obs','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_escmim','text');
		$this->captura('desc_escmax','text');
		$this->captura('id_tipo_contrato','int4');//#46
        $this->captura('desc_tipo_contrato','varchar');//#46

		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_tipo_cargo_ime';
		$this->transaccion='OR_TCAR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_escala_salarial_min','id_escala_salarial_min','int4');
		$this->setParametro('id_escala_salarial_max','id_escala_salarial_max','int4');
		$this->setParametro('factor_disp','factor_disp','numeric');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');//#46

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_tipo_cargo_ime';
		$this->transaccion='OR_TCAR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cargo','id_tipo_cargo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_escala_salarial_min','id_escala_salarial_min','int4');
		$this->setParametro('id_escala_salarial_max','id_escala_salarial_max','int4');
		$this->setParametro('factor_disp','factor_disp','numeric');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');//#46

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_tipo_cargo_ime';
		$this->transaccion='OR_TCAR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_cargo','id_tipo_cargo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>