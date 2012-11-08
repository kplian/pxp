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
		
		if($this->objParam->getParametro('id_proveedor')!='')
		{
			$this->objParam->addFiltro("pritse.id_proveedor = ".$this->objParam->getParametro('id_proveedor'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarProveedorItemServicio');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarProveedorItemServicio($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProveedorItemServicio(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_proveedor_item')){
			$this->res=$this->objFunc->insertarProveedorItemServicio($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProveedorItemServicio($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProveedorItemServicio(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarProveedorItemServicio($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>