<?php
/**
*@package pXP
*@file gen-ACTLibretaHer.php
*@author  (rac)
*@date 18-06-2012 16:45:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLibretaHer extends ACTbase{    
			
	function listarLibretaHer(){
		$this->objParam->defecto('ordenacion','id_libreta_her');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODLibretaHer','listarLibretaHer');
		} else{
			$this->objFunc=$this->create('MODLibretaHer');	
			$this->res=$this->objFunc->listarLibretaHer();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLibretaHer(){
		$this->objFunc=$this->create('MODLibretaHer');	
		if($this->objParam->insertar('id_libreta_her')){
			$this->res=$this->objFunc->insertarLibretaHer();			
		} else{			
			$this->res=$this->objFunc->modificarLibretaHer();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLibretaHer(){
		$this->objFunc=$this->create('MODLibretaHer');	
		$this->res=$this->objFunc->eliminarLibretaHer();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>