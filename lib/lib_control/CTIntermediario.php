<?php
/***
 Nombre: ACTbase.php
 Proposito: Recibir todos los parametros enviados
 de la capa de la vista, desencriptar lo recibido y direccionar a
 la accion correspondiente solicitada por el usuario
 Autor:	Kplian (RCM)
 Fecha:	30/06/2010
 */
class CTIntermediario{

	/////////////////////////////////
	//    Declaracion de variables
	/////////////////////////////////
	static $prefijo='ACT'; //para direccionamiento
	private $sufijo; //para redireccionamiento
	private $objParametro;
	private $objSesion;
	private $objMensaje;
	private $objPostData;
	private $rutaArchivo;
	private $metodoEjecutar;
	private $aPostData;
	private $aPostFiles;//rac 22/09/2011 para recibir files
	private $rutaInclude;
	private $nombreClase;
	private $objFiltro;
	private $objReporte;



	///////////////////////////////////
	//    Constructores , destructores
	///////////////////////////////////
	function __construct(){
		//echo  server_port;
		//exit;
     	//Obtencion de los datos enviados por la vista
		$this->objPostData=new CTPostData();
		$this->aPostData=$this->objPostData->getData();
		//rac 22/09/2011 
		$this->aPostFiles=$this->objPostData->getFiles();
		
		//var_dump($this->aPostFiles);
		//exit;
		
		$_SESSION["_PETICION"]=serialize($this->aPostData);
		//echo 'POST: '.$this->aPostData['r'];exit;
		
		
		if(isset($this->aPostData['r'])){
			$objReporte=new MostrarReporte($this->aPostData['r']);
		}
		//Verifica la existencia de los parametros de direccionamiento
		$this->verificaParametrosDirec();

		//Obtiene la ruta, archivo y metodo a ejecutar de la _ruta
		$this->obtenerRutaArchivoMetodo();
		
		//verifica DoS
		if($_SESSION['_CRT_DOS']=='SI'){
		  $this->verifidaDoS();
		}

		//Verifica la sesion
		$this->verificarSesion();

		//Inclusion del archivo a ejecutar
		$this->incluirArchivo();

		//Instancia de clase parametros para mandar al modelo
		if(isset($this->aPostData['m'])){
			//si es matriz
			//rac 22/09/2011 adicona parametro para mandar archivos 
			$this->objParametro = new CTParametro($this->aPostData['p'],$this->aPostData['m'],$this->aPostFiles);
		}
		else{
			//rac 22/09/2011 adicona parametro para mandar archivos 
			$this->objParametro = new CTParametro($this->aPostData['p'],null,$this->aPostFiles);
		}

		//$this->objParametro->setParametrosJson($this->aPostData['p']);

	}

	function __destruct(){

	}

	////////////////////////////////
	//			Metodos
	////////////////////////////////

	//Verifica la existencia de los parametros de direccionamiento
	private function verificaParametrosDirec(){
		if(!isset($this->aPostData["x"])){
			throw new Exception(__METHOD__.': Ruta no definida');
		}
		if(!isset($this->aPostData["p"])){
			throw new Exception(__METHOD__.': Parametros basicos no definidos');
		}
	}

	//Obtiene la ruta, archivo y metodo a ejecutar de la _ruta
	private function obtenerRutaArchivoMetodo(){
		$aAux=explode('/',$this->aPostData["x"]);

		//Verifica que al menos tenga dos '/'
		if(count($aAux)<2){
			/*echo '<pre>';
				print_r($this->aPostData["x"]);
				echo '</pre>';
				exit;*/
			throw new Exception(__METHOD__.': Ruta no valida1');
		}

		//Verifica que los dos no sean vacios
		if($aAux[count($aAux)-1]==''){
			throw new Exception(__METHOD__.': Ruta no valida2');
		}
		if($aAux[count($aAux)-2]==''){
			throw new Exception(__METHOD__.': Ruta no valida3');
		}

		//La ultima posicion se refiere al metodo a ejecutar
		$this->metodoEjecutar=$aAux[count($aAux)-1];

		//La penultima se refiere al nombre de la clase
		$this->nombreClase=$aAux[count($aAux)-2];

		//De la posicion cero hasta la antepenultima es la ruta
		for($i=0;$i<count($aAux)-2;$i++){
			$this->rutaArchivo.=$aAux[$i].'/';
		}
	}

	//Incluye el archivo a ejecutar
	private function incluirArchivo(){
		//Forma la cadena del include y el nombre de la clase
		$this->nombreClase=self::$prefijo.$this->nombreClase;
		$this->rutaInclude=$this->rutaArchivo.$this->nombreClase.'.php';
		//echo __FILE__;exit;
		//echo 'dd:'.$this->rutaInclude;exit;
		/*ob_start();
$fb=FirePHP::getInstance(true);
$fb->log($this->nombreClase,"clase");*/

		//Incluye el archivo
		include_once $this->rutaInclude;
	}

	function direccionarAccion(){
		//Instancia la clase dinamica para ejecutar la accion requerida
		eval('$cad = new $this->nombreClase($this->objParametro);');

		//Ejecuta el metodo solicitado
		eval('$cad->'.$this->metodoEjecutar.'();');
	}

	 //Verifica si la conexion es HTTPS
	function isSSL(){

		if($_SERVER['https'] == 1) /* Apache */ {
			return TRUE;
		} elseif ($_SERVER['https'] == 'on') /* IIS */ {
			return TRUE;
		} elseif ($_SERVER['SERVER_PORT'] == 443) /* others */ {
			return TRUE;
		} else {
			return FALSE; /* just using http */
		}

	}
	
	private function verifidaDoS(){
		
		 $i = $_SESSION["_IN_PILA"];
		 $top = $_SESSION["_TAM_MAX"];
		 $sospechoso = 0;
		 //actualizamos valor en la pila
		 $_SESSION["_PILA"][$i][0]=$this->metodoEjecutar;
		 $_SESSION["_PILA"][$i][1]=$this-> nombreClase;
		 $_SESSION["_PILA"][$i][2]=$this->aPostData['p'];
		 $_SESSION["_PILA_TIME"][$i]=explode(" ",microtime());
		 $_SESSION["_IN_PILA"] = $this-> ind($i,'+',1);	
		 
		  //comparamos valoes en la pila con las penultima transaccion
			 /*
			  var_dump($_SESSION["_PILA"]);
			  var_dump($_SESSION["_PILA_TIME"]);
			  exit;*/
		   $k = $this-> ind($i,'-',1);
		   
		   $tiempo=0;
		   $repetidos=0;
		 
		   if($_SESSION["_PILA"][$k][0] == $_SESSION["_PILA"][$i][0]){
		 	 if($_SESSION["_PILA"][$k][1] == $_SESSION["_PILA"][$i][1])
		        {
		        	//$sospechoso=$sospechoso+1;
		        	//$repetidos=$repetidos+1;
		        	
		        	if($_SESSION["_PILA"][$k][2] == $_SESSION["_PILA"][$i][2]){
		        		$sospechoso=$sospechoso+1;
		        		$repetidos=$repetidos+1;
		        		
						  	//si la clase y el metodo son iguales (son sospechosos de DoS) revisamos las marcas de tiempo
						   if ( $aux <= $_SESSION["_PILA_TIME"][$k][1]){ 
						       if ( ($_SESSION["_PILA_TIME"][$i][0] - $_SESSION['_MSEG_DOS'])<= $_SESSION["_PILA_TIME"][$k][0]){ 
						          $sospechoso = $sospechoso+2;
						          $tiempo=$tiempo+2;
						       }
						   }
		        		
		        		 $z = $this-> ind($i,'-',2);
						 //preguntamos si es igual al antepenultimo
						   if($_SESSION["_PILA"][$z][0] == $_SESSION["_PILA"][$i][0]){
						 	 if($_SESSION["_PILA"][$z][1]==$_SESSION["_PILA"][$i][1])
						        {
						        	//$sospechoso=$sospechoso+1;
						        	//$repetidos=$repetidos+1;
						           
						            if($_SESSION["_PILA"][$z][2] == $_SESSION["_PILA"][$z][2]){
						        		$sospechoso=$sospechoso+2;
						        		$repetidos=$repetidos+2;
						        		
						        		$g=$this-> ind($i,'-',3);
						        		 if($_SESSION["_PILA"][$g][2] == $_SESSION["_PILA"][$z][2]){
								        		$sospechoso=$sospechoso+1;
								        		$repetidos=$repetidos+1;
								        		
						        		  $aux = $_SESSION["_PILA_TIME"][$g][1] - $_SESSION['_SEG_DOS'];
								        	//si la clase y el metodo son iguales (son sospechosos de DoS) revisamos las marcas de tiempo
										    if ( $aux <= $_SESSION["_PILA_TIME"][$z][1]){ 
										       if ( ($_SESSION["_PILA_TIME"][$i][0] - ($_SESSION['_MSEG_DOS'])*2)<= $_SESSION["_PILA_TIME"][$z][0]){ 
										          $sospechoso = $sospechoso+3;
										          $tiempo=$tiempo+3;
										        }
										      }
								        		
								        		
						        		 }		
						        		
						        	}
						        	 $aux = $_SESSION["_PILA_TIME"][$i][1] - $_SESSION['_SEG_DOS'];
						        	//si la clase y el metodo son iguales (son sospechosos de DoS) revisamos las marcas de tiempo
								    if ( $aux <= $_SESSION["_PILA_TIME"][$z][1]){ 
								       if ( ($_SESSION["_PILA_TIME"][$i][0] - ($_SESSION['_MSEG_DOS'])+0.3)<= $_SESSION["_PILA_TIME"][$z][0]){ 
								          $sospechoso = $sospechoso+3;
								          $tiempo=$tiempo+3;
								        }
								      }
								        	
						        	
						        }
						   } 
		        		
		        		
		        		
		        	}
		        }	
		   } 
		   
          //preguntamos por las marca de tiempo de penultima trasaccion
		  $aux = $_SESSION["_PILA_TIME"][$i][1] - $_SESSION['_SEG_DOS'];
		  
		   
		  
		   
		   //preguntamos por las marcas de tiempo de la antepenultima trasaccion
		   
	        
		   
		   
		 
		 
		 if( $sospechoso >=$_SESSION["_PESOMAX_DOS"]){
		 	
		 	throw new Exception("Bloqueado por multiples intentos repetidos, posible ataque DoS ($sospechoso,$repetidos,$tiempo)",2);
		 	
		 	
		 }  
		   
	}
	/**
	 * Autor: Rensi Arteaga Copari
	 * Fecha: 08/01/2010
	 * desc:   con mod = 10  tenemos que 9 +1 = 0
	 *         9+2 = 1,   0-1 = 9, etc;
	 * funcion creada para calcular  la posicion en la pila del 
	 * indice
	 */
	private function ind($i,$opr,$j){
		$mod = $_SESSION['_TAM_MAX'];
		if($opr=='+'){
			$k= $i+$j;
			if($k >= $mod){
				
			$k = $k % $mod;
			}
		}
		else{
			$k = $i - $j;
			if($k<0){
				$k= $k % -$mod;
				$k = $mod -k;
			}
     	}
		return $k;
	}


	//Verifica si la sesion esta activa
	private function verificarSesion(){
		//Verifica la sesion excepto cuando sea GetPublicKey
		// var_dump($_SESSION["_SESION"]);
		//exit;

		if($this->objPostData->getVerificarSesion()){
			if(isset($_SESSION["_SESION"])){
				if(!$_SESSION["_SESION"] instanceof CTSesion) {
					throw new Exception('sesion no valida',2);
					exit;
				} else{
						
					//si la sesion esta inactiva el unico metodo que puede ejecutar es getPublicKey
					//o si la sesion esta prepara el unico unico metodo que puede ejecutar es verificarCredenciales

					if($_SESSION["_SESION"]->getEstado()=='inactiva' or $_SESSION["_SESION"]->getEstado()=='preparada'){

						if(!(($this->metodoEjecutar=='getPublicKey' AND $this->nombreClase=='Auten')or ($this->metodoEjecutar=='verificarCredenciales' AND $this->nombreClase=='Auten'))){
								
							throw new Exception('La sesion no esta activa',2);
						}
							
					}
						
					//si la sesion esta activa verifica sis las credenciales son correctas
					elseif($_SESSION["_SESION"]->validarSesion()){

						return true;
					}
					else{
						//destruimos las sesion para que se cre un nuevo
						//identificador en la proxima conexion
						session_destroy();
						throw new Exception('La sesion ha sido duplicada',2);
							
							
					}
				}
			} else{
				//session_destroy();
				//var_dump( $_SESSION["_SESION"]);
                //exit;
				throw new Exception('sesion no iniciada',2);
				
			}
			return true;
		} else{
			return true;
		}
	}


}
?>