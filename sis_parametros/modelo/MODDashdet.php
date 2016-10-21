<?php
/**
*@package pXP
*@file gen-MODDashdet.php
*@author  (admin)
*@date 10-09-2016 11:31:12
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDashdet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDashdet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_dashdet_sel';
		$this->transaccion='PM_DAD_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_dashdet','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('columna','int4');
		$this->captura('id_widget','int4');
		$this->captura('fila','int4');
		$this->captura('id_dashboard','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
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
	
	
	function listarDashdetalle(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_dashdet_sel';
		$this->transaccion='PM_DADET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		$this->setCount(false);
		
		$this->setParametro('id_dashboard','id_dashboard','int4');		
		//Definicion de la lista del resultado del query
		$this->captura('id_dashdet','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('columna','int4');
		$this->captura('id_widget','int4');
		$this->captura('fila','int4');
		$this->captura('id_dashboard','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('clase','varchar');
        $this->captura('nombre','varchar');
        $this->captura('ruta','varchar');
        $this->captura('tipo','varchar');
        $this->captura('obs','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	
			
	function insertarDashdet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_dashdet_ime';
		$this->transaccion='PM_DAD_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('columna','columna','int4');
		$this->setParametro('id_widget','id_widget','int4');
		$this->setParametro('fila','fila','int4');
		$this->setParametro('id_dashboard','id_dashboard','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDashdet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_dashdet_ime';
		$this->transaccion='PM_DAD_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dashdet','id_dashdet','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('columna','columna','int4');
		$this->setParametro('id_widget','id_widget','int4');
		$this->setParametro('fila','fila','int4');
		$this->setParametro('id_dashboard','id_dashboard','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDashdet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_dashdet_ime';
		$this->transaccion='PM_DAD_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dashdet','id_dashdet','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function guardarPosiciones(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_dashdet_ime';
		$this->transaccion='PM_SAVESTATUS_IME';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dashboard_activo','id_dashboard_activo','int4');
		$this->setParametro('json_procesos','json_procesos','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>