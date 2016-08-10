<?php
/**
*@package pXP
*@file gen-MODGestion.php
*@author  (admin)
*@date 05-02-2013 09:56:59
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODGestion extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarGestion(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_gestion_sel';
		$this->transaccion='PM_GES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_gestion','int4');
		$this->captura('id_moneda_base','int4');
		$this->captura('id_empresa','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('gestion','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_empresa','varchar');
		$this->captura('moneda','varchar');
		$this->captura('codigo_moneda','varchar');
		$this->captura('tipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarGestion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_gestion_ime';
		$this->transaccion='PM_GES_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_moneda_base','id_moneda_base','int4');
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('gestion','gestion','int4');
		
		$this->setParametro('tipo','tipo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarGestion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_gestion_ime';
		$this->transaccion='PM_GES_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_moneda_base','id_moneda_base','int4');
		$this->setParametro('id_empresa','id_empresa','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('gestion','gestion','int4');
		$this->setParametro('tipo','tipo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarGestion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_gestion_ime';
		$this->transaccion='PM_GES_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_gestion','id_gestion','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function obtenerGestionByFecha(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_gestion_ime';
        $this->transaccion='PM_GETGES_GET';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('fecha','fecha','date');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function obtenerGestionById(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_gestion_ime';
        $this->transaccion='PM_GETGESID_GET';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_gestion','id_gestion','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	//RCM 03/09/2013: Genera los periodos de los subsistema faltantes
	function sincronizarPeriodoSubsis(){
		//Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.f_gestion_ime';
        $this->transaccion='PM_PERSUB_SIN';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_gestion','id_gestion','integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
	}
			
}
?>