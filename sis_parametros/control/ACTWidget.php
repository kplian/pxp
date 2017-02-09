<?php
/**
*@package pXP
*@file gen-ACTWidget.php
*@author  (admin)
*@date 10-09-2016 08:00:16
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTWidget extends ACTbase{    
			
	function listarWidget(){
		$this->objParam->defecto('ordenacion','id_widget');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODWidget','listarWidget');
		} else{
			$this->objFunc=$this->create('MODWidget');
			
			$this->res=$this->objFunc->listarWidget($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarWidget(){
		$this->objFunc=$this->create('MODWidget');	
		if($this->objParam->insertar('id_widget')){
			$this->res=$this->objFunc->insertarWidget($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarWidget($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarWidget(){
			$this->objFunc=$this->create('MODWidget');	
		$this->res=$this->objFunc->eliminarWidget($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function subirImagen(){
		$this->objFunSeguridad=$this->create('MODWidget');	
		$this->res=$this->objFunSeguridad->subirImagen($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>