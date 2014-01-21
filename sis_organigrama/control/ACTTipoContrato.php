<?php
/**
*@package pXP
*@file gen-ACTTipoContrato.php
*@author  (admin)
*@date 14-01-2014 19:23:02
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoContrato extends ACTbase{    
			
	function listarTipoContrato(){
		$this->objParam->defecto('ordenacion','id_tipo_contrato');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoContrato','listarTipoContrato');
		} else{
			$this->objFunc=$this->create('MODTipoContrato');
			
			$this->res=$this->objFunc->listarTipoContrato($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoContrato(){
		$this->objFunc=$this->create('MODTipoContrato');	
		if($this->objParam->insertar('id_tipo_contrato')){
			$this->res=$this->objFunc->insertarTipoContrato($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoContrato($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoContrato(){
			$this->objFunc=$this->create('MODTipoContrato');	
		$this->res=$this->objFunc->eliminarTipoContrato($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>