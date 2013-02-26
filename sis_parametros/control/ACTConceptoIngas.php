<?php
/**
*@package pXP
*@file gen-ACTConceptoIngas.php
*@author  (admin)
*@date 25-02-2013 19:49:23
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConceptoIngas extends ACTbase{    
			
	function listarConceptoIngas(){
		$this->objParam->defecto('ordenacion','id_concepto_ingas');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConceptoIngas','listarConceptoIngas');
		} else{
			$this->objFunc=$this->create('MODConceptoIngas');
			
			$this->res=$this->objFunc->listarConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConceptoIngas(){
		$this->objFunc=$this->create('MODConceptoIngas');	
		if($this->objParam->insertar('id_concepto_ingas')){
			$this->res=$this->objFunc->insertarConceptoIngas($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConceptoIngas(){
			$this->objFunc=$this->create('MODConceptoIngas');	
		$this->res=$this->objFunc->eliminarConceptoIngas($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>