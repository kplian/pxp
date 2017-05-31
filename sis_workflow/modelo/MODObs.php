<?php
/**
*@package pXP
*@file gen-MODObs.php
*@author  (admin)
*@date 20-11-2014 18:53:55
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODObs extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarObs(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_obs_sel';
		$this->transaccion='WF_OBS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		 $this->setParametro('id_proceso_wf','id_proceso_wf','integer');  
		 $this->setParametro('id_estado_wf','id_estado_wf','integer');  
		 $this->setParametro('num_tramite','num_tramite','varchar');
		 $this->setParametro('todos','todos','integer');   
		 
				
		//Definicion de la lista del resultado del query
		$this->captura('id_obs','int4');
		$this->captura('fecha_fin','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_funcionario_resp','int4');
		$this->captura('titulo','varchar');
		$this->captura('desc_fin','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_funcionario','text');
		
		$this->captura('codigo_tipo_estado','varchar');
		$this->captura('nombre_tipo_estado','varchar');
		$this->captura('nombre_tipo_proceso','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

    function listarObsFuncionario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_obs_sel';
		$this->transaccion='WF_OBSFUN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		
		 
				
		//Definicion de la lista del resultado del query
		$this->captura('id_obs','int4');
		$this->captura('fecha_fin','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('estado','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_funcionario_resp','int4');
		$this->captura('titulo','varchar');
		$this->captura('desc_fin','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo_tipo_estado','varchar');
		$this->captura('nombre_tipo_estado','varchar');
		$this->captura('nombre_tipo_proceso','varchar');
		$this->captura('nro_tramite','varchar');
		$this->captura('id_estado_wf','int4');
		$this->captura('id_proceso_wf','int4');

		$this->captura('usr_actual','int4');
		$this->captura('desc_fun_obs','text');
		$this->captura('desc_funcionario','text');
		$this->captura('numero','varchar');
		$this->captura('num_tramite','varchar');
		$this->captura('email_empresa','varchar');


		//Ejecuta la instruccion
		$this->armarConsulta();
		//var_dump($this->consulta);exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}


			
	function insertarObs(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_obs_ime';
		$this->transaccion='WF_OBS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fecha_fin','fecha_fin','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_funcionario_resp','id_funcionario_resp','int4');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('desc_fin','desc_fin','varchar');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		
		//Nos sirve para insertar un correo CC
		//$this->setParametro('id_funcionario_cc','id_funcionario_cc','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarObs(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_obs_ime';
		$this->transaccion='WF_OBS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_obs','id_obs','int4');
		$this->setParametro('fecha_fin','fecha_fin','timestamp');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_funcionario_resp','id_funcionario_resp','int4');
		$this->setParametro('titulo','titulo','varchar');
		$this->setParametro('desc_fin','desc_fin','varchar');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarObs(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_obs_ime';
		$this->transaccion='WF_OBS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_obs','id_obs','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function cerrarObs(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_obs_ime';
		$this->transaccion='WF_CERRAROBS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_obs','id_obs','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>