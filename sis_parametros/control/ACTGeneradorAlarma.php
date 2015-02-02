<?php
/**
*@package pXP
*@file gen-ACTGeneradorAlarma.php
*@author  (admin)
*@date 26-04-2013 10:31:19
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGeneradorAlarma extends ACTbase{    
			
	function listarGeneradorAlarma(){
		$this->objParam->defecto('ordenacion','id_generador_alarma');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGeneradorAlarma','listarGeneradorAlarma');
		} else{
			$this->objFunc=$this->create('MODGeneradorAlarma');
			
			$this->res=$this->objFunc->listarGeneradorAlarma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGeneradorAlarma(){
		$this->objFunc=$this->create('MODGeneradorAlarma');	
		if($this->objParam->insertar('id_generador_alarma')){
			$this->res=$this->objFunc->insertarGeneradorAlarma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGeneradorAlarma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGeneradorAlarma(){
			$this->objFunc=$this->create('MODGeneradorAlarma');	
		$this->res=$this->objFunc->eliminarGeneradorAlarma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>