<?php
/**
*@package pXP
*@file gen-ACTLibreta.php
*@author  (rac)
*@date 18-06-2012 16:21:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLibreta extends ACTbase{    
			
	function listarLibreta(){
		$this->objParam->defecto('ordenacion','id_libreta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODLibreta','listarLibreta');
		} else{
			$this->objFunc=$this->create('MODLibreta');	
			$this->res=$this->objFunc->listarLibreta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLibreta(){
		$this->objFunc=$this->create('MODLibreta');	
		if($this->objParam->insertar('id_libreta')){
			$this->res=$this->objFunc->insertarLibreta();			
		} else{			
			$this->res=$this->objFunc->modificarLibreta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLibreta(){
		$this->objFunc=$this->create('MODLibreta');	
		$this->res=$this->objFunc->eliminarLibreta();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>