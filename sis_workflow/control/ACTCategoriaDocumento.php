<?php
/**
*@package pXP
*@file gen-ACTCategoriaDocumento.php
*@author  (admin)
*@date 20-03-2015 15:44:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCategoriaDocumento extends ACTbase{    
			
	function listarCategoriaDocumento(){
		$this->objParam->defecto('ordenacion','id_categoria_documento');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCategoriaDocumento','listarCategoriaDocumento');
		} else{
			$this->objFunc=$this->create('MODCategoriaDocumento');
			
			$this->res=$this->objFunc->listarCategoriaDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCategoriaDocumento(){
		$this->objFunc=$this->create('MODCategoriaDocumento');	
		if($this->objParam->insertar('id_categoria_documento')){
			$this->res=$this->objFunc->insertarCategoriaDocumento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCategoriaDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCategoriaDocumento(){
			$this->objFunc=$this->create('MODCategoriaDocumento');	
		$this->res=$this->objFunc->eliminarCategoriaDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>