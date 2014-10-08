<?php
/**
*@package pXP
*@file gen-ACTCategoriaProveedor.php
*@author  (gsarmiento)
*@date 06-10-2014 14:06:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCategoriaProveedor extends ACTbase{    
			
	function listarCategoriaProveedor(){
		$this->objParam->defecto('ordenacion','id_categoria_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCategoriaProveedor','listarCategoriaProveedor');
		} else{
			$this->objFunc=$this->create('MODCategoriaProveedor');
			
			$this->res=$this->objFunc->listarCategoriaProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCategoriaProveedor(){
		$this->objFunc=$this->create('MODCategoriaProveedor');	
		if($this->objParam->insertar('id_categoria_proveedor')){
			$this->res=$this->objFunc->insertarCategoriaProveedor($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCategoriaProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCategoriaProveedor(){
			$this->objFunc=$this->create('MODCategoriaProveedor');	
		$this->res=$this->objFunc->eliminarCategoriaProveedor($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>