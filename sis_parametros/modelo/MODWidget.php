<?php
/**
*@package pXP
*@file gen-MODWidget.php
*@author  (admin)
*@date 10-09-2016 08:00:16
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODWidget extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarWidget(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='param.ft_widget_sel';
		$this->transaccion='PM_WID_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_widget','int4');
		$this->captura('ruta','varchar');
		$this->captura('nombre','varchar');
		$this->captura('foto','varchar');
		$this->captura('obs','varchar');
		$this->captura('clase','varchar');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarWidget(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_widget_ime';
		$this->transaccion='PM_WID_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('ruta','ruta','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('foto','foto','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('clase','clase','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarWidget(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_widget_ime';
		$this->transaccion='PM_WID_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_widget','id_widget','int4');
		$this->setParametro('ruta','ruta','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('foto','foto','varchar');
		$this->setParametro('obs','obs','varchar');
		$this->setParametro('clase','clase','varchar');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarWidget(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='param.ft_widget_ime';
		$this->transaccion='PM_WID_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_widget','id_widget','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function subirImagen(){
		
		
		 $cone = new conexion();
			$link = $cone->conectarpdo();
			$copiado = false;			
			try {
				
				$link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		
		  	    $link->beginTransaction();
				
				if ($this->arregloFiles['file_documento']['name'] == "") {
					throw new Exception("El archivo no puede estar vacio");
				}
				
				$this->procedimiento='param.ft_widget_ime';
		        $this->transaccion='PM_WIDIMG_INS';
		        $this->tipo_procedimiento='IME';
				
				
				
				//validar que no sea un arhvio en blanco
				$file_name = $this->getFileName2('file_documento', 'id_widget', '','_v');
				
				

			   
			    //manda como parametro la url completa del archivo 
	            $this->aParam->addParametro('foto', $file_name[2]);
	            $this->arreglo['foto'] = $file_name[2];
	            $this->setParametro('foto','foto','varchar'); 
				
				
				//Define los parametros para la funcion	
		        $this->setParametro('id_widget','id_widget','integer');

				      
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
				   
				   
				   //cipiamos el nuevo archivo 
	               $this->setFile('file_documento','id_widget', false,100000 ,array('jpg','jpeg','bmp','gif','png'), $folder = '','_v'.$version);
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
			
}
?>