<?php
/**
*@package pXP
*@file gen-ACTPieFirma.php
*@author  (egutierrez)
*@date 07-08-2019 15:43:48
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
ISSUE       FECHA           AUTHOR          DESCRIPCION

#56         02/09/2019      MZM             CREACION
 */

class ACTPieFirma extends ACTbase{    
			
	function listarPieFirma(){
		$this->objParam->defecto('ordenacion','id_pie_firma');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPieFirma','listarPieFirma');
		} else{
			$this->objFunc=$this->create('MODPieFirma');
			
			$this->res=$this->objFunc->listarPieFirma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPieFirma(){
		$this->objFunc=$this->create('MODPieFirma');	
		if($this->objParam->insertar('id_pie_firma')){
			$this->res=$this->objFunc->insertarPieFirma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPieFirma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPieFirma(){
			$this->objFunc=$this->create('MODPieFirma');	
		$this->res=$this->objFunc->eliminarPieFirma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>