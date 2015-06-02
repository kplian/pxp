<?php
/**
*@package pXP
*@file gen-MODTipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoDocumento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='wf.ft_tipo_documento_sel';
		$this->transaccion='WF_TIPDW_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_documento','int4');
		$this->captura('nombre','varchar');
		$this->captura('id_proceso_macro','int4');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','text');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo','varchar');
		$this->captura('id_tipo_proceso','int4');
		$this->captura('action','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('solo_lectura','varchar');
		$this->captura('categoria_documento','varchar');
		$this->captura('orden','numeric');
		$this->captura('nombre_vista','varchar');
		$this->captura('nombre_archivo_plantilla','text');
		$this->captura('esquema_vista','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		
		$this->setParametro('action','action','varchar');
		$this->setParametro('solo_lectura','solo_lectura','varchar');
		$this->setParametro('categoria_documento','categoria_documento','varchar');
		$this->setParametro('orden','orden','numeric');
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        $this->setParametro('nombre_archivo_plantilla','nombre_archivo_plantilla','text');
		$this->setParametro('esquema_vista','esquema_vista','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('id_proceso_macro','id_proceso_macro','int4');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('id_tipo_proceso','id_tipo_proceso','int4');
		$this->setParametro('action','action','varchar');
		$this->setParametro('solo_lectura','solo_lectura','varchar');
        $this->setParametro('categoria_documento','categoria_documento','varchar');
		$this->setParametro('orden','orden','numeric');
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        $this->setParametro('nombre_archivo_plantilla','nombre_archivo_plantilla','text');
        $this->setParametro('esquema_vista','esquema_vista','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoDocumento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='wf.ft_tipo_documento_ime';
		$this->transaccion='WF_TIPDW_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_documento','id_tipo_documento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    
    function listarColumnasPlantillaDocumento(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function listarTipoDocumentoXTipoPRocesoEstado(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TPROTIDOC_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
                
        //Definicion de la lista del resultado del query
        $this->captura('id_tipo_documento','int4');
        $this->captura('nombre','varchar');
        $this->captura('id_proceso_macro','int4');
        $this->captura('codigo','varchar');
        $this->captura('descripcion','text');
        $this->captura('estado_reg','varchar');
        $this->captura('tipo','varchar');
        $this->captura('id_tipo_proceso','int4');
        $this->captura('action','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('solo_lectura','varchar');
        $this->captura('nombre_vista','varchar');
        $this->captura('nombre_archivo_plantilla','text');
        $this->captura('esquema_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function obtenerColumnasVista(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        $this->resetParametros();
        $this->resetCaptura();
        
        $this->setParametrosConsulta();
                
        //Definición de columnas
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;
    }

    function generarDocumento(){
        //Definicion de variables para ejecucion del procedimiento
        //1. Se obtiene las columas de la vista de base de datos
        $this->procedimiento='wf.ft_tipo_documento_sel';
        $this->transaccion='WF_TIDOCPLAN_SEL';
        $this->tipo_procedimiento='SEL';
        $this->setCount(false);
        $this->resetParametros();
        $this->resetCaptura();
        
        $this->setParametrosConsulta();
                
        //Definición de columnas
        $this->captura('column_name','varchar');
        $this->captura('data_type','varchar');
        $this->captura('character_maximum_length','int4');
        
        $this->setParametro('nombre_vista','nombre_vista','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        if ($link == 0) {
            $cone = new conexion(); 
            $link = $cone->conectarnp();
            $primera_vez = 0;           
        }
        
        $array = array();
        try {
            $res = pg_query($link,$this->consulta);
            
            if ($res) {
                $i = 0;
                while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
                    //obtener las columnas
                    array_push ($array, $row);
                    
                }
                pg_free_result($res);
               
                if(count($array)==0){
                    $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));              
                    //Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
                    $this->respuesta=new Mensaje();
                    $this->respuesta->setMensaje('ERROR','MODTipoDocumento.php','El Documento no tiene una vista de base de datos asociado.','El Documento no tiene una vista de base de datos asociada.','Control',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
                    return $this->respuesta;
                }
                
                ////////////////////////////////////////////////////////////////////
                //Obtención de la definición de columnas de la vista del documento
                ////////////////////////////////////////////////////////////////////
                $arrDefCols = array();
                $i=0;
                foreach ($array as $clave => $valor){
                    $j=0;
                    foreach ($valor as $clave1 => $valor1){
                        $arrDefCols[$i][$j]=$valor1;
                        $j++;
                    }
                    $i++;
                }
                //var_dump($arrDefCols);exit;
                
                ///////////////////////////////////////////////////////////
                //2. Ejecución de consulta para obtener los datos de la vista de base de datos
                ///////////////////////////////////////////////////////////
                $this->procedimiento='wf.ft_tipo_documento_sel';
                $this->transaccion='WF_VISTA_SEL';
                $this->tipo_procedimiento='SEL';
                $this->setCount(false);
                $this->resetParametros();
                $this->resetCaptura();
                
                $this->setParametrosConsulta();
                
                //Definición de columnas
                foreach($arrDefCols as $clave => $valor){
                    $columna=array();
                    $j=0;
                    foreach ($valor as $clave1 => $valor1){
                        $columna[$j]=$valor1;
                        $j++;
                    }
                    //echo $columna[0] .': '.$columna[1];
                    $this->captura($columna[0],$columna[1]);
                }
                
                //Envío de parámetro id_proceso_wf
                $this->setParametro('id_proceso_wf','id_proceso_wf','int4');
                $this->setParametro('nombre_vista','nombre_vista','varchar');
                $this->setParametro('esquema_vista','esquema_vista','varchar');
                
                //Ejecuta la instruccion
                $this->armarConsulta();
				//echo $this->consulta;exit;
                $this->ejecutarConsulta();
                
                return $this->respuesta;
 
            } else {
                $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));              
                //Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
                $this->respuesta=new Mensaje();
                $this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
                return $this->respuesta;
            }
        } catch (Exception $e) {
            $this->respuesta=new Mensaje();
            $resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($link)));
            $this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
            return $this->respuesta;
        }

    }

	function subirPlantilla1(){
        $this->procedimiento='wf.ft_tipo_documento_ime';
        $this->transaccion='WF_UPLPLA_MOD';
        $this->tipo_procedimiento='IME';
		
		if ($this->arregloFiles['archivo']['name'] == "") {
			throw new Exception("El archivo no puede estar vacio");
		}
        
        //$ext = pathinfo($this->arregloFiles['archivo']['name']);
        $rr=$this->objParam->getFiles();
		//var_dump($rr);
        //$ext = pathinfo($rr['archivo']['name']);
      	//$this->arreglo['nombre_archivo_plantilla']= $this->arreglo['nombre_archivo_plantilla'].$this->arreglo['archivo'];
		
		$ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
		//var_dump($this->arreglo);exit;
		
        //Define los parametros para la funcion 
        $this->setParametro('id_tipo_documento','id_tipo_documento','integer');   
        $this->setParametro('nombre_archivo','nombre_archivo','bytea',false,'',false,array('doc','docx'));
		$this->setParametro('nombre_archivo_plantilla','nombre_archivo_plantilla','varchar');
		$this->setParametro('nombre_vista','nombre_vista','varchar');
		$this->setParametro('esquema_vista','esquema_vista','varchar');
                
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }


	function subirPlantilla(){ 
                    
            $cone = new conexion();
			$link = $cone->conectarpdo();
			$copiado = false;			
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();
				
				if ($this->arregloFiles['archivo']['name'] == "") {
					throw new Exception("El archivo no puede estar vacio");
				}
				
	            $this->procedimiento='wf.ft_tipo_documento_ime';
	            $this->transaccion='WF_UPLPLA_MOD';
	            $this->tipo_procedimiento='IME';
	            
	            $ext = pathinfo($this->arregloFiles['archivo']['name']);
	            $this->arreglo['extension'] = $ext['extension'];
	            
				//validar que no sea un arhvio en blanco
				$file_name = $this->getFileName2('archivo', 'id_tipo_documento', '', false);
				
				//$this->objParam->addParametro('nombre_archivo_plantilla',$file_name[1]);
				
	            //Define los parametros para la funcion 
	            $this->setParametro('id_tipo_documento','id_tipo_documento','integer');   
		        $this->setParametro('nombre_archivo','nombre_archivo','bytea',false,'',false,array('doc','docx'));
				$this->setParametro('nombre_archivo_plantilla',$file_name[1],'varchar');
				$this->setParametro('nombre_vista','nombre_vista','varchar');
				$this->setParametro('esquema_vista','esquema_vista','varchar');
	            
	            
	            
	            //manda como parametro la url completa del archivo
	            //var_dump($file_name[2]);exit;
	            
				$this->variables[]='nombre_archivo_plantilla';
				$this->valores[]=$file_name[2];
				$this->tipos[]='varchar';
				/*var_dump($this->variables);
				var_dump($this->valores);
				var_dump($this->tipos);exit;*/ 
				
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
	               $this->setFile('archivo','id_tipo_documento', false,25600 ,array('doc','docx','DOC','DOCX'));
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

			
}
?>