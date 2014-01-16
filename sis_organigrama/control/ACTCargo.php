<?php
/**
*@package pXP
*@file gen-ACTCargo.php
*@author  (admin)
*@date 14-01-2014 19:16:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCargo extends ACTbase{    
			
	function listarCargo(){
		$this->objParam->defecto('ordenacion','id_cargo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_uo') != '') {
			$this->objParam->addFiltro("cargo.id_uo = ". $this->objParam->getParametro('id_uo'));
		}		
				
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCargo','listarCargo');
		} else{
			$this->objFunc=$this->create('MODCargo');
			
			$this->res=$this->objFunc->listarCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCargo(){
		$this->objFunc=$this->create('MODCargo');	
		if($this->objParam->insertar('id_cargo')){
			$this->res=$this->objFunc->insertarCargo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCargo(){
			$this->objFunc=$this->create('MODCargo');	
		$this->res=$this->objFunc->eliminarCargo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>