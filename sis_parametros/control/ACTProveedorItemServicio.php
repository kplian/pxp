<?php
/**
*@package pXP
*@file gen-ACTProveedorItemServicio.php
*@author  (admin)
*@date 15-08-2012 18:56:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProveedorItemServicio extends ACTbase{    
			
	function listarProveedorItemServicio(){
		$this->objParam->defecto('ordenacion','id_proveedor_item');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_proveedor')!=''){
			$this->objParam->addFiltro("pritse.id_proveedor = ".$this->objParam->getParametro('id_proveedor'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedorItemServicio','listarProveedorItemServicio');
		} else{
			$this->objFunc=$this->create('MODProveedorItemServicio');
			$this->res=$this->objFunc->listarProveedorItemServicio();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedorItemServicio(){
		$this->objFunc=$this->create('MODProveedorItemServicio');
		if($this->objParam->insertar('id_proveedor_item')){
			$this->res=$this->objFunc->insertarProveedorItemServicio();			
		} else{			
			$this->res=$this->objFunc->modificarProveedorItemServicio();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedorItemServicio(){
		$this->objFunc=$this->create('MODProveedorItemServicio');
		$this->res=$this->objFunc->eliminarProveedorItemServicio();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>