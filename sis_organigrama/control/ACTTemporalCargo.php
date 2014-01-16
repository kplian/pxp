<?php
/**
*@package pXP
*@file gen-ACTTemporalCargo.php
*@author  (admin)
*@date 14-01-2014 00:28:33
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTemporalCargo extends ACTbase{    
			
	function listarTemporalCargo(){
		$this->objParam->defecto('ordenacion','id_temporal_cargo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_jerarquia_aprobacion') != '') {
			$this->objParam->addFiltro("cargo.id_temporal_jerarquia_aprobacion = ". $this->objParam->getParametro('id_jerarquia_aprobacion'));
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTemporalCargo','listarTemporalCargo');
		} else{
			$this->objFunc=$this->create('MODTemporalCargo');
			
			$this->res=$this->objFunc->listarTemporalCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTemporalCargo(){
		$this->objFunc=$this->create('MODTemporalCargo');	
		if($this->objParam->insertar('id_temporal_cargo')){
			$this->res=$this->objFunc->insertarTemporalCargo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTemporalCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTemporalCargo(){
			$this->objFunc=$this->create('MODTemporalCargo');	
		$this->res=$this->objFunc->eliminarTemporalCargo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>