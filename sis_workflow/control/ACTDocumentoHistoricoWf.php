<?php
/**
*@package pXP
*@file gen-ACTDocumentoHistoricoWf.php
*@author  (admin)
*@date 04-12-2014 20:11:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDocumentoHistoricoWf extends ACTbase{    
			
	function listarDocumentoHistoricoWf(){
		$this->objParam->defecto('ordenacion','id_documento_historico_wf');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_documento_wf')!=''){
            $this->objParam->addFiltro("dhw.id_documento = ".$this->objParam->getParametro('id_documento_wf'));    
        }
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDocumentoHistoricoWf','listarDocumentoHistoricoWf');
		} else{
			$this->objFunc=$this->create('MODDocumentoHistoricoWf');
			
			$this->res=$this->objFunc->listarDocumentoHistoricoWf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		
}
?>