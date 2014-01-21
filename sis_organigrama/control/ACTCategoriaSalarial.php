<?php
/**
*@package pXP
*@file gen-ACTCategoriaSalarial.php
*@author  (admin)
*@date 13-01-2014 23:53:05
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCategoriaSalarial extends ACTbase{    
			
	function listarCategoriaSalarial(){
		$this->objParam->defecto('ordenacion','id_categoria_salarial');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCategoriaSalarial','listarCategoriaSalarial');
		} else{
			$this->objFunc=$this->create('MODCategoriaSalarial');
			
			$this->res=$this->objFunc->listarCategoriaSalarial($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCategoriaSalarial(){
		$this->objFunc=$this->create('MODCategoriaSalarial');	
		if($this->objParam->insertar('id_categoria_salarial')){
			$this->res=$this->objFunc->insertarCategoriaSalarial($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCategoriaSalarial($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCategoriaSalarial(){
			$this->objFunc=$this->create('MODCategoriaSalarial');	
		$this->res=$this->objFunc->eliminarCategoriaSalarial($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>