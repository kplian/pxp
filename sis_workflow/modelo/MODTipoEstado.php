<?php
/**
*@package pXP
*@file gen-MODTipoEstado.php
*@author  (admin)
*@date 21-02-2013 15:36:11
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_estado_sel';
		$this->transaccion='WF_TIPES_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_estado','int4');
		$this->captura('nombre_estado','varchar');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('inicio','varchar');
		$this->captura('disparador','varchar');
		$this->captura('tipo_asignacion','varchar');
		$this->captura('nombre_func_list','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_proceso','varchar');
		$this->captura('codigo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	
	function listarFuncionarioWf(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_estado_sel';
        $this->transaccion='WF_TIPES_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        $this->setParametro('id_tipo_estado','id_tipo_estado','integer');
                
        //Definicion de la lista del resultado del query
        $this->captura('id_funcionario','int4');
        $this->captura('desc_funcionario','text');
        $this->captura('prioridad','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
	function insertarTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_estado_ime';
		$this->transaccion='WF_TIPES_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre_estado','nombre_estado','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('disparador','disparador','varchar');
		$this->setParametro('tipo_asignacion','tipo_asignacion','varchar');
		$this->setParametro('nombre_func_list','nombre_func_list','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_estado_ime';
		$this->transaccion='WF_TIPES_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');
		$this->setParametro('nombre_estado','nombre_estado','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('inicio','inicio','varchar');
		$this->setParametro('disparador','disparador','varchar');
		$this->setParametro('tipo_asignacion','tipo_asignacion','varchar');
		$this->setParametro('nombre_func_list','nombre_func_list','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_estado_ime';
		$this->transaccion='WF_TIPES_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_estado','id_tipo_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>