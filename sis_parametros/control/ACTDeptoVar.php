<?php
/**
*@package pXP
*@file gen-ACTDeptoVar.php
*@author  (admin)
*@date 22-11-2016 20:17:52
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDeptoVar extends ACTbase{    
			
	function listarDeptoVar(){
		$this->objParam->defecto('ordenacion','id_depto_var');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_depto')!=''){
	    	$this->objParam->addFiltro("deva.id_depto = ".$this->objParam->getParametro('id_depto'));	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDeptoVar','listarDeptoVar');
		} else{
			$this->objFunc=$this->create('MODDeptoVar');
			
			$this->res=$this->objFunc->listarDeptoVar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDeptoVar(){
		$this->objFunc=$this->create('MODDeptoVar');	
		if($this->objParam->insertar('id_depto_var')){
			$this->res=$this->objFunc->insertarDeptoVar($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDeptoVar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDeptoVar(){
			$this->objFunc=$this->create('MODDeptoVar');	
		$this->res=$this->objFunc->eliminarDeptoVar($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>