<?php
/**
*@package pXP
*@file gen-ACTCentroCosto.php
*@author  (admin)
*@date 19-02-2013 22:53:59
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCentroCosto extends ACTbase{    
			
	function listarCentroCosto(){
		$this->objParam->defecto('ordenacion','id_centro_costo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCentroCosto','listarCentroCosto');
		} else{
			$this->objFunc=$this->create('MODCentroCosto');
			
			$this->res=$this->objFunc->listarCentroCosto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCentroCosto(){
		$this->objFunc=$this->create('MODCentroCosto');	
		if($this->objParam->insertar('id_centro_costo')){
			$this->res=$this->objFunc->insertarCentroCosto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCentroCosto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCentroCosto(){
			$this->objFunc=$this->create('MODCentroCosto');	
		$this->res=$this->objFunc->eliminarCentroCosto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>