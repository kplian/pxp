<?php
/**
*@package pXP
*@file gen-ACTTipoDocumento.php
*@author  (admin)
*@date 14-01-2014 17:43:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoDocumento extends ACTbase{    
			
	function listarTipoDocumento(){
		            
		$this->objParam->defecto('ordenacion','id_tipo_documento');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("tipdw.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));    
        }
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoDocumento','listarTipoDocumento');
		} else{
			$this->objFunc=$this->create('MODTipoDocumento');
			
			$this->res=$this->objFunc->listarTipoDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoDocumento(){
		$this->objFunc=$this->create('MODTipoDocumento');	
		if($this->objParam->insertar('id_tipo_documento')){
			$this->res=$this->objFunc->insertarTipoDocumento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoDocumento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoDocumento(){
			$this->objFunc=$this->create('MODTipoDocumento');	
		$this->res=$this->objFunc->eliminarTipoDocumento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>