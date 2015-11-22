<?php
/**
*@package pXP
*@file gen-ACTProveedorCtaBancaria.php
*@author  (gsarmiento)
*@date 30-10-2015 20:07:41
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProveedorCtaBancaria extends ACTbase{    
			
	function listarProveedorCtaBancaria(){
		$this->objParam->defecto('ordenacion','id_proveedor_cta_bancaria');
		
		if($this->objParam->getParametro('id_proveedor')!=''){
	    	$this->objParam->addFiltro("pctaban.id_proveedor = ".$this->objParam->getParametro('id_proveedor'));	
		}

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProveedorCtaBancaria','listarProveedorCtaBancaria');
		} else{
			$this->objFunc=$this->create('MODProveedorCtaBancaria');
			
			$this->res=$this->objFunc->listarProveedorCtaBancaria($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedorCtaBancaria(){
		$this->objFunc=$this->create('MODProveedorCtaBancaria');	
		if($this->objParam->insertar('id_proveedor_cta_bancaria')){
			$this->res=$this->objFunc->insertarProveedorCtaBancaria($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProveedorCtaBancaria($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedorCtaBancaria(){
			$this->objFunc=$this->create('MODProveedorCtaBancaria');	
		$this->res=$this->objFunc->eliminarProveedorCtaBancaria($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>