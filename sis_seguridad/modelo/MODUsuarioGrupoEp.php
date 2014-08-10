<?php
/**
*@package pXP
*@file gen-MODUsuarioGrupoEp.php
*@author  (admin)
*@date 22-04-2013 15:53:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUsuarioGrupoEp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUsuarioGrupoEp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->setProcedimiento('segu.ft_usuario_grupo_ep_sel');
		$this->setTransaccion('SG_UEP_SEL');
		$this->setTipoProcedimiento('SEL');//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_usuario_grupo_ep','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario','int4');
		$this->captura('id_grupo','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_grupo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function insertarUsuarioGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_grupo_ep_ime');
		$this->setTransaccion('SG_UEP_INS');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('id_grupo','id_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function modificarUsuarioGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_grupo_ep_ime');
		$this->setTransaccion('SG_UEP_MOD');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario_grupo_ep','id_usuario_grupo_ep','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('id_grupo','id_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
	function eliminarUsuarioGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->setProcedimiento('segu.ft_usuario_grupo_ep_ime');
		$this->setTransaccion('SG_UEP_ELI');
		$this->setTipoProcedimiento('IME');
				
		//Define los parametros para la funcion
		$this->setParametro('id_usuario_grupo_ep','id_usuario_grupo_ep','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->getRespuesta();
	}
			
}
?>