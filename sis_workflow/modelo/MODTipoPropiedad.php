<?php
/**
*@package pXP
*@file gen-MODTipoPropiedad.php
*@author  (admin)
*@date 15-05-2014 20:38:59
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoPropiedad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoPropiedad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_propiedad_sel';
		$this->transaccion='WF_TIPPRO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_propiedad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('tipo_dato','varchar');
		$this->captura('codigo','varchar');
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
			
	function insertarTipoPropiedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_propiedad_ime';
		$this->transaccion='WF_TIPPRO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoPropiedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_propiedad_ime';
		$this->transaccion='WF_TIPPRO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_propiedad','id_tipo_propiedad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('tipo_dato','tipo_dato','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoPropiedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_propiedad_ime';
		$this->transaccion='WF_TIPPRO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_propiedad','id_tipo_propiedad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>