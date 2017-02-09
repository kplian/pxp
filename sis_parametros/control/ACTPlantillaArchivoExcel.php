<?php
/**
*@package pXP
*@file gen-ACTPlantillaArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPlantillaArchivoExcel extends ACTbase{    
			
	function listarPlantillaArchivoExcel(){
		$this->objParam->defecto('ordenacion','id_plantilla_archivo_excel');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantillaArchivoExcel','listarPlantillaArchivoExcel');
		} else{
			$this->objFunc=$this->create('MODPlantillaArchivoExcel');
			
			$this->res=$this->objFunc->listarPlantillaArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantillaArchivoExcel(){
		$this->objFunc=$this->create('MODPlantillaArchivoExcel');	
		if($this->objParam->insertar('id_plantilla_archivo_excel')){
			$this->res=$this->objFunc->insertarPlantillaArchivoExcel($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantillaArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantillaArchivoExcel(){
			$this->objFunc=$this->create('MODPlantillaArchivoExcel');	
		$this->res=$this->objFunc->eliminarPlantillaArchivoExcel($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>