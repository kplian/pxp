<?php
/**
*@package pXP
*@file gen-ACTCatalogo.php
*@author  (admin)
*@date 16-05-2014 22:55:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatalogo extends ACTbase{    
			
	function listarCatalogo(){
		$this->objParam->defecto('ordenacion','id_catalogo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_proceso_macro')!=''){
			$this->objParam->addFiltro("catalo.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCatalogo','listarCatalogo');
		} else{
			$this->objFunc=$this->create('MODCatalogo');
			
			$this->res=$this->objFunc->listarCatalogo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatalogo(){
		$this->objFunc=$this->create('MODCatalogo');	
		if($this->objParam->insertar('id_catalogo')){
			$this->res=$this->objFunc->insertarCatalogo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatalogo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatalogo(){
			$this->objFunc=$this->create('MODCatalogo');	
		$this->res=$this->objFunc->eliminarCatalogo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>