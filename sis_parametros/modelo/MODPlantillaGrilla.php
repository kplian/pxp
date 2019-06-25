<?php
/**
*@package pXP
*@file gen-MODPlantillaGrilla.php
*@author  (egutierrez)
*@date 17-06-2019 21:25:26
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
	ISSUE		FECHA 			AUTHOR			DESCRIPCION
 *  #24			17/06/2019		EGS				Crecion
 
 */

class MODPlantillaGrilla extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPlantillaGrilla(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_plantilla_grilla_sel';
		$this->transaccion='PM_PLGRI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_plantilla_grilla','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('configuracion','varchar');
		$this->captura('nombre','varchar');
		$this->captura('url_interface','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_plantilla_grilla','text');
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPlantillaGrilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_grilla_ime';
		$this->transaccion='PM_PLGRI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('configuracion','configuracion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('url_interface','url_interface','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPlantillaGrilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_grilla_ime';
		$this->transaccion='PM_PLGRI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_grilla','id_plantilla_grilla','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('configuracion','configuracion','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('url_interface','url_interface','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPlantillaGrilla(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_plantilla_grilla_ime';
		$this->transaccion='PM_PLGRI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_plantilla_grilla','id_plantilla_grilla','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>