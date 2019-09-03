<?php
/**
*@package pXP
*@file gen-ACTReporteColumna.php
*@author  (admin)
*@date 18-01-2014 02:56:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 * #56         02/09/2019      MZM             CREACION
*/

class ACTPieFirmaDet extends ACTbase{    
			
	function listarPieFirmaDet(){
		$this->objParam->defecto('ordenacion','id_pie_firma_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_pie_firma') != '') {
			$this->objParam->addFiltro("piedet.id_pie_firma= ". $this->objParam->getParametro('id_pie_firma'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPieFirmaDet','listarPieFirmaDet');
		} else{
			$this->objFunc=$this->create('MODPieFirmaDet');
			
			$this->res=$this->objFunc->listarPieFirmaDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPieFirmaDet(){
		$this->objFunc=$this->create('MODPieFirmaDet');	
		if($this->objParam->insertar('id_pie_firma_det')){
			$this->res=$this->objFunc->insertarPieFirmaDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPieFirmaDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPieFirmaDet(){
			$this->objFunc=$this->create('MODPieFirmaDet');	
		$this->res=$this->objFunc->eliminarPieFirmaDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>