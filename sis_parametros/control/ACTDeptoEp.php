<?php
/**
*@package pXP
*@file gen-ACTDeptoEp.php
*@author  (admin)
*@date 29-04-2013 20:34:21
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDeptoEp extends ACTbase{    
			
	function listarDeptoEp(){
		$this->objParam->defecto('ordenacion','id_depto_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDeptoEp','listarDeptoEp');
		} else{
			$this->objFunc=$this->create('MODDeptoEp');
			
			$this->res=$this->objFunc->listarDeptoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDeptoEp(){
		$this->objFunc=$this->create('MODDeptoEp');	
		if($this->objParam->insertar('id_depto_ep')){
			$this->res=$this->objFunc->insertarDeptoEp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDeptoEp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoEp(){
			$this->objFunc=$this->create('MODDeptoEp');	
		$this->res=$this->objFunc->eliminarDeptoEp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>