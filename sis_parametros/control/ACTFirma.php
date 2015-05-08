<?php
/**
*@package pXP
*@file gen-ACTFirma.php
*@author  (admin)
*@date 11-07-2013 15:32:07
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFirma extends ACTbase{    
			
	function listarFirma(){
		$this->objParam->defecto('ordenacion','id_firma');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_depto')!=''){
            $this->objParam->addFiltro("id_depto = ".$this->objParam->getParametro('id_depto'));    
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODFirma','listarFirma');
		} else{
			$this->objFunc=$this->create('MODFirma');
			
			$this->res=$this->objFunc->listarFirma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFirma(){
		$this->objFunc=$this->create('MODFirma');	
		if($this->objParam->insertar('id_firma')){
			$this->res=$this->objFunc->insertarFirma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFirma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFirma(){
			$this->objFunc=$this->create('MODFirma');	
		$this->res=$this->objFunc->eliminarFirma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>