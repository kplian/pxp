<?php
/**
*@package pXP
*@file gen-ACTCatalogo.php
*@author  (admin)
*@date 16-11-2012 17:01:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatalogo extends ACTbase{    
			
	function listarCatalogo(){
		$this->objParam->defecto('ordenacion','id_catalogo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarCatalogo');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarCatalogo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatalogo(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_catalogo')){
			$this->res=$this->objFunc->insertarCatalogo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatalogo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatalogo(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarCatalogo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>