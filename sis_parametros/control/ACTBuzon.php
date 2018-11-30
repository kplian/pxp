<?php
/**
*@package pXP
*@file gen-ACTBuzon.php
*@author  (eddy.gutierrez)
*@date 25-07-2018 23:43:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTBuzon extends ACTbase{    
			
	function listarBuzon(){
		$this->objParam->defecto('ordenacion','id_buzon');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODBuzon','listarBuzon');
		} else{
			$this->objFunc=$this->create('MODBuzon');
			
			$this->res=$this->objFunc->listarBuzon($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarBuzon(){
		$this->objFunc=$this->create('MODBuzon');	
		if($this->objParam->insertar('id_buzon')){
			$this->res=$this->objFunc->insertarBuzon($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarBuzon($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarBuzon(){
			$this->objFunc=$this->create('MODBuzon');	
		$this->res=$this->objFunc->eliminarBuzon($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>