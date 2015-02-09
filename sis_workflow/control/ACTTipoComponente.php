<?php
/**
*@package pXP
*@file gen-ACTTipoComponente.php
*@author  (admin)
*@date 15-05-2014 19:50:23
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoComponente extends ACTbase{    
			
	function listarTipoComponente(){
		$this->objParam->defecto('ordenacion','id_tipo_componente');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoComponente','listarTipoComponente');
		} else{
			$this->objFunc=$this->create('MODTipoComponente');
			
			$this->res=$this->objFunc->listarTipoComponente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoComponente(){
		$this->objFunc=$this->create('MODTipoComponente');	
		if($this->objParam->insertar('id_tipo_componente')){
			$this->res=$this->objFunc->insertarTipoComponente($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoComponente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoComponente(){
			$this->objFunc=$this->create('MODTipoComponente');	
		$this->res=$this->objFunc->eliminarTipoComponente($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>