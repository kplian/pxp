<?php
/**
*@package pXP
*@file gen-ACTConfLectorMobileDetalle.php
*@author  (admin)
*@date 27-02-2017 01:07:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConfLectorMobileDetalle extends ACTbase{    
			
	function listarConfLectorMobileDetalle(){
		$this->objParam->defecto('ordenacion','id_conf_lector_mobile_detalle');

		$this->objParam->defecto('dir_ordenacion','asc');

		if($this->objParam->getParametro('id_conf_lector_mobile')!=''){
			$this->objParam->addFiltro("conflem.id_conf_lector_mobile =''".$this->objParam->getParametro('id_conf_lector_mobile')."''");
		}
		if($this->objParam->getParametro('conf_lector_mobile')!=''){
			$this->objParam->addFiltro("lector.nombre =''".$this->objParam->getParametro('conf_lector_mobile')."''");
		}

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConfLectorMobileDetalle','listarConfLectorMobileDetalle');
		} else{
			$this->objFunc=$this->create('MODConfLectorMobileDetalle');
			
			$this->res=$this->objFunc->listarConfLectorMobileDetalle($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConfLectorMobileDetalle(){
		$this->objFunc=$this->create('MODConfLectorMobileDetalle');	
		if($this->objParam->insertar('id_conf_lector_mobile_detalle')){
			$this->res=$this->objFunc->insertarConfLectorMobileDetalle($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConfLectorMobileDetalle($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConfLectorMobileDetalle(){
			$this->objFunc=$this->create('MODConfLectorMobileDetalle');	
		$this->res=$this->objFunc->eliminarConfLectorMobileDetalle($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>