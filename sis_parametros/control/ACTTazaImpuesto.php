<?php
/**
*@package pXP
*@file gen-ACTTazaImpuesto.php
*@author  (mguerra)
*@date 25-07-2019 19:23:20
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTazaImpuesto extends ACTbase{    
			
	function listarTazaImpuesto(){
		$this->objParam->defecto('ordenacion','id_taza_impuesto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTazaImpuesto','listarTazaImpuesto');
		} else{
			$this->objFunc=$this->create('MODTazaImpuesto');
			
			$this->res=$this->objFunc->listarTazaImpuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTazaImpuesto(){
		$this->objFunc=$this->create('MODTazaImpuesto');	
		if($this->objParam->insertar('id_taza_impuesto')){
			$this->res=$this->objFunc->insertarTazaImpuesto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTazaImpuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTazaImpuesto(){
			$this->objFunc=$this->create('MODTazaImpuesto');	
		$this->res=$this->objFunc->eliminarTazaImpuesto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>