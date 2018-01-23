<?php
/**
*@package pXP
*@file gen-ACTPeriodo.php
*@author  (admin)
*@date 20-02-2013 04:11:23
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
class ACTPeriodo extends ACTbase{   			
	function listarPeriodo(){
		
		$this->objParam->defecto('ordenacion','periodo');		
	    if($this->objParam->getParametro('id_gestion')!=''){
	    	$this->objParam->addFiltro("per.id_gestion = ".$this->objParam->getParametro('id_gestion'));	
		}
		
		if($this->objParam->getParametro('fecha')!=''){
	    	$this->objParam->addFiltro("per.id_periodo = (select po_id_periodo from param.f_get_periodo_gestion(''".$this->objParam->getParametro('fecha')."''))");	
		}		
		
		$this->objParam->defecto('dir_ordenacion','asc');
		
	
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPeriodo','listarPeriodo');
		} else{
			$this->objFunc=$this->create('MODPeriodo');
			$this->res=$this->objFunc->listarPeriodo($this->objParam);
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
				
	function insertarPeriodo(){
		$this->objFunc=$this->create('MODPeriodo');	
		if($this->objParam->insertar('id_periodo')){
			$this->res=$this->objFunc->insertarPeriodo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPeriodo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPeriodo(){
			$this->objFunc=$this->create('MODPeriodo');	
		$this->res=$this->objFunc->eliminarPeriodo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function literalPeriodo(){
		$this->objFunc=$this->create('MODPeriodo');	
		$this->res=$this->objFunc->literalPeriodo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>