<?php
/**
*@package pXP
*@file ACTEp.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 19:20:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEp extends ACTbase{    
			
	function listarEp(){
		$this->objParam->defecto('ordenacion','id_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEp','listarEp');
		} else{
			$this->objFunc=$this->create('MODEp');
			
			$this->res=$this->objFunc->listarEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEp(){
		$this->objFunc=$this->create('MODEp');	
		if($this->objParam->insertar('id_ep')){
			$this->res=$this->objFunc->insertarEp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEp(){
			$this->objFunc=$this->create('MODEp');	
		$this->res=$this->objFunc->eliminarEp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>