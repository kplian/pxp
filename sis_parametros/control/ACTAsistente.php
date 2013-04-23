<?php
/**
*@package pXP
*@file gen-ACTAsistente.php
*@author  (admin)
*@date 05-04-2013 14:02:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAsistente extends ACTbase{    
			
	function listarAsistente(){
		$this->objParam->defecto('ordenacion','id_asistente');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAsistente','listarAsistente');
		} else{
			$this->objFunc=$this->create('MODAsistente');
			
			$this->res=$this->objFunc->listarAsistente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAsistente(){
		$this->objFunc=$this->create('MODAsistente');	
		if($this->objParam->insertar('id_asistente')){
			$this->res=$this->objFunc->insertarAsistente($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAsistente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAsistente(){
			$this->objFunc=$this->create('MODAsistente');	
		$this->res=$this->objFunc->eliminarAsistente($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>