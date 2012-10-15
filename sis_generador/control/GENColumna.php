<?php
class GENColumna { 
	
	private $datos=array();
	
	function __construct($arreglo){
		$this->datos=$arreglo;
	}
	function getColumna($campo){
		return $this->datos[$campo];
	}
	
	
}
?>