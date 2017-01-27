<?php
/**
*@package pXP
*@file gen-MODCargo.php
*@author  (admin)
*@date 14-01-2014 19:16:06
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCargo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCargo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_cargo_sel';
		$this->transaccion='OR_CARGO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('id_uo','id_uo','integer');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_cargo','int4');
		$this->captura('id_uo','int4');
		$this->captura('id_tipo_contrato','int4');
		$this->captura('id_lugar','int4');
		$this->captura('id_temporal_cargo','int4');
		$this->captura('id_escala_salarial','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('fecha_ini','date');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('nombre_tipo_contrato','varchar');
		$this->captura('nombre_escala','varchar');
		$this->captura('nombre_oficina','varchar');
		$this->captura('acefalo','varchar');
		$this->captura('id_oficina','int4');
		$this->captura('identificador','int4');
		$this->captura('codigo_tipo_contrato','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}


    function listarCargoAcefalo(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='orga.ft_cargo_sel';
        $this->transaccion='OR_CARGOACE_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);


        $this->setParametro('fecha','fecha','date');


        //Definicion de la lista del resultado del query
        $this->captura('cargo','varchar');
        $this->captura('lugar','varchar');
        $this->captura('gerencia','varchar');
        $this->captura('cantidad','int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_ime';
		$this->transaccion='OR_CARGO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');
		$this->setParametro('id_oficina','id_oficina','int4');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_temporal_cargo','id_temporal_cargo','varchar');
		$this->setParametro('id_escala_salarial','id_escala_salarial','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_ime';
		$this->transaccion='OR_CARGO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo','id_cargo','int4');
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');
		$this->setParametro('id_oficina','id_oficina','int4');
		$this->setParametro('id_temporal_cargo','id_temporal_cargo','varchar');
		$this->setParametro('id_escala_salarial','id_escala_salarial','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCargo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_cargo_ime';
		$this->transaccion='OR_CARGO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo','id_cargo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>
