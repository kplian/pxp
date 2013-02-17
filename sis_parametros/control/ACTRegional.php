<?php
/**
*@package pXP
*@file ACTRegional.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 23:27:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTRegional extends ACTbase{    
			
	function listarRegional(){
		$this->objParam->defecto('ordenacion','id_regional');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODRegional','listarRegional');
		} else{
			$this->objFunc=$this->create('MODRegional');
			
			$this->res=$this->objFunc->listarRegional($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarRegional(){
		$this->objFunc=$this->create('MODRegional');	
		if($this->objParam->insertar('id_regional')){
			$this->res=$this->objFunc->insertarRegional($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarRegional($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarRegional(){
			$this->objFunc=$this->create('MODRegional');	
		$this->res=$this->objFunc->eliminarRegional($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>