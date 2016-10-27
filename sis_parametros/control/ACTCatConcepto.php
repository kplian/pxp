<?php
/**
*@package pXP
*@file gen-ACTCatConcepto.php
*@author  (admin)
*@date 27-10-2016 06:32:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatConcepto extends ACTbase{    
			
	function listarCatConcepto(){
		$this->objParam->defecto('ordenacion','id_cat_concepto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCatConcepto','listarCatConcepto');
		} else{
			$this->objFunc=$this->create('MODCatConcepto');
			
			$this->res=$this->objFunc->listarCatConcepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatConcepto(){
		$this->objFunc=$this->create('MODCatConcepto');	
		if($this->objParam->insertar('id_cat_concepto')){
			$this->res=$this->objFunc->insertarCatConcepto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatConcepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatConcepto(){
			$this->objFunc=$this->create('MODCatConcepto');	
		$this->res=$this->objFunc->eliminarCatConcepto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>