<?php
/**
*@package pXP
*@file gen-MODGrupoEp.php
*@author  (admin)
*@date 22-04-2013 14:49:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODGrupoEp extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarGrupoEp(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_grupo_ep_sel';
		$this->transaccion='PM_GQP_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_grupo_ep','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_grupo','int4');
		$this->captura('id_ep','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('ep','text');
		$this->captura('id_uo','int4');
		$this->captura('desc_uo','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_grupo_ep_ime';
		$this->transaccion='PM_GQP_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_grupo','id_grupo','int4');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_uo','id_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_grupo_ep_ime';
		$this->transaccion='PM_GQP_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_grupo_ep','id_grupo_ep','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_grupo','id_grupo','int4');
		$this->setParametro('id_ep','id_ep','int4');
		$this->setParametro('id_uo','id_uo','int4');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarGrupoEp(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_grupo_ep_ime';
		$this->transaccion='PM_GQP_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_grupo_ep','id_grupo_ep','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function sincUoEp(){
        
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='param.ft_grupo_ep_ime';
        $this->transaccion='PM_SINCGREPUO_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('config','config','varchar');
        $this->setParametro('id_grupo','id_grupo','int4');
        
        

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>