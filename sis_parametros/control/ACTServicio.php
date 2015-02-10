<?php
/**
*@package pXP
*@file gen-ACTServicio.php
*@author  (admin)
*@date 16-08-2012 23:48:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTServicio extends ACTbase{    
			
	function listarServicio(){
		$this->objParam->defecto('ordenacion','id_servicio');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODServicio','listarServicio');
		} else{
			$this->objFunc=$this->create('MODServicio');
			$this->res=$this->objFunc->listarServicio();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarServicio(){
		$this->objFunc=$this->create('MODServicio');	
		if($this->objParam->insertar('id_servicio')){
			$this->res=$this->objFunc->insertarServicio();			
		} else{			
			$this->res=$this->objFunc->modificarServicio();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarServicio(){
		$this->objFunc=$this->create('MODServicio');	
		$this->res=$this->objFunc->eliminarServicio();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>