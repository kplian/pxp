<?php
/**
*@package pXP
*@file ACTPrograma.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 23:53:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPrograma extends ACTbase{    
			
	function listarPrograma(){
		$this->objParam->defecto('ordenacion','id_programa');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPrograma','listarPrograma');
		} else{
			$this->objFunc=$this->create('MODPrograma');
			
			$this->res=$this->objFunc->listarPrograma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPrograma(){
		$this->objFunc=$this->create('MODPrograma');	
		if($this->objParam->insertar('id_programa')){
			$this->res=$this->objFunc->insertarPrograma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPrograma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPrograma(){
			$this->objFunc=$this->create('MODPrograma');	
		$this->res=$this->objFunc->eliminarPrograma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>