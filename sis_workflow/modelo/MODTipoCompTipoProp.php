<?php
/**
*@package pXP
*@file gen-MODTipoCompTipoProp.php
*@author  (admin)
*@date 15-05-2014 20:53:23
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoCompTipoProp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoCompTipoProp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_comp_tipo_prop_sel';
		$this->transaccion='WF_TCOTPR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_comp_tipo_prop','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('obligatorio','varchar');
		$this->captura('id_tipo_propiedad','int4');
		$this->captura('id_tipo_componente','int4');
		$this->captura('tipo_dato','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_propiedad','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoCompTipoProp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_comp_tipo_prop_ime';
		$this->transaccion='WF_TCOTPR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obligatorio','obligatorio','varchar');
		$this->setParametro('id_tipo_propiedad','id_tipo_propiedad','int4');
		$this->setParametro('id_tipo_componente','id_tipo_componente','int4');
		$this->setParametro('tipo_dato','tipo_dato','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoCompTipoProp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_comp_tipo_prop_ime';
		$this->transaccion='WF_TCOTPR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_comp_tipo_prop','id_tipo_comp_tipo_prop','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('obligatorio','obligatorio','varchar');
		$this->setParametro('id_tipo_propiedad','id_tipo_propiedad','int4');
		$this->setParametro('id_tipo_componente','id_tipo_componente','int4');
		$this->setParametro('tipo_dato','tipo_dato','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoCompTipoProp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_comp_tipo_prop_ime';
		$this->transaccion='WF_TCOTPR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_comp_tipo_prop','id_tipo_comp_tipo_prop','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>