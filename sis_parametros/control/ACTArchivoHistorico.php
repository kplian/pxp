<?php
/**
*@package pXP
*@file gen-ACTArchivoHistorico.php
*@author  (admin)
*@date 07-12-2016 21:54:02
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTArchivoHistorico extends ACTbase{    
			
	function listarArchivoHistorico(){
		$this->objParam->defecto('ordenacion','id_archivo_historico');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODArchivoHistorico','listarArchivoHistorico');
		} else{
			$this->objFunc=$this->create('MODArchivoHistorico');
			
			$this->res=$this->objFunc->listarArchivoHistorico($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarArchivoHistorico(){
		$this->objFunc=$this->create('MODArchivoHistorico');	
		if($this->objParam->insertar('id_archivo_historico')){
			$this->res=$this->objFunc->insertarArchivoHistorico($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarArchivoHistorico($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarArchivoHistorico(){
			$this->objFunc=$this->create('MODArchivoHistorico');	
		$this->res=$this->objFunc->eliminarArchivoHistorico($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>