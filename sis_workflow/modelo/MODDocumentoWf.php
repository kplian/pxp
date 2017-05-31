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
		$this->setParametro('todos_documentos','todos_documentos','varchar');		
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
		$this->captura('chequeado_fisico','varchar');
		
		$this->captura('usr_upload','varchar');
        $this->captura('fecha_upload','timestamp');
        
        $this->captura('tipo_documento','varchar');
        
        $this->captura('action','varchar');
		$this->captura('solo_lectura','varchar');
		
		$this->captura('id_documento_wf_ori','integer');
		$this->captura('id_proceso_wf_ori','integer');
		$this->captura('nro_tramite_ori','varchar');
		$this->captura('priorizacion','integer');
		$this->captura('modificar','varchar');
		$this->captura('insertar','varchar');
		$this->captura('eliminar','varchar');
		$this->captura('demanda','varchar');
		$this->captura('nombre_vista','varchar');
		$this->captura('esquema_vista','varchar');
		$this->captura('nombre_archivo_plantilla','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		
		//Devuelve la respuesta
		return $this->respuesta;
	}

	function getRutaDocumento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_documento_wf_sel';
		$this->transaccion='WF_DWFRUTA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion


		
		$this->count=false;
		

        $this->setParametro('dominio','dominio','varchar');
		//Definicion de la lista del resultado del query

		$this->captura('url','varchar');
		
		
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
		$this->setParametro('id_tipo_documentos','id_tipo_documentos','varchar');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		
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
		$this->setParametro('chequeado_fisico','chequeado_fisico','varchar');

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

            $cone = new conexion();
			$link = $cone->conectarpdo();
			$copiado = false;

            
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();

				if ($this->arregloFiles['archivo']['name'] == "") {
					throw new Exception("El archivo no puede estar vacio");
				}

	            $this->procedimiento='wf.ft_documento_wf_ime';
	            $this->transaccion='WF_DOCWFAR_MOD';
	            $this->tipo_procedimiento='IME';
	            
	            $ext = pathinfo($this->arregloFiles['archivo']['name']);
	            $this->arreglo['extension'] = $ext['extension'];
	            
				//validar que no sea un arhvio en blanco
				$file_name = $this->getFileName2('archivo', 'id_documento_wf', '', false);
				
	            //Define los parametros para la funcion 
	            $this->setParametro('id_documento_wf','id_documento_wf','integer');   
	            $this->setParametro('extension','extension','varchar');
	            
	            
	            
	            //manda como parametro la url completa del archivo 
	            $this->aParam->addParametro('file_name', $file_name[2]);
	            $this->arreglo['file_name'] = $file_name[2];
	            $this->setParametro('file_name','file_name','varchar'); 
				
				//manda como parametro el folder del arhivo 
	            $this->aParam->addParametro('folder', $file_name[1]);
	            $this->arreglo['folder'] = $file_name[1];
	            $this->setParametro('folder','folder','varchar'); 
				
				//manda como parametro el solo el nombre del arhivo  sin extencion
	            $this->aParam->addParametro('only_file', $file_name[0]);
	            $this->arreglo['only_file'] = $file_name[0];
	            $this->setParametro('only_file','only_file','varchar'); 
				
				      
	            //Ejecuta la instruccion
	            $this->armarConsulta();
				$stmt = $link->prepare($this->consulta);		  
			  	$stmt->execute();
				$result = $stmt->fetch(PDO::FETCH_ASSOC);				
				$resp_procedimiento = $this->divRespuesta($result['f_intermediario_ime']);
				
				
				if ($resp_procedimiento['tipo_respuesta']=='ERROR') {
					throw new Exception("Error al ejecutar en la bd", 3);
				}
	             
				  
	            
	            
				 if($resp_procedimiento['tipo_respuesta'] == 'EXITO'){
	              
				   //revisamos si ya existe el archivo la verison anterior sera mayor a cero
				   $respuesta = $resp_procedimiento['datos'];
				   //var_dump($respuesta);
				   if($respuesta['max_version'] != '0' && $respuesta['url_destino'] != ''){
				   	 
	                      $this->copyFile($respuesta['url_origen'], $respuesta['url_destino'],  $folder = 'historico');
				   	      $copiado = true;
				   }
				   
				   //cipiamos el nuevo archivo 
	               $this->setFile('archivo','id_documento_wf', false,100000 ,array('doc','pdf','docx','jpg','jpeg','bmp','gif','png','PDF','DOC','DOCX','xls','xlsx','XLS','XLSX','rar','txt'));
	            }
				
				$link->commit();
				$this->respuesta=new Mensaje();
				$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				$this->respuesta->setDatos($respuesta);
	        } 
	        
	        catch (Exception $e) {			
		    	$link->rollBack();
				
				if($copiado){
				   	 $this->copyFile($respuesta['url_origen'], $respuesta['url_destino'],  $folder = 'historico', true);
				}
		    	$this->respuesta=new Mensaje();
				if ($e->getCode() == 3) {//es un error de un procedimiento almacenado de pxp
					$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				} else if ($e->getCode() == 2) {//es un error en bd de una consulta
					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$e->getMessage(),$e->getMessage(),'modelo','','','','');
				} else {//es un error lanzado con throw exception
					throw new Exception($e->getMessage(), 2);
				}
		}    
	    
	    return $this->respuesta;
	      
    }

	function firmarDocumento(){ 
                    
            $cone = new conexion();
			$link = $cone->conectarpdo('','segu');
			
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();
				
								
	            $this->procedimiento='wf.ft_documento_wf_ime';
	            $this->transaccion='WF_DOCWFAR_MOD';
	            $this->tipo_procedimiento='IME';	            
	            $this->id_usuario = 1;
	            $this->arreglo['extension'] = "pdf";
	            
				
				
	            //Define los parametros para la funcion 
	            $this->setParametro('id_documento_wf','id_documento_wf','integer');   
	            $this->setParametro('extension','extension','varchar');
	            
	            
	            
	            //manda como parametro la url completa del archivo 
	            $this->arreglo['file_name'] = './../../../uploaded_files/sis_workflow/DocumentoWf/'.$this->objParam->getParametro('archivo_generado');
	            $this->setParametro('file_name','file_name','varchar');
				
				
				$this->arreglo['folder'] = './../../../uploaded_files/sis_workflow/DocumentoWf/';
	            $this->setParametro('folder','folder','varchar');
				
				$this->arreglo['only_file'] = str_replace('.pdf', '', $this->objParam->getParametro('archivo_generado'));
	            $this->setParametro('only_file','only_file','varchar');
				
				$this->setParametro('hash_firma','hash_firma','varchar');  
	            $this->setParametro('datos_firma','datos_firma','text');  
				
								
				      
	            //Ejecuta la instruccion
	            $this->armarConsulta();
				
				$stmt = $link->prepare($this->consulta);		  
			  	$stmt->execute();
				$result = $stmt->fetch(PDO::FETCH_ASSOC);				
				$resp_procedimiento = $this->divRespuesta($result['f_intermediario_ime']);
				
				
				if ($resp_procedimiento['tipo_respuesta']=='ERROR') {
					throw new Exception("Error al ejecutar en la bd", 3);
				}
	             
				  
	            
	            
				 if($resp_procedimiento['tipo_respuesta'] == 'EXITO'){
								   
				   $this->copyFile('./../../../reportes_generados/'.$this->objParam->getParametro('archivo_generado'), './../../../uploaded_files/sis_workflow/DocumentoWf/'.$this->objParam->getParametro('archivo_generado'));
	            }
				
				$link->commit();
				$this->respuesta=new Mensaje();
				$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				$this->respuesta->setDatos($respuesta);
	        } 
	        
	        catch (Exception $e) {			
		    	$link->rollBack();
		    	$this->respuesta=new Mensaje();
				if ($e->getCode() == 3) {//es un error de un procedimiento almacenado de pxp
					$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				} else if ($e->getCode() == 2) {//es un error en bd de una consulta
					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$e->getMessage(),$e->getMessage(),'modelo','','','','');
				} else {//es un error lanzado con throw exception

                    throw new Exception($e->getMessage(), 2);
				}
		}    
	    
	    return $this->respuesta;
	      
    }

	function eliminarArchivo(){ 
                    
            $cone = new conexion();
			$link = $cone->conectarpdo('','segu');
			
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();				
								
	            $this->procedimiento='wf.ft_documento_wf_ime';
	            $this->transaccion='WF_DOCWELIAR_MOD';
	            $this->tipo_procedimiento='IME';     
	            
	            $this->id_usuario = 1;
	            //Define los parametros para la funcion 
	            $this->setParametro('id_documento_wf','id_documento_wf','integer');   
	            $this->setParametro('url','url','varchar');  
				      
	            //Ejecuta la instruccion
	            $this->armarConsulta();
				$stmt = $link->prepare($this->consulta);		  
			  	$stmt->execute();
				$result = $stmt->fetch(PDO::FETCH_ASSOC);				
				$resp_procedimiento = $this->divRespuesta($result['f_intermediario_ime']);
				
				
				if ($resp_procedimiento['tipo_respuesta']=='ERROR') {
					throw new Exception("Error al ejecutar en la bd", 3);
				}    
				  
	            
	            
				if($resp_procedimiento['tipo_respuesta'] == 'EXITO'){
					$respuesta = $resp_procedimiento['datos'];				   
				   	$this->copyFile($this->objParam->getParametro('url'), $respuesta['url_destino']);
	            }
				
				$link->commit();
				$this->respuesta=new Mensaje();
				$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				$this->respuesta->setDatos($respuesta);
	        } 
	        
	        catch (Exception $e) {			
		    	$link->rollBack();
		    	$this->respuesta=new Mensaje();
				if ($e->getCode() == 3) {//es un error de un procedimiento almacenado de pxp
					$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				} else if ($e->getCode() == 2) {//es un error en bd de una consulta
					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$e->getMessage(),$e->getMessage(),'modelo','','','','');
				} else {//es un error lanzado con throw exception
					throw new Exception($e->getMessage(), 2);
				}
		}    
	    
	    return $this->respuesta;
	      
    }
    
    function cambiarMomento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_documento_wf_ime';
        $this->transaccion='WF_CABMOM_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_documento_wf','id_documento_wf','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }





   function verificarConfiguracion(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_documento_wf_ime';
        $this->transaccion='WF_VERDOC_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>
