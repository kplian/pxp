<?php
/**
*@package pXP
*@file gen-MODPeriodo.php
*@author  (admin)
*@date 20-02-2013 04:11:23
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPeriodo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
		
		$this->cone = new conexion();
		$this->link = $this->cone->conectarpdo(); //conexion a pxp(postgres)
	}
			
	function listarPeriodo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_periodo_sel';
		$this->transaccion='PM_PER_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_periodo','int4');
		$this->captura('id_gestion','int4');
		$this->captura('fecha_ini','date');
		$this->captura('periodo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('literal','varchar');
		$this->captura('codigo_siga','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_periodo_ime';
		$this->transaccion='PM_PER_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('periodo','periodo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('codigo_siga','codigo_siga','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_periodo_ime';
		$this->transaccion='PM_PER_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('periodo','periodo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('codigo_siga','codigo_siga','varchar');
		
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_periodo_ime';
		$this->transaccion='PM_PER_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function literalPeriodo(){
		
		$id_periodo = $this->objParam->getParametro('id_periodo');
		$res = $this->link->prepare("select param.f_literal_periodo($id_periodo)");
		$res->execute();
		$result = $res->fetchAll(PDO::FETCH_ASSOC);
		
		$this -> respuesta = new Mensaje();
		$this -> respuesta -> setMensaje('EXITO', $this -> nombre_archivo, 'La consulta se ejecuto con exito de insercion de nota', 'La consulta se ejecuto con exito', 'base', 'no tiene', 'no tiene', 'SEL', '$this->consulta', 'no tiene');
		$this -> respuesta -> setTotal(1);
		$this -> respuesta -> setDatos($result);
		return $this -> respuesta;
			

	}
	
	function getPeriodoById(){
		
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_periodo_ime';
		$this->transaccion='PM_GETPER_GET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
			

	}



			
}
?>