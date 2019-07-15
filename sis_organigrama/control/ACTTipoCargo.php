<?php
/**
*@package pXP
*@file gen-ACTTipoCargo.php
*@author  (rarteaga)
*@date 15-07-2019 19:39:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoCargo extends ACTbase{    
			
	function listarTipoCargo(){
		$this->objParam->defecto('ordenacion','id_tipo_cargo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCargo','listarTipoCargo');
		} else{
			$this->objFunc=$this->create('MODTipoCargo');
			
			$this->res=$this->objFunc->listarTipoCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoCargo(){
		$this->objFunc=$this->create('MODTipoCargo');	
		if($this->objParam->insertar('id_tipo_cargo')){
			$this->res=$this->objFunc->insertarTipoCargo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoCargo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoCargo(){
			$this->objFunc=$this->create('MODTipoCargo');	
		$this->res=$this->objFunc->eliminarTipoCargo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>