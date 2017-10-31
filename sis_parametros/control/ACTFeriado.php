<?php
/**
*@package pXP
*@file gen-ACTFeriado.php
*@author  (admin)
*@date 27-10-2017 13:52:45
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFeriado extends ACTbase{    
			
	function listarFeriado(){
		$this->objParam->defecto('ordenacion','id_feriado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODFeriado','listarFeriado');
		} else{
			$this->objFunc=$this->create('MODFeriado');
			
			$this->res=$this->objFunc->listarFeriado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFeriado(){
		$this->objFunc=$this->create('MODFeriado');	
		if($this->objParam->insertar('id_feriado')){
			$this->res=$this->objFunc->insertarFeriado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFeriado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFeriado(){
			$this->objFunc=$this->create('MODFeriado');	
		$this->res=$this->objFunc->eliminarFeriado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>