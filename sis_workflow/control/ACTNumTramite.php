<?php
/**
*@package pXP
*@file gen-ACTNumTramite.php
*@author  (FRH)
*@date 19-02-2013 13:51:54
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTNumTramite extends ACTbase{    
			
	function listarNumTramite(){
		$this->objParam->defecto('ordenacion','id_num_tramite');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_proceso_macro')!=''){
			$this->objParam->addFiltro("prom.id_proceso_macro = ".$this->objParam->getParametro('id_proceso_macro'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODNumTramite','listarNumTramite');
		} else{
			$this->objFunc=$this->create('MODNumTramite');
			
			$this->res=$this->objFunc->listarNumTramite($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarNumTramite(){
		$this->objFunc=$this->create('MODNumTramite');	
		if($this->objParam->insertar('id_num_tramite')){
			$this->res=$this->objFunc->insertarNumTramite($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarNumTramite($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarNumTramite(){
			$this->objFunc=$this->create('MODNumTramite');	
		$this->res=$this->objFunc->eliminarNumTramite($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>