<?php
/**
*@package pXP
*@file gen-MODTipoContrato.php
*@author  (admin)
*@date 14-01-2014 19:23:02
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 ISSUE              FECHA:	        AUTOR:           DESCRIPCION:	
 #18                23/05/2019      EGS              se agrego el campo considerar_planilla 
 #15				19/06/2019		MZM				 Adicion de campo indefinido
 #49                16/08/2019      EGS              Se cambio los nombres de los procedimientos
 */

class MODTipoContrato extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoContrato(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='orga.ft_ttipo_contrato_sel';
		$this->transaccion='OR_TTIPCON_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_contrato','int4');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('considerar_planilla','varchar');//#18	
		$this->captura('indefinido','varchar');//#15		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoContrato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_ttipo_contrato_ime';
		$this->transaccion='OR_TTIPCON_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('considerar_planilla','considerar_planilla','varchar');//#18
		$this->setParametro('indefinido','indefinido','varchar');//#18
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoContrato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_ttipo_contrato_ime';
		$this->transaccion='OR_TTIPCON_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('considerar_planilla','considerar_planilla','varchar');//#18
		$this->setParametro('indefinido','indefinido','varchar');//#15

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoContrato(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='orga.ft_ttipo_contrato_ime';
		$this->transaccion='OR_TTIPCON_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_contrato','id_tipo_contrato','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>