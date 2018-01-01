<?php
/**
*@package pXP
*@file gen-ACTAdministrador.php
*@author  (admin)
*@date 29-12-2017 16:10:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAdministrador extends ACTbase{    
			
	function listarAdministrador(){
		$this->objParam->defecto('ordenacion','id_administrador');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAdministrador','listarAdministrador');
		} else{
			$this->objFunc=$this->create('MODAdministrador');
			
			$this->res=$this->objFunc->listarAdministrador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAdministrador(){
		$this->objFunc=$this->create('MODAdministrador');	
		if($this->objParam->insertar('id_administrador')){
			$this->res=$this->objFunc->insertarAdministrador($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAdministrador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAdministrador(){
			$this->objFunc=$this->create('MODAdministrador');	
		$this->res=$this->objFunc->eliminarAdministrador($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>