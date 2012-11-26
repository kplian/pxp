<?php
/**
*@package pXP
*@file gen-ACTProveedor.php
*@author  (mzm)
*@date 15-11-2011 10:44:58
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProveedor extends ACTbase{    
			
	function listarProveedor(){
		$this->objParam->defecto('ordenacion','id_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedor');
		} else{
			$this->objFunc=$this->create('MODProveedor');	
			$this->res=$this->objFunc->listarProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarProveedorCombos(){
		$this->objParam->defecto('ordenacion','id_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedor','listarProveedorCombos');
		} else{
			$this->objFunc=$this->create('MODProveedor');
			$this->res=$this->objFunc->listarProveedorCombos();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedor(){
		$this->objFunc=$this->create('MODProveedor');
		//print_r($this->objParam); exit;
		if($this->objParam->insertar('id_proveedor')){
			$this->res=$this->objFunc->insertarProveedor();			
		} else{			
			$this->res=$this->objFunc->modificarProveedor();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedor(){
		$this->objFunc=$this->create('MODProveedor');
		$this->res=$this->objFunc->eliminarProveedor();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>