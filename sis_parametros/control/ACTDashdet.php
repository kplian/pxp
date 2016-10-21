<?php
/**
*@package pXP
*@file gen-ACTDashdet.php
*@author  (admin)
*@date 10-09-2016 11:31:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDashdet extends ACTbase{    
			
	function listarDashdet(){
		$this->objParam->defecto('ordenacion','id_dashdet');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDashdet','listarDashdet');
		} else{
			$this->objFunc=$this->create('MODDashdet');
			
			$this->res=$this->objFunc->listarDashdet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarDashdetalle(){
		$this->objParam->defecto('ordenacion','id_dashdet');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDashdet','listarDashdetalle');
		} else{
			$this->objFunc=$this->create('MODDashdet');
			
			$this->res=$this->objFunc->listarDashdetalle($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDashdet(){
		$this->objFunc=$this->create('MODDashdet');	
		if($this->objParam->insertar('id_dashdet')){
			$this->res=$this->objFunc->insertarDashdet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDashdet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDashdet(){
			$this->objFunc=$this->create('MODDashdet');	
		$this->res=$this->objFunc->eliminarDashdet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarPosiciones(){
		$this->objFunc=$this->create('MODDashdet');	
		$this->res=$this->objFunc->guardarPosiciones($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		
			
}

?>