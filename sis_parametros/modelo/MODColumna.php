<?php
/**
*@package pXP
*@file gen-MODColumna.php
*@author  (egutierrez)
*@date 07-08-2019 15:43:48
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
ISSUE       FECHA           AUTHOR          DESCRIPCION
#48         14/08/2019      EGS             CREACION
 */

class MODColumna extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarColumna(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_columna_sel';
		$this->transaccion='PM_COL_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_columna','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_columna','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
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
			
	function insertarColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_ime';
		$this->transaccion='PM_COL_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_columna','nombre_columna','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_ime';
		$this->transaccion='PM_COL_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna','id_columna','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_columna','nombre_columna','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarColumna(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_columna_ime';
		$this->transaccion='PM_COL_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_columna','id_columna','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>