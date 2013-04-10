<?php
/**
*@package pXP
*@file ACTPlantilla.php
*@author  Gonzalo Sarmiento Sejas
*@date 01-04-2013 19:57:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPlantilla extends ACTbase{    
			
	function listarPlantilla(){
		$this->objParam->defecto('ordenacion','id_plantilla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPlantilla','listarPlantilla');
		} else{
			$this->objFunc=$this->create('MODPlantilla');
			
			$this->res=$this->objFunc->listarPlantilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlantilla(){
		$this->objFunc=$this->create('MODPlantilla');	
		if($this->objParam->insertar('id_plantilla')){
			$this->res=$this->objFunc->insertarPlantilla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlantilla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlantilla(){
			$this->objFunc=$this->create('MODPlantilla');	
		$this->res=$this->objFunc->eliminarPlantilla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>