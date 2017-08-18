<?php
/***
 Nombre: ACTbase.php
 Proposito: Clase base con las variables y metodos basicos de los archivos de control
 Autor:	Kplian (RCM)
 Fecha:	01/07/2010
 */

use WebSocket\Client;

abstract class ACTbase
{
	protected $objParam;
	protected $objSeguridad;
	protected $objReporte;
	protected $res;

	function __construct(CTParametro $pParam){
		
		$this->objParam=  $pParam;		
	}
	
	/**
	*
	*   Ejemplo:   
	*
	*
	*/
	
	function create($className) {
		$myArray = explode("/", $className);
		$reflector = new ReflectionClass(get_class($this));
		//si el tamano del array es dos se debe incluir un modelo en otro subsistema
		//si el tamano del array es uno se incluye un modelo del mismo subsistema
		// sino se de lanzar una excepcion
		if (sizeof($myArray) == 1) {			
			$includeDir = dirname($reflector->getFileName()) . "/../modelo/";
			$fileName = $myArray [0] . '.php';			
			include_once $includeDir . $fileName;
			
		 eval('$modelObj = new $myArray[0]($this->objParam);');	
		 
		} else if (sizeof($myArray) == 2) {			
			$includeDir = dirname($reflector->getFileName()) . "/../../" . $myArray[0] . "/modelo/";
			$fileName = $myArray [1] . '.php';			
		 include_once $includeDir . $fileName;
		 eval('$modelObj = new $myArray[1]($this->objParam);');						
		} else if (sizeof($myArray) == 3) {			
			$includeDir = dirname($reflector->getFileName()) . "/../../../" . $myArray[1] . "/modelo/";
			$fileName = $myArray [2] . '.php';			
		 include_once $includeDir . $fileName;
		 eval('$modelObj = new $myArray[2]($this->objParam);');			
		} else {
			throw new Exception(__METHOD__.': No se pudo incluir el modelo '.$className);
		}
		//var_dump($this->objParam->getParametro("codigo_tipo_documento")); exit;
		return $modelObj;
		
	}

	function dispararEventoWS($send){

        $client = new Client("ws://localhost:".$_SESSION['_PUERTO_WEBSOCKET']."?sessionIDPXP=".session_id());

        $client->send(json_encode($send));

        return $client->receive();

	}
	
}
?>
