<?php
/**
*@package pXP
*@file gen-ACTDocumentoFiscal.php
*@author  (admin)
*@date 03-04-2013 15:48:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDocumentoFiscal extends ACTbase{    
			
	function listarDocumentoFiscal(){
		$this->objParam->defecto('ordenacion','id_documento_fiscal');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDocumentoFiscal','listarDocumentoFiscal');
		} else{
			$this->objFunc=$this->create('MODDocumentoFiscal');
			
			$this->res=$this->objFunc->listarDocumentoFiscal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDocumentoFiscal(){
		$this->objFunc=$this->create('MODDocumentoFiscal');	
		if($this->objParam->insertar('id_documento_fiscal')){
			$this->res=$this->objFunc->insertarDocumentoFiscal($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDocumentoFiscal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDocumentoFiscal(){
		$this->objFunc=$this->create('MODDocumentoFiscal');	
		$this->res=$this->objFunc->eliminarDocumentoFiscal($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function obtenerRazonSocialxNIT(){
		$this->objFunc=$this->create('MODDocumentoFiscal');	
		$this->res=$this->objFunc->obtenerRazonSocialxNIT($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>