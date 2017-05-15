<?php
/**
*@package pXP
*@file gen-ACTLogGeneracionFirmaCorreo.php
*@author  (admin)
*@date 06-03-2017 21:21:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLogGeneracionFirmaCorreo extends ACTbase{    
			
	function listarLogGeneracionFirmaCorreo(){
		$this->objParam->defecto('ordenacion','id_log_generacion_firma_correo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODLogGeneracionFirmaCorreo','listarLogGeneracionFirmaCorreo');
		} else{
			$this->objFunc=$this->create('MODLogGeneracionFirmaCorreo');
			
			$this->res=$this->objFunc->listarLogGeneracionFirmaCorreo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLogGeneracionFirmaCorreo(){
		$this->objFunc=$this->create('MODLogGeneracionFirmaCorreo');	
		if($this->objParam->insertar('id_log_generacion_firma_correo')){
			$this->res=$this->objFunc->insertarLogGeneracionFirmaCorreo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLogGeneracionFirmaCorreo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLogGeneracionFirmaCorreo(){
			$this->objFunc=$this->create('MODLogGeneracionFirmaCorreo');	
		$this->res=$this->objFunc->eliminarLogGeneracionFirmaCorreo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>