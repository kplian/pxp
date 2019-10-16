<?php
/***
 Nombre: CTPostData.php
 Proposito: Clase que tendra los metodos necesarios para recibir los
 datos de la capa de la vista por cualquier metodo post, get, etc.
 Autor:	Kplian (RCM)
 Fecha:	02/07/2010
 *  HISTORIAL DE MODIFICACIONES:
       
 ISSUE              FECHA:              AUTOR                 DESCRIPCION
 #75               10/15/2019         RAC KPLIAN        encriptacion dejo de funcionar por el cambio de versión de librerias
 */
class CTPostData{

	//Variables
	private $aVariablesEncryp=array();
	private $tmpKeys=array();
	private $aVariablesDecryp=array();
	private $oEncryp;
	private $aNoEncrip=array();
	private $aFiles=array();
	private $swVerificarSesion=1;

	function __construct(){

		//Ejecuta la funcion para obtener todos los datos por POST o GET
		array_push($this->aNoEncrip,'../../sis_seguridad/control/Auten/getPublicKey');
		array_push($this->aNoEncrip,'../../sis_seguridad/control/Auten/prepararLlavesSession');
		$this->obtenerPostData();
		
	}

	//Funcion que verifica los arrays de recibo de datos empezando por post, despues get,...
	private function obtenerPostData(){
		
		try {
			
			//Verifica si se ha enviado algun dato
			if(count($_REQUEST)>0){
				//Se obtiene las claves (nombres de las columnas) del array
				$this->tmpKeys=array_keys($_REQUEST);
				$i=0;
				
				//Se obtiene lo enviado en estado nativo que puede estar encriptado o no
				foreach($_REQUEST as $row){
					$this->aVariablesEncryp[$this->tmpKeys[$i]]=$row;//$this->tmpValues[$i];
					$i++;
				}

				//DESENCRIPTACION: Verifica si lo enviado es encriptado
				if($_SESSION["encriptar_data"]=='si'){
				
				    
					//Esta encriptado; recorre el array y desencripta uno a uno
					$i=0;
					foreach($this->aVariablesEncryp as $row){
						//Verifica que no sea la sesion para no desencriptarla
						
						if($this->siEncriptar($this->tmpKeys[$i],$row) && $this->swVerificarSesion==1){
							//Instancia la clase de encriptacion
							$this->oEncryp=new CTEncriptacionPrivada($row,$_SESSION['key_p'],$_SESSION['key_k'],$_SESSION['key_d'],$_SESSION['key_m']);
							$this->aVariablesDecryp[$this->tmpKeys[$i]] = urldecode(utf8_encode($this->oEncryp->getDecodificado())); //#75  ++urldecode
						} else{
							//echo 2;
							$this->aVariablesDecryp[$this->tmpKeys[$i]] = urldecode($row);  //#75 ++urldecode
						}
						$i++;
					}
				} else{
					//No esta encriptado, entonces copia lo mismo al array desencriptado
					
					$this->aVariablesDecryp=$this->aVariablesEncryp;
				}

				
				/*
				echo '<pre>';
				print_r($this->aVariablesDecryp);
				echo '</pre>';
				exit;*/
			}
			//rac 22/09/2011 para capturar archivos mandados por el cliente
			
			if(count($_FILES)>0){
				/*
				//var_dump($_FILES);
				//var_dump($this->afiles);
				
				
				//Se obtiene las claves (nombres de las columnas) del array
				$this->tmpKeys=array_keys($_FILES);
				//var_dump($this->tmpKeys);				
				$i=0;
			
				//Se obtiene lo enviado en estado nativo que puede estar encriptado o no
				foreach($_FILES as $row){
					$this->afiles[$this->tmpKeys[$i]]=$row;//$this->tmpValues[$i];
					$i++;
				}*/
				
				$this->aFiles=$_FILES;
				//echo('CTPOST');
			//	var_dump($this->aFiles);
			}
			
			
		} catch (Exception $e){
			echo 'Error capturado -> '.$e->getMessage();
		}
	}

	private function siEncriptar($pKey,$pVal){
		//Verifica que el Key (nombre de la columna del array) no sea PHPSID
		
		foreach ($this->aNoEncrip as $row){
			
			if($pVal==$row){
				//Define la bandera para encriptar
				
				$this->swVerificarSesion=0;
				return false;
			}
		}

		if($this->tmpKeys[$i]!='PHPSESSID'){
			return true;
		}
		
		//Devuelve afirmativo
		return false;
	}

	//Propiedades
	function getData(){
		return $this->aVariablesDecryp;
	}
	//rac 22/09/2011
	function getFiles(){
		
		//var_dump($this->aFiles);
		return $this->aFiles;
	}

	function getDataEncryp(){
		return $this->aVariablesEncryp;
	}

	function getVerificarSesion(){
		return $this->swVerificarSesion;
	}

}
?>