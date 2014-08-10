<?php
/*
Autor: RCM
Fecha: 02/06/2014
Descripcion: Driver para interactuar con base de datos postgresql. Ejecucion de consultas SEL IME
*/
class pgDriver extends absDriver implements iDriver {
	
	/**
	 * Nombre funcion:	armarConsultaSel
	 * Proposito:		arma la consulta correspondiente al tipo seleccion
	 * Fecha creacion:	12/04/2009
	 */
	function armarConsultaSel(){
		$this->consulta='select * from pxp.f_intermediario_sel(';
		//Agrega parametros fijos a la consulta intermediario sel
		/*ob_start();
		$fb=FirePHP::getInstance(true);
		$fb->log('usuario:'.$this->id_usuario,"armarConsultaSel");*/
				
		
		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}
		
		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
        else{
            $this->consulta.=$this->id_usuario_ai.',';
        }
        
        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
            $this->consulta.="'".$this->nom_usuario_ai."',";
        }
		
		
		
		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';

		}
		else{

			$this->consulta.="'".$this->transaccion."',";
		}

		if($this->null($this->id_categoria)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.$this->id_categoria.',';
		}
		
		 if(!isset($_SESSION["_IP_ADMIN"])){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
			}
			$this->consulta.='],';
		}
		

		if(count($this->variables)==0){
			$this->consulta.='NULL,NULL,NULL)';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';
			$this->consulta=$this->consulta.$this->getArregloValores().",";
			
			
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}
			
			$this->consulta.=']';

		}


        $tipo_retorno=' as (';

		for($i=0;$i<count($this->captura);$i++){
			if($i==0){
				$tipo_retorno.=$this->captura[$i]." ".$this->captura_tipo[$i];
			}
			else{
				$tipo_retorno.=",".$this->captura[$i]." ".$this->captura_tipo[$i];
			}
		}

		$tipo_retorno.=')';

       //rac 19032012 aumenta tipo de retorno 
       if($this->tipo_retorno=='varchar')
	   {
        $this->consulta.=',\'varchar\',NULL)';
		$this->consulta.=$tipo_retorno;
	   }
	   else{
	   	
		 $this->consulta.=",'record','$tipo_retorno')";
		 $this->consulta.=$tipo_retorno;
		
	   }

	}
	
	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo conteo de datos
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function armarConsultaCount(){
		$this->consulta='select * from pxp.f_intermediario_sel(';

		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}
		
		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
        else{
            $this->consulta.=$this->id_usuario_ai.',';
        }
        
        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
            $this->consulta.="'".$this->nom_usuario_ai."',";
        }
		
		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){
			$this->consulta.='NULL,';

		}
		else{

			$this->consulta.="'".$this->transaccion_count."',";
		}

		if($this->null($this->id_categoria)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.$this->id_categoria.',';
		}
		
		 if(!isset($_SESSION["_IP_ADMIN"])){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
			}
			$this->consulta.='],';
		}
		

		if(count($this->variables)==0){
			$this->consulta.='NULL,NULL,NULL,';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';

			$this->consulta=$this->consulta.$this->getArregloValores().",";

			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}
			$this->consulta.=']';

		}
		
		
		 //rac 19032012 aumenta tipo de retorno 
       if($this->tipo_retorno=='varchar')
	   {
        $this->consulta.=',\'varchar\',NULL)';
	   }
	   else{
	   	$this->consulta.=",'record','as (total bigint)')";
		}

		$this->consulta.=' as (total bigint)';

	}
	
	/**
	 * Nombre funcion:	armarConsulta
	 * Proposito:		arma la consulta correspondiente al tipo insertar,modificar o eliminar
	 * Fecha creacion:	12/04/2009
	 * 
	 */
	function armarconsultaIme(){
		$this->consulta='select * from pxp.f_intermediario_ime(';

		if($this->null($this->id_usuario)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_usuario.',';
		}
		
		if($this->null($this->id_usuario_ai)){
            $this->consulta.='NULL,';
        }
        else{
            $this->consulta.=$this->id_usuario_ai.',';
        }
        
        if($this->null($this->nom_usuario_ai)){
            $this->consulta.='NULL::varchar,';
        }
        else{
             $this->consulta.="'".$this->nom_usuario_ai."',";
        }
		
		$this->consulta.="'".session_id()."',";
		$this->consulta.=getmypid().',';
		if($this->null($this->ip)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->ip."',";
		}

		if($this->null($this->mac)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->mac."',";
		}

		if($this->null($this->procedimiento)){
			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.="'".$this->procedimiento."',";
		}

		if($this->null($this->transaccion)){

			$this->consulta.='NULL,';
		}
		else{

			$this->consulta.="'".$this->transaccion."',";
		}

		if($this->null($this->id_categoria)){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.=$this->id_categoria.',';
		}
		
		if(!$this->esMatriz){

			$this->consulta.="'no',";
		}
		else{
			$this->consulta.="'si',";
		}
		
	    if(!isset($_SESSION["_IP_ADMIN"])){

			$this->consulta.='NULL,';
		}
		else{
			$this->consulta.='array[';
			for($i=0;$i<count($_SESSION["_IP_ADMIN"]);$i++){
				if($i==0){
					$this->consulta.="'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
				else{
					$this->consulta.=",'".$_SESSION["_IP_ADMIN"][$i]."'";
				}
			}
			$this->consulta.='],';
		}
		
		//echo 'fffff:'.$this->consulta;exit;

		if(count($this->valores)==0){
			$this->consulta.='NULL,NULL,NULL';
		}
		else
		{
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->variables[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->variables[$i]."'";
				}
			}
			$this->consulta.='],';
			$this->consulta=$this->consulta.$this->getArregloValores().",";
			
			$this->consulta.='array[';
			for($i=0;$i<count($this->variables);$i++){
				if($i==0){
					$this->consulta.="'".$this->tipos[$i]."'";
				}
				else{
					$this->consulta.=",'".$this->tipos[$i]."'";
				}
			}
			$this->consulta.=']';

		}
		
		//manda la consulta como un parametro adicional 
		//cunado son archivo upload file esto duplicaria la cantida archivos
		//rac 23/09/2011
		if ($this->uploadFile){
			//armar array de valores
			
			//rac 27/09/2011  consulta para no repetir
			$this->parConsulta=$this->consulta.",'".str_replace("'","''",$this->consulta).",NULL,NULL)'";
			$this->consulta.=",'".str_replace("'","''",$this->consulta).",NULL,'$this->valoresFiles')',$this->valoresFiles,$this->variablesFiles)";
			
		}
		else{
		  $this->consulta.=",'".str_replace("'","''",$this->consulta).")',NULL,NULL)";
		}

	}
	
	function armarConsultaOtro(){

	}
	
	/**
	 * Nombre funcion:	ejecutarConsultaSel
	 * Autor:    Jaime Rivera Rojas
	 * Proposito:		ejecuta la consulta detipo seleccion y conteo de datos
	 * Fecha creacion:	12/04/2009
	 * Autor Modificacion: Jaime Rivera
	 * Fecha mod 02/09/2011
	 * Desc mod:  Modificaicon para que recupera datos boleanos en formato javaScript
	 * 
	 */
	function ejecutarConsultaSel($res=null){
		try {
			$array=Array();
			if($res!=null){
				$this->respuesta=$res;
			} else{
				$this->respuesta=new Mensaje();
			}
			//Abre la conexión a la base de datos
			$this->objCnx = new conexion();
			
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
			if($this->getTransaccion()=='SEG_SESION_INS'){
				//echo 'fuck';exit;
				/*ob_start();
				$fb=FirePHP::getInstance(true);
				$fb->log('OR_OFI_SEL',"BBBBBBB");*/	
			}
			//Verificación de conexión exitosa
			if($this->objCnx->getConexion()==0){
				//Error al conectar
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			} else {
				//Conexión exitosa
				$res=pg_query($this->consulta);
				if($res){	
					//RAC 26/09/2011
					if($this->tipo_resp=='sesion'){
						$_SESSION[$this->nom_sesion]=array();
					}
					
					while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
						//RAC 02/09/2011 modificacion
						if($this->sw_boolean){
							for($i=0;$i<count($this->nombres_booleanos);$i++){
								if(isset($row[$this->nombres_booleanos[$i]])){
									if($row[$this->nombres_booleanos[$i]]=='f'){
										$row[$this->nombres_booleanos[$i]]="false";
									} else {
										$row[$this->nombres_booleanos[$i]]="true";
									}
								}
							}
						}
						
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
					pg_free_result($res);
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
						if($res = pg_query($this->objCnx->getConexion(),$this->consulta)){
							while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
								array_push ($array, $row);
							}
							//Libera la memoria
							pg_free_result($res);

							//EXITO en la transaccion
							$this->respuesta->setTotal($array[0]['total']);

							//Armo la consulta original
							$this->armarConsultaSel();
						} else {
							$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($this->objCnx->getConexion())));
							//Existe error en la base de datos tomamamos el mensaje y el mensaje tecnico
							$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'Error al ejecutar la consulta',$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion_count,$this->tipo_procedimiento,$this->consulta);
							//armo la consulta original
							$this->armarConsultaSel();

						}//fin count

					}
				} else {
				echo 
					$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($this->objCnx->getConexion())));
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
	
	/**
	 * Nombre funcion:	ejecutarConsultaIme
	 * Proposito:		ejecuta la consulta de tipo insercion o modificacion o eliminacion
	 * Fecha creacion:	12/04/2009
	 */
	function ejecutarConsultaIme(){
		try{
			//echo '6';exit;
			$array=Array();
			$this->respuesta=new Mensaje();
			//Abre la conexión a la base de datos
			$this->objCnx=new conexion();
			
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
				if($this->transaccion == 'SEG_SESION_INS'){
					//echo 'HHH:'.$this->transaccion.'<br>';
					//var_dump($this->objCnx->getConexion());exit;
				}
			}
			/*echo '7';
			var_dump($this->objLinkCnx);
			exit;*/
			//if($this->objLinkCnx==0){
			if($this->objCnx->getConexion()==0){
				$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,'No se puede conectar a la base de datos','Revise la cadena de conexion a la BD','modelo',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
			} else {
				//var_dump($this->objCnx->getConexion());
				if($res = pg_query($this->objCnx->getConexion(),$this->consulta)){
					while ($row = pg_fetch_array($res,NULL,PGSQL_ASSOC)){
						array_push ($array, $row);
					}
					//var_dump($array);exit;
					//Libera la memoria
					pg_free_result($res);
					//echo '8';exit;
					//Verifica si se produjo algon error logico en la funcion
					$resp_procedimiento = $this->divRespuesta($array[0]['f_intermediario_ime']);
					if($this->uploadFile){
						$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
					} else{
						$this->respuesta->setMensaje($resp_procedimiento['tipo_respuesta'],$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
					}  
	                 $this->respuesta->setDatos($resp_procedimiento['datos']);
					 /*echo '9';
					 var_dump($this->respuesta);
					 exit;*/
				} else {
					$resp_procedimiento=$this->divRespuesta(str_replace('ERROR:  ','', pg_last_error($this->objCnx->getConexion())));
					if($this->uploadFile){
						$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->parConsulta);
					} else{
		      			$this->respuesta->setMensaje('ERROR',$this->nombre_archivo,$resp_procedimiento['mensaje'],$resp_procedimiento['mensaje_tec'],'base',$this->procedimiento,$this->transaccion,$this->tipo_procedimiento,$this->consulta);
					}  
				}
			}

			/*echo $this->transaccion;
			var_dump($this->respuesta);
			var_dump($this->objLinkCnx);*/
			
			if($this->transaccion == 'SEG_SESION_INS'){
				//echo 'ejecutarConsultaIme';
				//var_dump($this->objLinkCnx);exit;
				//var_dump($this->respuesta);exit;
			}
			
			
			$this->objCnx->desconectarnp();
			//echo '11';exit;
			
			if($this->transaccion == 'SEG_SESION_INS'){
				//echo 'paso por fin';exit;
				//var_dump($this->respuesta);exit;
			}
			
		} catch (Exception $e) {
			echo 'Excepción->driver::ejecutarConsultaIme: ',  $e->getMessage(), "\n";
		}

	}
	
	function ejecutarConsultaOtro() {

	}
	
	function divRespuesta($cadena){
		$res=array();
		//Limpia el json si corresponde
		$aux=strripos ($cadena,'}');
		$cadena=substr($cadena,0,$aux+1);
		//jrr:removiendo saltos de linea y tabas para una buena decodificacion del json
		$cadena = preg_replace(array('/\s{2,}/', '/[\t\n]/'), ' ', $cadena);
		$res=json_decode($cadena,true);
		$res['datos']=$res;
		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);
		
		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);
		
		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);
		
		if(count($res['datos'])>0)
			$aux=array_shift($res['datos']);

		if($res['tipo_respuesta']=='EXITO'){
			$res['mensaje']="La transacción se ha ejecutado con éxito";
			$res['mensaje_tec']="La transacción se ha ejecutado con éxito";
		} else {
			if($res['codigo_error']!='P0001' && $_SESSION["_ESTADO_SISTEMA"] != "desarrollo"){
				$res['mensaje']="Ha ocurrido un incidente. Comunique el registro (".$res['id_log'].")";
			}
			$res['mensaje_tec']=$res['mensaje']."   Procedimientos: ".$res['procedimientos'];
		}
		return $res;
	}
	
	//Propiedades

}
?>