<?php
/**
*@package pXP
*@file gen-ACTConcepto.php
*@author  (rac)
*@date 16-08-2012 01:18:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConcepto extends ACTbase{    
			
	function listarConcepto(){
		$this->objParam->defecto('ordenacion','id_concepto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesTesor','listarConcepto');
		} else{
			$this->objFunc=new FuncionesTesor();	
			$this->res=$this->objFunc->listarConcepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConcepto(){
		$this->objFunc=new FuncionesTesor();	
		if($this->objParam->insertar('id_concepto')){
			$this->res=$this->objFunc->insertarConcepto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConcepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConcepto(){
		$this->objFunc=new FuncionesTesor();	
		$this->res=$this->objFunc->eliminarConcepto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>