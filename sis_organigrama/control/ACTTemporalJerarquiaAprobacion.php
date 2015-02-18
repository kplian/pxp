<?php
/**
*@package pXP
*@file gen-ACTTemporalJerarquiaAprobacion.php
*@author  (admin)
*@date 13-01-2014 23:54:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTemporalJerarquiaAprobacion extends ACTbase{    
			
	function listarTemporalJerarquiaAprobacion(){
		$this->objParam->defecto('ordenacion','id_temporal_jerarquia_aprobacion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTemporalJerarquiaAprobacion','listarTemporalJerarquiaAprobacion');
		} else{
			$this->objFunc=$this->create('MODTemporalJerarquiaAprobacion');
			
			$this->res=$this->objFunc->listarTemporalJerarquiaAprobacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTemporalJerarquiaAprobacion(){
		$this->objFunc=$this->create('MODTemporalJerarquiaAprobacion');	
		if($this->objParam->insertar('id_temporal_jerarquia_aprobacion')){
			$this->res=$this->objFunc->insertarTemporalJerarquiaAprobacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTemporalJerarquiaAprobacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTemporalJerarquiaAprobacion(){
			$this->objFunc=$this->create('MODTemporalJerarquiaAprobacion');	
		$this->res=$this->objFunc->eliminarTemporalJerarquiaAprobacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>