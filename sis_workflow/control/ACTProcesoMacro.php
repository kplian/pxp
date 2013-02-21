<?php
/**
*@package pXP
*@file gen-ACTProcesoMacro.php
*@author  (FRH)
*@date 19-02-2013 13:51:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProcesoMacro extends ACTbase{    
			
	function listarProcesoMacro(){
		$this->objParam->defecto('ordenacion','id_proceso_macro');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProcesoMacro','listarProcesoMacro');
		} else{
			$this->objFunc=$this->create('MODProcesoMacro');
			
			$this->res=$this->objFunc->listarProcesoMacro($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProcesoMacro(){
		$this->objFunc=$this->create('MODProcesoMacro');	
		if($this->objParam->insertar('id_proceso_macro')){
			$this->res=$this->objFunc->insertarProcesoMacro($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProcesoMacro($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProcesoMacro(){
			$this->objFunc=$this->create('MODProcesoMacro');	
		$this->res=$this->objFunc->eliminarProcesoMacro($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>