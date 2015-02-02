<?php
/**
*@package pXP
*@file gen-ACTExtension.php
*@author  (admin)
*@date 23-12-2013 20:12:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTExtension extends ACTbase{    
			
	function listarExtension(){
		$this->objParam->defecto('ordenacion','id_extension');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODExtension','listarExtension');
		} else{
			$this->objFunc=$this->create('MODExtension');
			
			$this->res=$this->objFunc->listarExtension($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarExtension(){
		$this->objFunc=$this->create('MODExtension');	
		if($this->objParam->insertar('id_extension')){
			$this->res=$this->objFunc->insertarExtension($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarExtension($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarExtension(){
			$this->objFunc=$this->create('MODExtension');	
		$this->res=$this->objFunc->eliminarExtension($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>