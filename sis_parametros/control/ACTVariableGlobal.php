<?php
/**
*@package pXP
*@file gen-ACTVariableGlobal.php
*@author  (jrivera)
*@date 16-08-2012 23:48:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTVariableGlobal extends ACTbase{    
			
	function listarVariableGlobal(){
		$this->objParam->defecto('ordenacion','variable');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODVariableGlobal','listarVariableGlobal');
		} else{
			$this->objFunc=$this->create('MODVariableGlobal');
			$this->res=$this->objFunc->listarVariableGlobal();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarVariableGlobal(){
		$this->objFunc=$this->create('MODVariableGlobal');	
		if($this->objParam->insertar('id_variable_global')){
			$this->res=$this->objFunc->insertarVariableGlobal();			
		} else{			
			$this->res=$this->objFunc->modificarVariableGlobal();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarVariableGlobal(){
		$this->objFunc=$this->create('MODVariableGlobal');	
		$this->res=$this->objFunc->eliminarVariableGlobal();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>