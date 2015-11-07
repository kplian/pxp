<?php
/**
*@package pXP
*@file gen-ACTEntidad.php
*@author  (admin)
*@date 20-09-2015 19:11:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEntidad extends ACTbase{    
			
	function listarEntidad(){
		$this->objParam->defecto('ordenacion','id_entidad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEntidad','listarEntidad');
		} else{
			$this->objFunc=$this->create('MODEntidad');
			
			$this->res=$this->objFunc->listarEntidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEntidad(){
		$this->objFunc=$this->create('MODEntidad');	
		if($this->objParam->insertar('id_entidad')){
			$this->res=$this->objFunc->insertarEntidad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEntidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEntidad(){
			$this->objFunc=$this->create('MODEntidad');	
		$this->res=$this->objFunc->eliminarEntidad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>