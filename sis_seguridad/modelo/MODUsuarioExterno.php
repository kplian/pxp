<?php
/**
*@package pXP
*@file gen-MODUsuarioExterno.php
*@author  (miguel.mamani)
*@date 27-09-2017 13:33:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUsuarioExterno extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUsuarioExterno(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='segu.ft_usuario_externo_sel';
		$this->transaccion='SG_UEO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_usuario_externo','int4');
		$this->captura('id_usuario','int4');
		$this->captura('usuario_externo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('sistema_externo','varchar');
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
			
	function insertarUsuarioExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_usuario_externo_ime';
		$this->transaccion='SG_UEO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('usuario_externo','usuario_externo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('sistema_externo','sistema_externo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUsuarioExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_usuario_externo_ime';
		$this->transaccion='SG_UEO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario_externo','id_usuario_externo','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('usuario_externo','usuario_externo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('sistema_externo','sistema_externo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUsuarioExterno(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='segu.ft_usuario_externo_ime';
		$this->transaccion='SG_UEO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario_externo','id_usuario_externo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    function GenerarUsuarioAmadeus(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='segu.ft_usuario_externo_ime';
        $this->transaccion='SG_UEO_GEN';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_usuario','id_usuario','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>