<?php
/**
*@package pXP
*@file gen-ACTNivelOrganizacional.php
*@author  (admin)
*@date 13-01-2014 23:54:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTNivelOrganizacional extends ACTbase{    
			
	function listarNivelOrganizacional(){
		$this->objParam->defecto('ordenacion','id_nivel_organizacional');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODNivelOrganizacional','listarNivelOrganizacional');
		} else{
			$this->objFunc=$this->create('MODNivelOrganizacional');
			
			$this->res=$this->objFunc->listarNivelOrganizacional($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarNivelOrganizacional(){
		$this->objFunc=$this->create('MODNivelOrganizacional');	
		if($this->objParam->insertar('id_nivel_organizacional')){
			$this->res=$this->objFunc->insertarNivelOrganizacional($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarNivelOrganizacional($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarNivelOrganizacional(){
			$this->objFunc=$this->create('MODNivelOrganizacional');	
		$this->res=$this->objFunc->eliminarNivelOrganizacional($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>