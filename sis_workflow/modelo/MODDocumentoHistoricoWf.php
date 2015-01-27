<?php
/**
*@package pXP
*@file gen-MODDocumentoHistoricoWf.php
*@author  (admin)
*@date 04-12-2014 20:11:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDocumentoHistoricoWf extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDocumentoHistoricoWf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_documento_historico_wf_sel';
		$this->transaccion='WF_DHW_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_documento_historico_wf','int4');
		$this->captura('id_documento','int4');
		$this->captura('url','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('url_old','varchar');
		$this->captura('version','int4');
		$this->captura('vigente','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('extension','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
			

			
}
?>