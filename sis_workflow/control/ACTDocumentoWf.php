<?php
/**
*@package pXP
*@file gen-ACTDocumentoWf.php
*@author  (admin)
*@date 15-01-2014 13:52:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDocumentoWf extends ACTbase{    
			
	function listarDocumentoWf(){
		$this->objParam->defecto('ordenacion','id_documento_wf');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDocumentoWf','listarDocumentoWf');
		} else{
			$this->objFunc=$this->create('MODDocumentoWf');
			
			$this->res=$this->objFunc->listarDocumentoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDocumentoWf(){
		$this->objFunc=$this->create('MODDocumentoWf');	
		if($this->objParam->insertar('id_documento_wf')){
			$this->res=$this->objFunc->insertarDocumentoWf($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDocumentoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDocumentoWf(){
			$this->objFunc=$this->create('MODDocumentoWf');	
		$this->res=$this->objFunc->eliminarDocumentoWf($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function subirArchivoWf(){
        $this->objFunc=$this->create('MODDocumentoWf');
        $this->res=$this->objFunc->subirDocumentoWfArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function cambiarMomento(){
        $this->objFunc=$this->create('MODDocumentoWf'); 
        $this->res=$this->objFunc->cambiarMomento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    
			
}

?>