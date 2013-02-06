<?php
/**
*@package pXP
*@file MODFinanciador.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 22:30:22
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFinanciador extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFinanciador(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.f_financiador_sel';
		$this->transaccion='PM_fin_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_financiador','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_financiador','varchar');
		$this->captura('id_financiador_actif','int4');
		$this->captura('descripcion_financiador','text');
		$this->captura('codigo_financiador','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarFinanciador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_financiador_ime';
		$this->transaccion='PM_fin_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_financiador','nombre_financiador','varchar');
		$this->setParametro('id_financiador_actif','id_financiador_actif','int4');
		$this->setParametro('descripcion_financiador','descripcion_financiador','text');
		$this->setParametro('codigo_financiador','codigo_financiador','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFinanciador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_financiador_ime';
		$this->transaccion='PM_fin_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_financiador','id_financiador','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_financiador','nombre_financiador','varchar');
		$this->setParametro('id_financiador_actif','id_financiador_actif','int4');
		$this->setParametro('descripcion_financiador','descripcion_financiador','text');
		$this->setParametro('codigo_financiador','codigo_financiador','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFinanciador(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.f_financiador_ime';
		$this->transaccion='PM_fin_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_financiador','id_financiador','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>