<?php
/**
*@package pXP
*@file gen-ACTConfLectorMobile.php
*@author  (admin)
*@date 27-02-2017 01:01:56
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConfLectorMobile extends ACTbase{    
			
	function listarConfLectorMobile(){
		$this->objParam->defecto('ordenacion','id_conf_lector_mobile');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConfLectorMobile','listarConfLectorMobile');
		} else{
			$this->objFunc=$this->create('MODConfLectorMobile');
			
			$this->res=$this->objFunc->listarConfLectorMobile($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConfLectorMobile(){
		$this->objFunc=$this->create('MODConfLectorMobile');	
		if($this->objParam->insertar('id_conf_lector_mobile')){
			$this->res=$this->objFunc->insertarConfLectorMobile($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConfLectorMobile($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConfLectorMobile(){
			$this->objFunc=$this->create('MODConfLectorMobile');	
		$this->res=$this->objFunc->eliminarConfLectorMobile($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function prueba(){
			$this->objFunc=$this->create('MODConfLectorMobile');
		$this->res=$this->objFunc->prueba($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>