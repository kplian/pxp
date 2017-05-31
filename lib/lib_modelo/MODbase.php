<?php
//include '../lib_modelo/driver.php';
class MODbase extends driver
{
	protected $aParam;
	public $arreglo;
	protected $arregloFiles;
	protected $arreglo_consultas;
	protected $validacion;
	protected $nombre_archivo;
	protected $objParam;
	


	//Constructor que obtiene los datos de parametros e inicializa el driver
	function __construct($pParam){
		
		$this->objParam=$pParam;
		$this->nombre_archivo='MODbase.php';
		parent::__construct();
		//Guarda los parametros en variable local
		$this->validacion=new MODValidacion();
		

		if($this->objParam==null){
			$this->esMatriz=false;
				
		}
		else{
				
			$this->aParam=$this->objParam;
			//recibe los parametros pasados desde la vista
			$this->arreglo=$this->aParam->getArregloParametros();
			
			$this->arregloFiles=$this->aParam->getArregloFiles();
			
		
			
			//oprine parametros de consulta como los filtros, etc
			$this->arreglo_consultas=$this->aParam->getParametrosConsulta();
			
			//RAC 25/10/2011: validacion de varialbes
			if(isset($this->arreglo_consultas['cont'])){
				if($this->arreglo_consultas['cont']=='false'){
					$this->count=false;
				}
			}
			//define el tipo de trasaccion
			if(isset($this->Tipo)){
			   $this->aParam->setTipotran($this->Tipo);
			}
			//son datos devueltos en formato matriz, ejem desde la grilla
			$this->esMatriz=$this->aParam->esMatriz();
			if(!$this->esMatriz){
				$this->setParametrosConsulta();
			}
			else{
				//si es matriz enumera todas lafilas
				$cont=0;
				array_push($this->variables,'_fila');
				array_push($this->tipos,'integer');
				foreach ($this->arreglo as $row){
						
					$this->validacion->validar('_fila',$row['_fila'],'integer',false,'',null,null);
					        
					
					$this->valores[$cont]['_fila']=$row['_fila'];
					$cont++;
				}
			}
			$this->setUsuarioAi();
			

		}

	}

	function armarConsulta(){
		

		if(count($this->validacion->getRes())==0){
			parent::armarConsulta();
		}
	}
	function ejecutarConsulta($res=null){
	        
	   try {
		     
		if(count($this->validacion->getRes())==0){
			parent::ejecutarConsulta($res);
		}
		else{
			$this->generaRespuestaParametros();
		}
		
     }	 
      catch (Exception $e){
           //TODO   DEBUG DE ERRORES  
          //echo 'Error capturado -> '.$e->getMessage();
      }
		

	}



	/**
	 * Nombre funcion:	parametro
	 * Proposito:		Anade una parametro que se coloca en el arreglo de 
	 *                  parametros a ser enviados a un procedimeinto
	 *                  se utiliza desde clases de modelo MD
	 * Fecha creacion:	12/04/2009
	 * @param $nombre El nombre del campo que se envia
	 * @param $nombre_parametro  Nombre del campo que se envia desde la vista
	 * @param $tipo Tipo del campoq ue se envia (todos los tipos de postges y otros definidos tb)
	 * @param $blank true o false si premite nulo o no)
	 * @param $tamano Tamaoo del campo definido si es nulo se aplica el amximo para el tipo de campo postgres sino hay moximo es ilimitado
	 */
	function setParametro($nombre,$valor,$tipo,$blank=true,$tamano='',$opciones=null,$tipo_archivo=null){
		//obtenemos el tipo de la base de datos
		//throw new exception('Desde donde llama pendejos');
		
		$tipo_base=$this->validacion->getTipo($tipo);

		//anadimos el nombre y el tipo a los arreglos correspondientes
		if($this->esMatriz || (!$this->esMatriz && (isset($this->arreglo_consultas[$valor])|| isset($this->arreglo[$valor])))){
			//rac 23092011 no define el tipo cuando es bytea en el array de definiciones
			if($tipo!='bytea'){
				array_push($this->variables,$nombre);
				array_push($this->tipos,$tipo_base);
			}else{
				
				$this->variablesFiles="'$nombre'";
				
			}
		}



		if($this->esMatriz){
				
			$valor2=array();
			$cont=0;
			foreach ($this->arreglo as $row){
				
				
				//rac 27/10/11 se escapa los valores entrantes para permitir almacenar comillas simples	
			    $row[$valor]=pg_escape_string(pg_escape_string($row[$valor]));
				$this->validacion->validar($nombre,$row[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
				$this->valores[$cont][$nombre]=$row[$valor];
				$cont++;
			}
				
		}
		else{
			
			if($nombre=='filtro'||$nombre=='ordenacion'||$nombre=='dir_ordenacion'||$nombre=='puntero'||$nombre=='cantidad')
			{	if(isset($this->arreglo_consultas[$valor])){
					$this->validacion->validar($nombre,$this->arreglo_consultas[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
					array_push($this->valores,$this->arreglo_consultas[$valor]);
				}
			}
			else{
				if(isset($this->arreglo[$valor])){
					

					//rac 22092011  verifica si es del tipo bytea 
					if($tipo=='bytea'){
						
						
						$this->validacion->validar($nombre,$this->arregloFiles[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
						//echo "MODBase:".$valor;
						//var_dump($this->arregloFiles);exit;
						
						$this->uploadFile=true;
						
						$data =  pg_escape_bytea(base64_encode(file_get_contents($this->arregloFiles[$valor]['tmp_name'])));

						$this->valoresFiles="'".$data."'";
					}
					else{
						
					        
					   $this->arreglo[$valor]=pg_escape_string(pg_escape_string($this->arreglo[$valor]));
                            
                       $this->validacion->validar($nombre,$this->arreglo[$valor],$tipo,$blank,$tamano,$opciones,$tipo_archivo);
                       
                       if($tipo=='integer[]'||$tipo=='varchar[]'){
                           array_push($this->valores,'{'.$this->arreglo[$valor].'}');
                       } else {
                            array_push($this->valores,$this->arreglo[$valor]);    
                       }
                            
					}
				}elseif(isset($this->arregloFiles[$valor])){
					
					var_dump('PRUEBA............');
					
				}
				
				
			}
				
		}

	}
	
	/**
     * Nombre funcion:  addParametro
     * Proposito:       Anade una parametro manual (que puede ser insertado directamente en el modelo)
                        que se coloca en el arreglo de 
     *                  parametros a ser enviados a un procedimeinto
     * author:          RAC                 
     * Fecha creacion:  12/05/2014
     * @param $nombre El nombre del campo que se envia
     * @param $valor  el valor del parametros
     * @param $tipo Tipo del campoq ue se envia (todos los tipos de postges y otros definidos tb)
     * @param $blank true o false si premite nulo o no)
     * @param $tamano Tamaoo del campo definido si es nulo se aplica el amximo para el tipo de campo postgres sino hay moximo es ilimitado
     */
    function addParametro($nombre,$valor,$tipo,$blank=true,$tamano='',$opciones=null,$tipo_archivo=null){
        //obtenemos el tipo de la base de datos
        
        $tipo_base=$this->validacion->getTipo($tipo);

        
        array_push($this->variables,$nombre);
        array_push($this->tipos,$tipo);
         

        if($this->esMatriz){
            $valor2=array();
            $cont=0;
            foreach ($this->arreglo as $row){
                //rac 27/10/11 se escapa los valores entrantes para permitir almacenar comillas simples 
                $row[$valor]=pg_escape_string(pg_escape_string($valor));
                $this->validacion->validar($nombre,$valor,$tipo,$blank,$tamano,$opciones,$tipo_archivo);
                $this->valores[$cont][$nombre]=$valor;
                $cont++;
            }
                
        }
        else{
            
           if(isset($valor)){
               $this->arreglo[$valor]=pg_escape_string(pg_escape_string($valor));
               $this->validacion->validar($nombre,$valor,$tipo,$blank,$tamano,$opciones,$tipo_archivo);
               array_push($this->valores,$valor);     
                        
           }
                
        }

    }
	/**
	 * Nombre funcion:	setFile
	 * Autor:   JJR (KPLIAN)
	 * Proposito:		Anade un archivo a la carpeta de uploaded files previa validacion
	 * Fecha creacion:	08/05/2013
	 * @param $nombre El nombre del campo que viene como parametro
	 * @param $variable_id El nombre del campo que viene como id del archivo a subir
	 * @param $blank  Si el parametro puede llegar vacio o no
	 * @param $tamano Tamano maximo del archivo
	 * @param $tipo_archivo array conteniendo los tipos de archivos permitidos
	 */
	function setFile($nombre, $variable_id, $blank = true, $tamano = '', $tipo_archivo = null, $folder = '',$subfijo=''){
		//obtenemos el tipo de la base de datos

		$this->validacion->validar($nombre, $this->arregloFiles[$nombre], 'bytea', $blank, $tamano, null, $tipo_archivo);
        
		$upload_folder =  './../../../uploaded_files/' . $this->objParam->getSistema() . '/' .
								 $this->objParam->getClase() . '/' ;
		if ($folder != '') {
			$upload_folder .= $folder . '/';
		}

		//nombre del archivo enviado por el cliente
		$filename = $this->arregloFiles[$nombre]['name'];
		//extension del archivo
		$fileexte = substr($filename, strrpos($filename, '.')+1);
		//nombre con el que se guarda en el servidor
		$file_server_name = md5($this->arreglo[$variable_id].$_SESSION["_SEMILLA"]).$subfijo.".$fileexte";
		
		if (!file_exists($upload_folder)) {
			//echo $upload_folder;
			//exit;
			if (!mkdir($upload_folder,0744,true)) {
				throw new Exception("No se puede crear el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $filename);
			}	
		} else {
			if (!is_writable($upload_folder)) {
				throw new Exception("No tiene permisos o no existe el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $filename);
			}
		
		}
			
		// Passed verification
	    if (move_uploaded_file($this->arregloFiles[$nombre]['tmp_name'], "$upload_folder$file_server_name")) {
	        // Success
	        chmod("$upload_folder/$file_server_name", 0644);
	        
	        return "$upload_folder/$file_server_name";
	    } else {
	    	throw new Exception("No se puede subir el archivo " . $filename);
	    }				

	}

 /**
	 * Nombre funcion:	setFile
	 * Autor:   RAC (KPLIAN)
	 * Proposito:		Copia un archivo existente a la ruta definida
	 * Fecha creacion:	04/12/2014
	 * @param $nombre El nombre del campo que viene como parametro
	 * @param $variable_id El nombre del campo que viene como id del archivo a subir
	 * @param $blank  Si el parametro puede llegar vacio o no
	 * @param $tamano Tamano maximo del archivo
	 * @param $tipo_archivo array conteniendo los tipos de archivos permitidos
	 */
	function copyFile($originen, $destino,  $folder = '', $deshacer = false){
		//obtenemos el tipo de la base de datos
		$temp_array = explode('/', $destino);
		unset($temp_array[count($temp_array) - 1]);
		
		$upload_folder = implode ('/' , $temp_array);
		
		
		
		if (!file_exists($upload_folder)) {
			
			if (!mkdir($upload_folder,0744,true)) {
				throw new Exception("No se puede crear el directorio $upload_folder para escribir el archivo " . $destino);
				
			}	
		} else {
			if (!is_writable($upload_folder)) {
				
				throw new Exception("No tiene permisos o no existe el directorio $upload_folder para escribir el archivo " . $destino);
								
			}
		
		}

		
		IF(!$deshacer){
			// Passed verification
		    if ( rename($originen, $destino)) {
		        	
				 // Success
		        chmod($destino, 0644);
		        
		        return $destino;
		    } else {
		    	throw new Exception("No se puede subir el archivo " . $destino);
		    }		
		}
		else{
			// Passed verification
		    if ( rename( $destino, $originen)) {
		        	
				 // Success
		        chmod($originen, 0644);
		        
		        return $destino;
		    } else {
		    	throw new Exception("No se puede reverti la copia  " . $destino);
		    }	
		}	
	

	}

	 /**
     * Nombre funcion:  getFileNAme
     * Autor RAC (KPLIAN)
     * Proposito:       recuepra el nombre del archivo por subir
     * Fecha creacion:  12/03/2014
     * @param $nombre El nombre del campo que viene como parametro
     * @param $variable_id El nombre del campo que viene como id del archivo a subir
     * @param $folder subfolder donde se guardara el archivo
     */
    
    function getFileName($nombre, $variable_id, $folder = ''){
        
        //obtenemos el tipo de la base de datos
        $upload_folder =  './../../../uploaded_files/' . $this->objParam->getSistema() . '/' .
                                 $this->objParam->getClase() . '/' ;
        if ($folder != '') {
            $upload_folder .= $folder . '/';
        }
        //nombre del archivo enviado por el cliente
        $filename = $this->arregloFiles[$nombre]['name'];
        //extension del archivo
        $fileexte = substr($filename, strrpos($filename, '.')+1);
        //nombre con el que se guarda en el servidor
        
        $file_server_name = md5($this->arreglo[$variable_id] . $_SESSION["_SEMILLA"]) . ".$fileexte";
        
        return "$upload_folder$file_server_name";
            
     }
	
	/**
     * Nombre funcion:  getFileNAme
     * Autor RAC (KPLIAN)
     * Proposito:       recuepra el nombre del archivo, folder, url  por subir
     * Fecha creacion:  12/122014
     * @param $nombre El nombre del campo que viene como parametro
     * @param $variable_id El nombre del campo que viene como id del archivo a subir
     * @param $folder subfolder donde se guardara el archivo
     */
    
    function getFileName2($nombre, $variable_id, $folder = '', $subfijo = ''){
        
        //obtenemos el tipo de la base de datos
        $upload_folder =  './../../../uploaded_files/' . $this->objParam->getSistema() . '/' .
                                 $this->objParam->getClase() . '/' ;
        if ($folder != '') {
            $upload_folder .= $folder . '/'; 
        }
        //nombre del archivo enviado por el cliente
        $filename = $this->arregloFiles[$nombre]['name'];
        //extension del archivo
        $fileexte = substr($filename, strrpos($filename, '.')+1);
        //nombre con el que se guarda en el servidor
        
        $file_name = md5($this->arreglo[$variable_id] . $_SESSION["_SEMILLA"]);
        $file_server_name = $file_name.$subfijo. ".$fileexte";
        
		$resp =  Array();
		$resp[0] = $file_name;
		$resp[1] = $upload_folder;
		$resp[2] = "$upload_folder$file_server_name";
        return $resp;
            
     }

	function generaRespuestaParametros(){
		$cadena='';
		$this->respuesta=new Mensaje();
		$res_validacion=$this->validacion->getRes();
		foreach ($res_validacion as $data){
			$cadena.="$data|";
		}
		$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$cadena,'Error de validacion de datos por parte de Validacion.php','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,'');
	}

	/**
	 * Nombre funcion:	setParametrosConsulta
	 * Proposito:		inserta parametors de consulta y guarda los datos de cunsulta en las variables de clase
	 * para la seleccion
	 * Fecha creacion:	21/06/2009
	 *
	 * @param cadena $criterio_filtro
	 * @param cadena $ordenacion
	 * @param cadena $dir_ordenacion
	 * @param entero $puntero
	 * @param entero $cantidad
	 */
	function setParametrosConsulta(){
			
		$this->setParametro('filtro','filtro','filtro_sql');
		$this->setParametro('ordenacion','ordenacion','varchar');
		$this->setParametro('dir_ordenacion','dir_ordenacion','varchar');
		$this->setParametro('puntero','puntero','integer');
		$this->setParametro('cantidad','cantidad','integer');

	}
	
	
	
	function setUsuarioAi(){
	         
	     if (isset($_SESSION["ss_id_usuario_ai"]))   {
	         $id_usuario_ai = $_SESSION["ss_id_usuario_ai"];
	         $nombre_usuario = $_SESSION["_NOM_USUARIO_AI"];
	     }else{
	         $id_usuario_ai = 'NULL';
	         $nombre_usuario = 'NULL';
	     }
	         
	    $this->addParametro('_id_usuario_ai',$id_usuario_ai,'int4');
	    $this->addParametro('_nombre_usuario_ai',$nombre_usuario,'varchar');
	    
        

    }
	
	
	// valida el tamaño de imagen
	function validacionImagen($ruta_imagen,$extension,$ancho_validado){
		$ruta_de_la_imagen = $this->arreglo[$ruta_imagen];
		$extension_de_la_imagen = $this->arreglo[$extension];
		
	 	//vemos que tipo de extension es para ver que funcion usamos para crear la imagen
		switch ($extension_de_la_imagen) {
			case 'jpg' :
				$img_origen = imagecreatefromjpeg($ruta_de_la_imagen);
				break;
			case 'png' :
				$img_origen = imageCreateFromPng($ruta_de_la_imagen);
				break;

		}
		
		$ancho_origen = imagesx($img_origen);
		if($ancho_origen == $ancho_validado){
			return true;
		}else{
			return false;
		}
		
		
	}
	
	/**
	 * Nombre funcion:	convertirTamanoImagen
	 * Proposito:		convierte el tamaño de la imagen subida en proporcion del ancho
	 * para la seleccion
	 * Fecha creacion:	18/09/2015
	 *
	 * @param cadena $imagen
	 * @param cadena $ruta
	 * @param entero $ancho_minimo
	 */
	 
	 function convertirTamanoImagen($ruta_imagen,$ancho_limite,$extension,$ruta_destino,$nombre_img){
	 	
		
		
		if (!file_exists($ruta_destino)) {
			//echo $upload_folder;
			//exit;
			if (!mkdir($ruta_destino,0744,true)) {
				throw new Exception("No se puede crear el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $nombre_img);
			}	
		} else {
			if (!is_writable($ruta_destino)) {
				throw new Exception("No tiene permisos o no existe el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $nombre_img);
			}
		
		}
		
		
		$ruta_de_la_imagen = $this->arreglo[$ruta_imagen];
		$extension_de_la_imagen = $this->arreglo[$extension];
		
		
		
	 	//vemos que tipo de extension es para ver que funcion usamos para crear la imagen
		switch ($extension_de_la_imagen) {
			case 'jpg' :
				$img_origen = imagecreatefromjpeg($ruta_de_la_imagen);
				break;
			case 'png' :
				$img_origen = imageCreateFromPng($ruta_de_la_imagen);
				break;

		}
		
		$ancho_origen = imagesx($img_origen);
		$alto_origen = imagesy($img_origen);
		
		

		if($ancho_origen > $alto_origen){
			$ancho_origen = $ancho_limite;
			$alto_origen = $ancho_limite*imagesy($img_origen)/imagesx($img_origen);
		}else{
			$alto_origen = $ancho_limite;
			$ancho_origen = $ancho_limite*imagesx($img_origen)/imagesy($img_origen);
		}

		$img_destino = imagecreatetruecolor($ancho_origen,$alto_origen);



         switch ($extension_de_la_imagen) {
             case 'jpg' :
                 imagecopyresized($img_destino,$img_origen,0,0,0,0,$ancho_origen,$alto_origen,imagesx($img_origen),imagesy($img_origen));

                 imagejpeg($img_destino,$ruta_destino.$nombre_img.'.'.$extension_de_la_imagen);

                 break;
             case 'png' :

                 imagealphablending($img_destino, FALSE);
                 imagesavealpha($img_destino, TRUE);
                 imagecopyresized($img_destino,$img_origen,0,0,0,0,$ancho_origen,$alto_origen,imagesx($img_origen),imagesy($img_origen));
                 imagepng($img_destino,$ruta_destino.$nombre_img.'.'.$extension_de_la_imagen);

                 /*imagealphablending($img_destino, false);
                 imagesavealpha($img_destino,true);
                 $transparent = imagecolorallocatealpha($img_destino, 255, 255, 255, 127);
                 imagefilledrectangle($img_destino, 0, 0, $nWidth, $nHeight, $transparent);
                 imagepng($img_destino,$ruta_destino.$nombre_img.'.'.$extension_de_la_imagen);*/


                 break;

         }


	 }


	function setFileModificacion($sistema,$clase,$nombre, $variable_id, $blank = true, $tamano = '', $tipo_archivo = null, $folder = ''){
		//obtenemos el tipo de la base de datos
		
		$this->validacion->validar($nombre, $this->arregloFiles[$nombre], 'bytea', $blank, $tamano, null, $tipo_archivo);
		$upload_folder =  './../../../uploaded_files/' . $sistema . '/' .
								 $clase . '/' ;
		if ($folder != '') {
			$upload_folder .= $folder . '/';
		}
		//nombre del archivo enviado por el cliente
		$filename = $this->arregloFiles[$nombre]['name'];
		//extension del archivo
		$fileexte = substr($filename, strrpos($filename, '.')+1);
		//nombre con el que se guarda en el servidor
		$file_server_name = md5($this->arreglo[$variable_id] . $_SESSION["_SEMILLA"]) . ".$fileexte";
		
		if (!file_exists($upload_folder)) {
			//echo $upload_folder;
			//exit;
			if (!mkdir($upload_folder,0744,true)) {
				throw new Exception("No se puede crear el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $filename);
			}	
		} else {
			if (!is_writable($upload_folder)) {
				throw new Exception("No tiene permisos o no existe el directorio uploaded_files/" . $this->objParam->getSistema() . "/" . 
									$this->objParam->getClase() . " para escribir el archivo " . $filename);
			}
		
		}
			
		// Passed verification
	    if (move_uploaded_file($this->arregloFiles[$nombre]['tmp_name'], "$upload_folder$file_server_name")) {
	        // Success
	        chmod("$upload_folder/$file_server_name", 0644);
	        
	        return "$upload_folder/$file_server_name";
	    } else {
	    	throw new Exception("No se puede subir el archivo " . $filename);
	    }				

	}
	
	
	
	

}
?>