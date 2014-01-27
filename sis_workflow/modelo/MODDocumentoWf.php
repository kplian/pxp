<?php
/**
*@package pXP
*@file gen-MODDocumentoWf.php
*@author  (admin)
*@date 15-01-2014 13:52:19
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDocumentoWf extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDocumentoWf(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_documento_wf_sel';
		$this->transaccion='WF_DWF_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');		
		//Definicion de la lista del resultado del query
		$this->captura('id_documento_wf','int4');
		$this->captura('url','varchar');
		$this->captura('num_tramite','varchar');
		$this->captura('id_tipo_documento','int4');
		$this->captura('obs','text');
		$this->captura('id_proceso_wf','int4');
		$this->captura('extension','varchar');
		$this->captura('chequeado','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre_tipo_doc','varchar');
		$this->captura('nombre_doc','varchar');
		$this->captura('momento','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo_tipo_proceso','varchar');
		$this->captura('codigo_tipo_documento','varchar');
		$this->captura('nombre_tipo_documento','varchar');
		$this->captura('descripcion_tipo_documento','TEXT');
		$this->captura('nro_tramite','varchar');
		$this->captura('codigo_proceso','varchar');
		$this->captura('descripcion_proceso_wf','varchar');
		$this->captura('nombre_estado','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDocumentoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_documento_wf_ime';
		$this->transaccion='WF_DWF_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('url','url','varchar');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('obs','obs','text');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('extencion','extencion','varchar');
		$this->setParametro('chequeado','chequeado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_tipo_doc','nombre_tipo_doc','varchar');
		$this->setParametro('nombre_doc','nombre_doc','varchar');
		$this->setParametro('momento','momento','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDocumentoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_documento_wf_ime';
		$this->transaccion='WF_DWF_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_wf','id_documento_wf','int4');
		$this->setParametro('url','url','varchar');
		$this->setParametro('num_tramite','num_tramite','varchar');
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('obs','obs','text');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('extencion','extencion','varchar');
		$this->setParametro('chequeado','chequeado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre_tipo_doc','nombre_tipo_doc','varchar');
		$this->setParametro('nombre_doc','nombre_doc','varchar');
		$this->setParametro('momento','momento','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDocumentoWf(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_documento_wf_ime';
		$this->transaccion='WF_DWF_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_documento_wf','id_documento_wf','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function subirDocumentoWfArchivo(){
        $this->procedimiento='wf.ft_documento_wf_ime';
        $this->transaccion='WF_DOCWFAR_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_documento_wf','id_documento_wf','integer');   
        $this->setParametro('extension','extension','varchar');
        
        $file_name = $this->setFile('archivo','id_documento_wf', false,$this->arreglo['num_tramite'],array('doc','pdf','docx','jpg','jpeg','bmp','gif','png'));
         
        
         
        //manda como parametro el nombre del arhivo 
        $this->aParam->addParametro('file_name',$file_name);
        $this->arreglo['file_name']= $file_name;
        $this->setParametro('file_name','file_name','varchar');       
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
			
}
?>