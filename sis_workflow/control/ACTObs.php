<?php
/**
*@package pXP
*@file gen-ACTObs.php
*@author  (admin)
*@date 20-11-2014 18:53:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTObs extends ACTbase{    
			
	function listarObs(){
		$this->objParam->defecto('ordenacion','id_obs');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODObs','listarObs');
		} else{
			$this->objFunc=$this->create('MODObs');
			
			$this->res=$this->objFunc->listarObs($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarObs(){
		$this->objFunc=$this->create('MODObs');	
		if($this->objParam->insertar('id_obs')){
			$this->res=$this->objFunc->insertarObs($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarObs($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarObs(){
			$this->objFunc=$this->create('MODObs');	
		$this->res=$this->objFunc->eliminarObs($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>