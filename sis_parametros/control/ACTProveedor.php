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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarProveedor');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarProveedorCombos(){
		$this->objParam->defecto('ordenacion','id_proveedor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarProveedorCombos');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarProveedorCombos($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedor(){
		$this->objFunc=new FuncionesParametros();	
		//print_r($this->objParam); exit;
		if($this->objParam->insertar('id_proveedor')){
			$this->res=$this->objFunc->insertarProveedor($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProveedor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedor(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarProveedor($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>