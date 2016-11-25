<?php
/**
*@package pXP
*@file gen-ACTSubsistemaVar.php
*@author  (admin)
*@date 22-11-2016 19:19:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
class ACTSubsistemaVar extends ACTbase{    
			
	function listarSubsistemaVar(){
		$this->objParam->defecto('ordenacion','id_subsistema_var');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_subsistema')!=''){
	    	$this->objParam->addFiltro("vari.id_subsistema = ".$this->objParam->getParametro('id_subsistema'));	
		}
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODSubsistemaVar','listarSubsistemaVar');
		} else{
			$this->objFunc=$this->create('MODSubsistemaVar');
			
			$this->res=$this->objFunc->listarSubsistemaVar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSubsistemaVar(){
		$this->objFunc=$this->create('MODSubsistemaVar');	
		if($this->objParam->insertar('id_subsistema_var')){
			$this->res=$this->objFunc->insertarSubsistemaVar($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSubsistemaVar($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSubsistemaVar(){
			$this->objFunc=$this->create('MODSubsistemaVar');	
		$this->res=$this->objFunc->eliminarSubsistemaVar($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}
?>