<?php
/**
*@package pXP
*@file gen-ACTEstructuraEstado.php
*@author  (FRH)
*@date 21-02-2013 15:25:45
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEstructuraEstado extends ACTbase{    
			
	function listarEstructuraEstado(){
		$this->objParam->defecto('ordenacion','id_estructura_estado');

        if($this->objParam->getParametro('id_tipo_estado_padre')!=''){
	    	$this->objParam->addFiltro("estes.id_tipo_estado_padre = ".$this->objParam->getParametro('id_tipo_estado_padre'));	
		}
		
		 if($this->objParam->getParametro('id_tipo_estado_hijo')!=''){
	    	$this->objParam->addFiltro("estes.id_tipo_estado_hijo = ".$this->objParam->getParametro('id_tipo_estado_hijo'));	
		}

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEstructuraEstado','listarEstructuraEstado');
		} else{
			$this->objFunc=$this->create('MODEstructuraEstado');
			
			$this->res=$this->objFunc->listarEstructuraEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEstructuraEstado(){
		$this->objFunc=$this->create('MODEstructuraEstado');	
		if($this->objParam->insertar('id_estructura_estado')){
			$this->res=$this->objFunc->insertarEstructuraEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEstructuraEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEstructuraEstado(){
			$this->objFunc=$this->create('MODEstructuraEstado');	
		$this->res=$this->objFunc->eliminarEstructuraEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>