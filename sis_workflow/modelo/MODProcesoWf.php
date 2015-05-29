<?php
/**
*@package pXP
*@file gen-MODProcesoWf.php
*@author  (admin)
*@date 18-04-2013 09:01:51
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODProcesoWf extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarProcesoWf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.f_proceso_wf_sel';
		$this->transaccion='WF_PWF_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
		$this->setParametro('tipo_interfaz','tipo_interfaz','varchar');
		$this->setParametro('historico','historico','varchar');
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proceso_wf','int4');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('nro_tramite','varchar');
		$this->captura('id_estado_wf_prev','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_persona','int4');
		$this->captura('valor_cl','int8');
		$this->captura('id_institucion','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_tipo_proceso','varchar');
		$this->captura('tipo_ini','varchar');
		$this->captura('fecha_ini','date');
		$this->captura('desc_persona','text');
		$this->captura('desc_institucion','varchar');
		$this->captura('codigo_estado','varchar');
		
		$this->captura('id_estado_wf','integer');
		$this->captura('tipo_estado_inicio','varchar');
		$this->captura('tipo_estado_fin','varchar');
		$this->captura('tipo_estado_disparador','varchar');
		$this->captura('obs','text');
		
		
		
		
		
		
                              
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	/*
	
	DESC      Listado de estado del work flow para visto bueno desde la interface de mobile
	AUTHOR:  RAC
	
	*/
	
	function listarProcesoWfMobile(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.f_proceso_wf_sel';
        $this->transaccion='WF_VOBOWF_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('tipo_interfaz','tipo_interfaz','varchar');
        $this->setParametro('historico','historico','varchar');
                
        //Definicion de la lista del resultado del query
        $this->captura('id_proceso_wf','int4');
        $this->captura('id_tipo_proceso','int4');
        $this->captura('nro_tramite','varchar');
        $this->captura('id_estado_wf_prev','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_persona','int4');
        $this->captura('valor_cl','int8');
        $this->captura('id_institucion','int4');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('fecha_mod','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_tipo_proceso','varchar');
        $this->captura('tipo_ini','varchar');
        $this->captura('fecha_ini','date');
        $this->captura('desc_persona','text');
        $this->captura('desc_institucion','varchar');
        $this->captura('codigo_estado','varchar');
        
        $this->captura('id_estado_wf','integer');
        $this->captura('tipo_estado_inicio','varchar');
        $this->captura('tipo_estado_fin','varchar');
        $this->captura('tipo_estado_disparador','varchar');
        $this->captura('obs','text');
        
        $this->captura('desc_funcionario1','text');
        $this->captura('nombre_depto','varchar');
        $this->captura('usu_reg_ew','varchar');
        $this->captura('nombre_tipo_estado','varchar');
        
        $this->captura('nombre_subsistema','varchar');
        $this->captura('codigo_subsistema','varchar');
		
		$this->captura('prioridad','integer');
		$this->captura('revisado_asistente','varchar');
		$this->captura('contador_estados','bigint');
		
		
        
        
        
        
        
        
        
        
                              
        
        //Ejecuta la instruccion
        $this->armarConsulta();
		//echo $this->getConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
	/*
	Author:      RAC
	Date         14/08/2014
	Description: Funcion cuenta los registros nuevos a partir de una fecha pivote
	
	*/
	
	function chequeaEstadosMobile(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_CHECKVB_IME';
        $this->tipo_procedimiento='IME';//tipo de transaccion
        
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('fecha_pivote','fecha_pivote','timestamp');
       
                
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    
	
	
	
function listarGantWf(){
    
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_gant_wf';// nombre procedimiento almacenado
        $this->transaccion='WF_GATNREP_SEL';//nombre de la transaccion
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
        
        $this->setTipoRetorno('record');
        
        $this->setParametro('id_proceso_wf','id_proceso_wf','integer');
		$this->setParametro('orden','orden','varchar');
        
       //Definicion de la lista del resultado del query
        $this->captura('id','integer');                          
        $this->captura('id_proceso_wf','integer');
        $this->captura('id_estado_wf','integer');
        $this->captura('tipo','varchar');       
        $this->captura('nombre','varchar');
        $this->captura('fecha_ini','TIMESTAMP');
       
        $this->captura('fecha_fin','TIMESTAMP');        
        $this->captura('descripcion','varchar');
        $this->captura('id_siguiente','integer');
        $this->captura('tramite','varchar');
        $this->captura('codigo','varchar');
        
        $this->captura('id_funcionario','integer');
        $this->captura('funcionario','text');
        $this->captura('id_usuario','integer');
        $this->captura('cuenta','varchar');
        $this->captura('id_depto','integer');
        $this->captura('depto','varchar');
        $this->captura('nombre_usuario_ai','varchar');
		$this->captura('arbol','varchar');
		$this->captura('id_padre','integer');
		$this->captura('id_obs','integer');
		$this->captura('id_anterior','integer');
		$this->captura('etapa','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('disparador','varchar');
		
		
        
        
        //$this->captura('id_estructura_uo','integer');
        //Ejecuta la funcion
        $this->armarConsulta();
        
        //echo $this->getConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;

    }
    
    
			
	function insertarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_estado_wf_prev','id_estado_wf_prev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('valor_cl','valor_cl','int8');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('tipo_ini','tipo_ini','varchar');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->setParametro('id_estado_wf_prev','id_estado_wf_prev','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_uo','id_uo','int4');
		$this->setParametro('id_persona','id_persona','int4');
		$this->setParametro('valor_cl','valor_cl','int8');
		$this->setParametro('id_institucion','id_institucion','int4');
		$this->setParametro('tipo_ini','tipo_ini','varchar');
        $this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarProcesoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.f_proceso_wf_ime';
		$this->transaccion='WF_PWF_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	
	function checkNextState(){
        //chequea los procesos disparados para el estado especificado
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_CHKSTA_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('id_tipo_estado_sig','id_tipo_estado_sig','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function evaluaPlantillaEstado(){
        //chequea los procesos disparados para el estado especificado
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_EVAPLA_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_estado_wf','id_estado_wf','int4');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	
	
	
	function verficarSigEstProcesoWf(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_VERSIGPRO_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('operacion','operacion','varchar');
        
       //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function siguienteEstadoProcesoWf(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_SESPRO_IME';
        $this->tipo_procedimiento='IME';
        
        if (isset($this->arreglo['procesos'])){
        	$this->arreglo['procesos'] =  stripslashes ($this->arreglo['procesos'] );
        }
		else{
			$this->arreglo['procesos'] = '[]';
		}
		
        
        //Define los parametros para la funcion
        
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_estado_wf_act','id_estado_wf_act','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');
       
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function siguienteEstadoProcesoWfMobile(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_SIGPRO_IME';
        $this->tipo_procedimiento='IME';
        
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('id_estado_wf','id_estado_wf','int4');
        $this->setParametro('obs','obs','text');
        
       
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
	
	/*function siguienteEstadoProcesoWf(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_SIGPRO_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('operacion','operacion','varchar');
        
        $this->setParametro('id_funcionario','id_funcionario','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('obs','obs','text');
       
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }*/
    
    function anteriorEstadoProcesoWf(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_ANTEPRO_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('operacion','operacion','varchar');
        $this->setParametro('id_funcionario','id_funcionario','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_estado_wf','id_estado_wf','int4');
        $this->setParametro('obs','obs','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
				
	function estadosWF(){
		//Definicion de variables para ejecucion 
		$this->procedimiento = 'wf.f_proceso_wf_sel';
		$this->transaccion = 'WF_TRAWF_SEL';
		$this->tipo_procedimiento = 'SEL';
		
		//Define los porametros de la funcion
		$this->setParametro('nro_tramite','nro_tramite','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('estado','varchar');
		$this->captura('proceso','varchar');
		$this->captura('func','text');
		$this->captura('depto','varchar');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
    
    /*
    Author:      RCM
    Date         15/02/2015
    Description: Opción para reclamar un caso, es decir, autoasignarse una tarea
    */
    
    function reclamarCaso(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.f_proceso_wf_ime';
        $this->transaccion='WF_RECLAM_IME';
        $this->tipo_procedimiento='IME';//tipo de transaccion
        
        $this->arreglo['procesos'] =  stripslashes ($this->arreglo['procesos'] );
        //Define los parametros para la funcion
        
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_estado_wf_act','id_estado_wf_act','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>