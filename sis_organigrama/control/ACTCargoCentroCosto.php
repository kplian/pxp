<?php
/**
*@package pXP
*@file gen-ACTCargoCentroCosto.php
*@author  (admin)
*@date 15-01-2014 13:05:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCargoCentroCosto extends ACTbase{    
			
	function listarCargoCentroCosto(){
		$this->objParam->defecto('ordenacion','id_cargo_centro_costo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_cargo') != '') {
			$this->objParam->addFiltro("carpre.id_cargo = ". $this->objParam->getParametro('id_cargo'));
		}
		
		if ($this->objParam->getParametro('id_gestion') != '') {
			$this->objParam->addFiltro("carpre.id_gestion = ". $this->objParam->getParametro('id_gestion'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCargoCentroCosto','listarCargoCentroCosto');
		} else{
			$this->objFunc=$this->create('MODCargoCentroCosto');
			
			$this->res=$this->objFunc->listarCargoCentroCosto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCargoCentroCosto(){
		$this->objFunc=$this->create('MODCargoCentroCosto');	
		if($this->objParam->insertar('id_cargo_centro_costo')){
			$this->res=$this->objFunc->insertarCargoCentroCosto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCargoCentroCosto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCargoCentroCosto(){
			$this->objFunc=$this->create('MODCargoCentroCosto');	
		$this->res=$this->objFunc->eliminarCargoCentroCosto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>