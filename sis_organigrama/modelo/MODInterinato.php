<?php
/**
*@package pXP
*@file gen-MODInterinato.php
*@author  (admin)
*@date 20-05-2014 20:01:24
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODInterinato extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarInterinato(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_interinato_sel';
		$this->transaccion='OR_INT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_interinato','int4');
		$this->captura('id_cargo_titular','int4');
		$this->captura('id_cargo_suplente','int4');
		$this->captura('fecha_ini','date');
		$this->captura('descripcion','text');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_fin','date');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_titular','varchar');
		$this->captura('nombre_suplente','varchar');
        $this->captura('desc_funcionario_titular','text');
        $this->captura('desc_funcionario_suplente','text');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarInterinato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_interinato_ime';
		$this->transaccion='OR_INT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_cargo_titular','id_cargo_titular','int4');
		$this->setParametro('id_cargo_suplente','id_cargo_suplente','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('id_usuario_ai','id_usuario_ai','int4');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarInterinato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_interinato_ime';
		$this->transaccion='OR_INT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_interinato','id_interinato','int4');
		$this->setParametro('id_cargo_titular','id_cargo_titular','int4');
		$this->setParametro('id_cargo_suplente','id_cargo_suplente','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('id_usuario_ai','id_usuario_ai','int4');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarInterinato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_interinato_ime';
		$this->transaccion='OR_INT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_interinato','id_interinato','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function aplicarInterinato(){
        //aplicar el interinato seleccionado al usuario actual
        $this->procedimiento='orga.ft_interinato_ime';
        $this->transaccion='OR_APLINT_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_interinato','id_interinato','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	
			
}
?>