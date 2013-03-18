<?php
/**
*@package pXP
*@file gen-MODLaboresTipoProceso.php
*@author  (admin)
*@date 15-03-2013 16:08:41
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLaboresTipoProceso extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLaboresTipoProceso(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_labores_tipo_proceso_sel';
		$this->transaccion='WF_LABTPROC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_labores_tipo_proceso','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
        $this->captura('desc_tipo_proceso','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLaboresTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_labores_tipo_proceso_ime';
		$this->transaccion='WF_LABTPROC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLaboresTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_labores_tipo_proceso_ime';
		$this->transaccion='WF_LABTPROC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_labores_tipo_proceso','id_labores_tipo_proceso','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLaboresTipoProceso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_labores_tipo_proceso_ime';
		$this->transaccion='WF_LABTPROC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_labores_tipo_proceso','id_labores_tipo_proceso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>