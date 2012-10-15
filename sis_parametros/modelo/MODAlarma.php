<?php
/**
*@package pXP
*@file gen-MODAlarma.php
*@author  (fprudencio)
*@date 18-11-2011 11:59:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAlarma extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
	
	
	function GeneraAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_dispara_alarma_ime';
		$this->transaccion='PM_GENALA_INS';
		//definicion de variables
		$this->tipo_conexion='seguridad';
		
		$this->tipo_procedimiento='IME';
		$this->count=false;
				
		//$this->count=false;	
		$this->arreglo=array("id_usuario" =>1,
							 "tipo"=>'TODOS');
		
		//Define los parametros para ejecucion de la funcion
		$this->setParametro('id_usuario','id_usuario','integer');
		$this->setParametro('tipo','tipo','varchar');
		
		
		//Se definen los datos para las variables de sesion
		
				
		$this->armarConsulta();
		
		$this->ejecutarConsulta();
		
		 
		return $this->respuesta;
	}
			
	function listarAlarma(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
				
		//Definicion de la lista del resultado del query
		$this->captura('id_alarma','int4');
		$this->captura('acceso_directo','varchar');
		$this->captura('id_funcionario','int4');
		$this->captura('fecha','date');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','date');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','date');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre_completo1','text');
		$this->captura('clase','varchar');
		$this->captura('titulo','varchar');
		$this->captura('parametros','varchar');
		$this->captura('obs','varchar');
		$this->captura('tipo','varchar');
		$this->captura('dias','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarAlarmaCorrespondeciaPendiente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARMCOR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		//Definicion de la lista del resultado del query
		$this->captura('id_alarma','int4');
		$this->captura('email_empresa','varchar');
		$this->captura('fecha','date');
		$this->captura('descripcion','varchar');
		$this->captura('clase','varchar');
		$this->captura('titulo','varchar');
		$this->captura('obs','varchar');
		$this->captura('tipo','varchar');
		$this->captura('dias','integer');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function alarmaPendiente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_alarma_sel';
		$this->transaccion='PM_ALARM_PEND';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(FALSE);
				
		//Definicion de la lista del resultado del query
		$this->captura('total','bigint');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}		
	function insertarAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_ALARM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('acceso_directo','acceso_directo','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_ALARM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_alarma','id_alarma','int4');
		$this->setParametro('acceso_directo','acceso_directo','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function modificarEnvioCorreo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_DESCCOR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_alarma','id_alarma','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAlarma(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_alarma_ime';
		$this->transaccion='PM_ALARM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_alarma','id_alarma','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>