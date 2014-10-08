<?php
/**
*@package pXP
*@file gen-ACTDocumentoCategoriaClasificacion.php
*@author  (gsarmiento)
*@date 06-10-2014 16:00:33
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDocumentoCategoriaClasificacion extends ACTbase{    
			
	function listarDocumentoCategoriaClasificacion(){
		$this->objParam->defecto('ordenacion','id_documento_categoria_clasificacion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDocumentoCategoriaClasificacion','listarDocumentoCategoriaClasificacion');
		} else{
			$this->objFunc=$this->create('MODDocumentoCategoriaClasificacion');
			
			$this->res=$this->objFunc->listarDocumentoCategoriaClasificacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDocumentoCategoriaClasificacion(){
		$this->objFunc=$this->create('MODDocumentoCategoriaClasificacion');	
		if($this->objParam->insertar('id_documento_categoria_clasificacion')){
			$this->res=$this->objFunc->insertarDocumentoCategoriaClasificacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDocumentoCategoriaClasificacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDocumentoCategoriaClasificacion(){
			$this->objFunc=$this->create('MODDocumentoCategoriaClasificacion');	
		$this->res=$this->objFunc->eliminarDocumentoCategoriaClasificacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>