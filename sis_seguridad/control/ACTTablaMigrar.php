<?php
/**
*@package pXP
*@file gen-ACTTablaMigrar.php
*@author  (admin)
*@date 16-01-2014 18:06:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTablaMigrar extends ACTbase{    
			
	function listarTablaMigrar(){
		$this->objParam->defecto('ordenacion','id_tabla_migrar');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTablaMigrar','listarTablaMigrar');
		} else{
			$this->objFunc=$this->create('MODTablaMigrar');
			
			$this->res=$this->objFunc->listarTablaMigrar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTablaMigrar(){
		$this->objFunc=$this->create('MODTablaMigrar');	
		if($this->objParam->insertar('id_tabla_migrar')){
			$this->res=$this->objFunc->insertarTablaMigrar($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTablaMigrar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTablaMigrar(){
			$this->objFunc=$this->create('MODTablaMigrar');	
		$this->res=$this->objFunc->eliminarTablaMigrar($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>