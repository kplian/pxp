<?php
/**
*@package pXP
*@file gen-ACTTipoDocumentoEstado.php
*@author  (admin)
*@date 15-01-2014 03:12:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoDocumentoEstado extends ACTbase{    
			
	function listarTipoDocumentoEstado(){
		$this->objParam->defecto('ordenacion','id_tipo_documento_estado');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tipo_documento')!=''){
            $this->objParam->addFiltro("des.id_tipo_documento = ".$this->objParam->getParametro('id_tipo_documento'));    
        }
        
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoDocumentoEstado','listarTipoDocumentoEstado');
		} else{
			$this->objFunc=$this->create('MODTipoDocumentoEstado');
			
			$this->res=$this->objFunc->listarTipoDocumentoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoDocumentoEstado(){
		$this->objFunc=$this->create('MODTipoDocumentoEstado');	
		if($this->objParam->insertar('id_tipo_documento_estado')){
			$this->res=$this->objFunc->insertarTipoDocumentoEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoDocumentoEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoDocumentoEstado(){
			$this->objFunc=$this->create('MODTipoDocumentoEstado');	
		$this->res=$this->objFunc->eliminarTipoDocumentoEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>