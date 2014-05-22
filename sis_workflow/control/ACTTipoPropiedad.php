<?php
/**
*@package pXP
*@file gen-ACTTipoPropiedad.php
*@author  (admin)
*@date 15-05-2014 20:38:59
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoPropiedad extends ACTbase{    
			
	function listarTipoPropiedad(){
		$this->objParam->defecto('ordenacion','id_tipo_propiedad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoPropiedad','listarTipoPropiedad');
		} else{
			$this->objFunc=$this->create('MODTipoPropiedad');
			
			$this->res=$this->objFunc->listarTipoPropiedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoPropiedad(){
		$this->objFunc=$this->create('MODTipoPropiedad');	
		if($this->objParam->insertar('id_tipo_propiedad')){
			$this->res=$this->objFunc->insertarTipoPropiedad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoPropiedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoPropiedad(){
			$this->objFunc=$this->create('MODTipoPropiedad');	
		$this->res=$this->objFunc->eliminarTipoPropiedad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>