<?php
/*
Autor: RCM
Fecha: 01/08/2014
Descripcion: Driver para interactuar con base de datos microsoft sql server (mssql). Ejecucion de consultas SEL IME
*/
class mssqlDriver extends absDriver implements iDriver {
	
	public $strMotorBD = 'mssql'; 
	
	public function armarConsultaSel(){
		$this->consulta='exec ';

		//Procedimiento almacenado a ejecutar
		if($this->null($this->procedimiento)){
			$this->consulta.='NULL';
		} else {
			$this->consulta.=$this->procedimiento;
		}
		
		//Transacción solicitada
		if($this->null($this->transaccion)){
			$this->consulta.='NULL';
		} else {
			$this->consulta.="'".$this->transaccion."'";
		}

	}
	
	public function armarConsultaCount(){
		$this->consulta='exec ';
		
		if($this->null($this->procedimiento)){
			$this->consulta.='NULL';
		} else {
			$this->consulta.=$this->procedimiento;
		}

		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';
		} else {
			$this->consulta.="'".$this->transaccion."'";
		}
	}
	
	public function armarconsultaIme(){
		$this->consulta='exec ';

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		} else{
			$this->consulta.=$this->procedimiento.' ';
		}
		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';
		} else{
			$this->consulta.="'".$this->transaccion."',";
		}
		
		//var_dump($this->getArregloValores());exit;
		$tmp = $this->getArregloValores();
		//var_dump($tmp);exit;
		//var_dump($this->valores);exit;
		ob_start();
        $fb=FirePHP::getInstance(true);
        $fb->log($this->consulta,"cadena ime antes");
		$this->consulta.=$tmp;


		//$this->consulta.=",'".str_replace("'","''",$this->consulta).")',NULL,NULL)";
		
		ob_start();
        $fb=FirePHP::getInstance(true);
        $fb->log($this->consulta,"cadena ime");
	}
	
	public function armarConsultaOtro(){
		
	}

	public function ejecutarConsultaSel($res=null){
		try {
			$array=Array();
			if($res!=null){
				$this->respuesta=$res;
			} else{
				$this->respuesta=new Mensaje();
			}

			//Abre la conexión a la base de datos
			$this->objCnx = new conexion($this->strMotorBD);
			
			//Verifica el tipo de conexión a realizar
			if($this->tipo_conexion=='persistente'){
				//$this->objLinkCnx=$this->objCnx->conectarp();
				$this->objCnx->conectarp();
			} elseif($this->tipo_conexion=='seguridad'){
				//$this->objLinkCnx=$this->objCnx->conectarSegu();
				$this->objCnx->conectarSegu();
			} else{
				//$this->objLinkCnx=$this->objCnx->conectarnp();
				$this->objCnx->conectarnp();
			}

			//Verificación de conexión exitosa
			if($this->objCnx->getConexion()==0){
				//Error al conectar
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			} else {
				//Conexión exitosa
				$res=mssql_query($this->consulta);//,$this->objCnx->getConexion());;
				if($res){	

					while ($row = mssql_fetch_array($res)){
						if($this->uploadFile){
							//RAC 19/05/2011
							if($this->tipo_resp=='archivo'){
								//crea un archivo fisico en el servidor
								if($row[$this->nombre_file]!=''&&$row[$this->extencion]!=''){
									$handle=fopen($this->ruta_archivo.$row[$this->nombre_file].'.'.$row[$this->extencion], "w+"); //abrir un enlace a la imagen de acuerdo al oid
									$row[$this->nombre_col]=base64_decode(pg_unescape_bytea($row[$this->nombre_col]));//decodificar la imagen
									fwrite($handle, $row[$this->nombre_col]);
									fclose($handle);
									$row[$this->nombre_col]=$row[$this->nombre_file].'.'.$row[$this->extencion];
								}
							} elseif($this->tipo_resp=='sesion'){
								//guardamos los datos de archivos en variable de sesion
								//para no crear un archivo fisico
								$_SESSION[$this->nom_sesion][$row[$this->nombre_file].'.'.$row[$this->extencion]]= base64_decode(pg_unescape_bytea($row[$this->nombre_col]));//decodificar la imagen	                     	
								$row[$this->nombre_col]=$row[$this->nombre_file].'.'.$row[$this->extencion];
							} else {
								throw new Exception("No esta definido el tipo de respuesta BYTEA son admitidos (archivo,sesion) no se reconcoe -> $this->tipo_resp");
							}
						}
						array_push ($array, $row);
					}
					//Libera la memoria
					mssql_free_result($res);
					//EXITO en la transaccion
					$this->respuesta->setMensaje('EXITO',$this->nombre_archivo,'Consulta ejecutada con exito','Consulta ejecutada con exito','base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
					if($this->addConsulta){					
						$this->respuesta->setDatos(array_merge($this->respuesta->getDatos(),$array));
					} else {					
						$this->respuesta->setDatos($array);
					}
					//Si hay count
					$this->transaccion_count=str_replace('_SEL','_CONT',$this->transaccion);
					$this->armarConsultaCount();
					unset($array);
					$array=Array();
					if($this->count){
						//Hago la consulta de count
						if($res = mssql_query($this->consulta)){//,$this->objCnx->getConexion()))
							while ($row = mssql_fetch_array($res,NULL)){
								array_push ($array, $row);
							}
							//Libera la memoria
							mssql_free_result($res);

							//EXITO en la transaccion
							$this->respuesta->setTotal($array[0]['total']);

							//Armo la consulta original
							$this->armarConsultaSel();
						} else {
							$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', mssql_last_error($this->objCnx->getConexion())));
							//Existe error en la base de datos tomamamos el mensaje y el mensaje tecnico
							$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la consulta',$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion_count,$this->tipo_procedimiento,$this->consulta);
							//armo la consulta original
							$this->armarConsultaSel();

						}//fin count

					}
				} else {
				echo 
					$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', mssql_last_error($this->objCnx->getConexion())));
					//Existe error en la base de datos tomamamos el mensaje y elmensaje tecnico
					$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
				}
			}
			//Desconexión de la base de datos
			$this->objCnx->desconectarnp();
		} catch (Exception $e) {
			echo 'Excepción->driver::ejecutarConsultaSel: ',  $e->getMessage(), "\n";
		}
	}
	
	public function ejecutarConsultaIme(){
		try {
			
			$array=Array();
			
			//Instancia la clase Mensaje si el objeto no es nulo
			if($res!=null){
				$this->respuesta=$res;
			} else{
				$this->respuesta=new Mensaje();
			}
			
			//Abre la conexión a la base de datos
			$this->objCnx = new conexion($this->strMotorBD);
			
			if($this->tipo_conexion=='persistente'){
				$this->objCnx->conectarp();
			} elseif($this->tipo_conexion=='seguridad'){
				$this->objCnx->conectarSegu();
			} else{
				$this->objCnx->conectarnp();
			}
	
			//Verificación de conexión exitosa
			if($this->objCnx->getConexion()==0){
				//Error al conectar
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			} else{
				//Conexión exitosa
				//echo $this->consulta;exit;
				if($res = mssql_query($this->consulta)){
	
					while ($row = mssql_fetch_array($res))
					{
						//var_dump($row);exit;
						array_push ($array, $row);
					}
					
					//Libera la memoria
					mssql_free_result($res);
					
					//Verifica si se produjo algon error logico en la funcion
					$resp_procedimiento = $this->divRespuesta($array[0]['f_intermediario_ime']);
					  if($this->uploadFile){
						$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
					  }
					  else{
		      			$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
					  }  
			
	                 $this->respuesta->setDatos($resp_procedimiento['datos']);
	
	
				}
				else
				{
					
					$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', mssql_last_error($link)));
					  if($this->uploadFile){
						
						$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
					  }
					  else{
		      			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
					  }  
					
	
				}
			}
	
	   		//Desconexión de la base de datos
			$this->objCnx->desconectarnp();
			
		} catch (Exception $e) {
			echo 'Excepción->driver::ejecutarConsultaIme: ',  $e->getMessage(), "\n";
		}
		
	}
	
	public function ejecutarConsultaOtro(){
		
	}
	
	public function divRespuesta($cadena){
		
	}
	
	//Función sobreescrita de absDriver
	function getArregloValores() {
		$arreglo='';
		if($this->esMatriz){
			//var_dump($this->valores);exit;
			$aux1=$this->valores[0];
			//var_dump($aux1);
			$cont=0;
			for($i=0;$i<count($this->valores);$i++){	
				$arreglo.='';
				$aux2=$this->valores[$i];
				//var_dump($aux2);exit;
				/*for(){
					
				}*/
				//echo $aux2["coddep"];exit;
				if($cont==0){
					foreach ($aux2 as $ind=>$valor){
						
						//echo 'ssss:'.$ind;
						if($ind=='_fila'){
							$cont++;
						} else{
							$arreglo.="'$valor',";
						}
					}
					$cont++;
				}
				//echo 'aaaaa: '.$cont;exit;
			}
		} else {
			for($i=5;$i<count($this->valores);$i++){
				$arreglo.="'".$this->valores[$i]."',";
			}
		}

		$arreglo = substr ($arreglo, 0, -1);
		//var_dump($this->valores);exit;
		return $arreglo;
	}
	
}

?>