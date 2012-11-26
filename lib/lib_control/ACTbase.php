<?php
/***
 Nombre: ACTbase.php
 Proposito: Clase base con las variables y metodos basicos de los archivos de control
 Autor:	Kplian (RCM)
 Fecha:	01/07/2010
 */
abstract class ACTbase
{
	protected $objParam;
	protected $objSeguridad;
	protected $objReporte;
	protected $res;

	function __construct(CTParametro $pParam){
		
		$this->objParam=  $pParam;		
	}
	
	function create($className) {
		$myArray = explode("/", $className);
		$reflector = new ReflectionClass(get_class($this));
		//si el tamano del array es dos se debe incluir un modelo en otro subsistema
		//si el tamano del array es uno se incluye un modelo del mismo subsistema
		// sino se de lanzar una excepcion
		if (sizeof($myArray) == 1) {			
			$includeDir = dirname($reflector->getFileName()) . "/../modelo/";
			$fileName = $myArray [0] . '.php';			
			
		} else if (sizeof($myArray) == 2) {			
			$includeDir = dirname($reflector->getFileName()) . "/../../" . $myArray[0] . "modelo/";
			$fileName = $myArray [1] . '.php';			
			
		} else {
			throw new Exception(__METHOD__.': No se pudo incluir el modelo '.$className);
		}
		
		include_once $includeDir . $fileName;
		eval('$modelObj = new $myArray[0]($this->objParam);');
		return $modelObj;
		
	}
	
}
?>
