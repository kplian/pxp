<?php
/**
*@package pXP
*@file gen-ACTTipoEstado.php
*@author  (admin)
*@date 21-02-2013 15:36:11
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoEstado extends ACTbase{    
			
	function listarTipoEstado(){
		$this->objParam->defecto('ordenacion','id_tipo_estado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoEstado','listarTipoEstado');
		} else{
			$this->objFunc=$this->create('MODTipoEstado');
			
			$this->res=$this->objFunc->listarTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoEstado(){
		$this->objFunc=$this->create('MODTipoEstado');	
		if($this->objParam->insertar('id_tipo_estado')){
			$this->res=$this->objFunc->insertarTipoEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoEstado(){
			$this->objFunc=$this->create('MODTipoEstado');	
		$this->res=$this->objFunc->eliminarTipoEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>