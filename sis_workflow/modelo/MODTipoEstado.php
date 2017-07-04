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
		$this->captura('codigo_estado','varchar');
		$this->captura('obs','text');
		$this->captura('depto_asignacion','varchar');
		$this->captura('nombre_depto_func_list','varchar');
		$this->captura('fin','varchar');
		$this->captura('alerta','varchar');
		$this->captura('pedir_obs','varchar');
		
		$this->captura('plantilla_mensaje_asunto','varchar');
		$this->captura('plantilla_mensaje','varchar');
		$this->captura('cargo_depto','varchar');
		
		$this->captura('funcion_inicial','varchar');
		$this->captura('funcion_regreso','varchar');
		$this->captura('mobile','varchar');
		
		$this->captura('acceso_directo_alerta','varchar');
		$this->captura('nombre_clase_alerta','varchar');
		$this->captura('tipo_noti','varchar');
		$this->captura('titulo_alerta','varchar');
		$this->captura('parametros_ad','varchar');
		$this->captura('id_roles','text');
		$this->captura('admite_obs','varchar');
		$this->captura('etapa','varchar');
		$this->captura('grupo_doc','varchar');
		$this->captura('id_tipo_estado_anterior','integer');
		$this->captura('desc_tipo_estado_anterior','text');
		$this->captura('icono','varchar');
		
		
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	
	function listarFuncionarioWf(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_estado_sel';
        $this->transaccion='WF_FUNTIPES_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        //$this->setCount(false);
        
        
        $this->setParametro('id_tipo_estado','id_tipo_estado','integer');
        $this->setParametro('fecha','fecha','date');
        $this->setParametro('id_estado_wf','id_estado_wf','integer');
		$this->setParametro('id_depto_wf','id_depto_wf','integer');
        
        //Definicion de la lista del resultado del query
        $this->captura('id_funcionario','int4');
        $this->captura('desc_funcionario','text');
        $this->captura('desc_funcionario_cargo','text');
        $this->captura('prioridad','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function listarDeptoWf(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_estado_sel';
        $this->transaccion='WF_DEPTIPES_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        
        //$this->setCount(false);
        
        $this->setParametro('id_tipo_estado','id_tipo_estado','integer');
        $this->setParametro('fecha','fecha','date');
        $this->setParametro('id_estado_wf','id_estado_wf','integer');
        
        //Definicion de la lista del resultado del query
        $this->captura('id_depto','int4');
        $this->captura('codigo_depto','varchar');
        $this->captura('nombre_corto_depto','varchar');
        $this->captura('nombre_depto','varchar');
        $this->captura('prioridad','int4');
        $this->captura('subsistema','varchar');
        
       
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
		$this->setParametro('codigo_estado','codigo_estado','varchar');
		$this->setParametro('obs','obs','text');
		$this->setParametro('depto_asignacion','depto_asignacion','varchar');
		$this->setParametro('nombre_depto_func_list','nombre_depto_func_list','varchar');
		$this->setParametro('fin','fin','varchar');
		$this->setParametro('alerta','alerta','varchar');
		$this->setParametro('pedir_obs','pedir_obs','varchar');
		$this->setParametro('cargo_depto','cargo_depto','varchar');
		
		$this->setParametro('funcion_inicial','funcion_inicial','varchar');
		$this->setParametro('funcion_regreso','funcion_regreso','varchar');
		$this->setParametro('mobile','mobile','varchar');
		
		$this->setParametro('acceso_directo_alerta','acceso_directo_alerta','varchar');
		$this->setParametro('nombre_clase_alerta','nombre_clase_alerta','varchar');
		$this->setParametro('tipo_noti','tipo_noti','varchar');
		$this->setParametro('titulo_alerta','titulo_alerta','varchar');
		$this->setParametro('parametros_ad','parametros_ad','varchar');
		$this->setParametro('id_roles','id_roles','varchar');
		$this->setParametro('admite_obs','admite_obs','varchar');
		$this->setParametro('etapa','etapa','varchar');
		$this->setParametro('grupo_doc','grupo_doc','codigo_html');
		$this->setParametro('id_tipo_estado_anterior','id_tipo_estado_anterior','integer');
		$this->setParametro('icono','icono','varchar');
		
		
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
		$this->setParametro('codigo_estado','codigo_estado','varchar');
		$this->setParametro('obs','obs','text');
		$this->setParametro('depto_asignacion','depto_asignacion','varchar');
        $this->setParametro('nombre_depto_func_list','nombre_depto_func_list','varchar');
        $this->setParametro('fin','fin','varchar');
		$this->setParametro('alerta','alerta','varchar');
        $this->setParametro('pedir_obs','pedir_obs','varchar');
        $this->setParametro('cargo_depto','cargo_depto','varchar');
        $this->setParametro('funcion_inicial','funcion_inicial','varchar');
        $this->setParametro('funcion_regreso','funcion_regreso','varchar');
        $this->setParametro('mobile','mobile','varchar');        
        $this->setParametro('acceso_directo_alerta','acceso_directo_alerta','varchar');
        $this->setParametro('nombre_clase_alerta','nombre_clase_alerta','varchar');
        $this->setParametro('tipo_noti','tipo_noti','varchar');
        $this->setParametro('titulo_alerta','titulo_alerta','varchar');
        $this->setParametro('parametros_ad','parametros_ad','varchar');
		$this->setParametro('id_roles','id_roles','varchar');
		$this->setParametro('admite_obs','admite_obs','varchar');
        $this->setParametro('etapa','etapa','varchar');
		$this->setParametro('grupo_doc','grupo_doc','codigo_html');
		$this->setParametro('id_tipo_estado_anterior','id_tipo_estado_anterior','integer');
		$this->setParametro('icono','icono','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function modificarPlantillaCorreo(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_tipo_estado_ime';
        $this->transaccion='WF_UPDPLAMEN_MOD';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('plantilla_mensaje_asunto','plantilla_mensaje_asunto','varchar');
        $this->setParametro('plantilla_mensaje','plantilla_mensaje','codigo_html');

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

	//RCM: Listado de los siguientes estados posibles
	function listarEstadoSiguiente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_estado_sel';
		$this->transaccion='WF_SIGEST_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('id_tipo_estado_padre','id_tipo_estado_padre','int4');
				
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
		$this->captura('codigo_estado','varchar');
		$this->captura('obs','text');
		$this->captura('depto_asignacion','varchar');
		$this->captura('nombre_depto_func_list','varchar');
		$this->captura('fin','varchar');
		$this->captura('alerta','varchar');
		$this->captura('pedir_obs','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>