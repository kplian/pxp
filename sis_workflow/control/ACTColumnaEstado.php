<?php
/**
*@package pXP
*@file gen-ACTColumnaEstado.php
*@author  (admin)
*@date 07-05-2014 21:41:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTColumnaEstado extends ACTbase{    
			
	function listarColumnaEstado(){
		$this->objParam->defecto('ordenacion','id_columna_estado');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_tipo_columna') != '') {
			$this->objParam->addFiltro("colest.id_tipo_columna = ". $this->objParam->getParametro('id_tipo_columna'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODColumnaEstado','listarColumnaEstado');
		} else{
			$this->objFunc=$this->create('MODColumnaEstado');
			
			$this->res=$this->objFunc->listarColumnaEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarColumnaEstado(){
		$this->objFunc=$this->create('MODColumnaEstado');	
		if($this->objParam->insertar('id_columna_estado')){
			$this->res=$this->objFunc->insertarColumnaEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarColumnaEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarColumnaEstado(){
			$this->objFunc=$this->create('MODColumnaEstado');	
		$this->res=$this->objFunc->eliminarColumnaEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>