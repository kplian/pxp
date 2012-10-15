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
	
}
?>