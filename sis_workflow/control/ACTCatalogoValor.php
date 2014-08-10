<?php
/**
*@package pXP
*@file gen-ACTCatalogoValor.php
*@author  (admin)
*@date 16-05-2014 22:55:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatalogoValor extends ACTbase{    
			
	function listarCatalogoValor(){
		$this->objParam->defecto('ordenacion','id_catalogo_valor');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCatalogoValor','listarCatalogoValor');
		} else{
			$this->objFunc=$this->create('MODCatalogoValor');
			
			$this->res=$this->objFunc->listarCatalogoValor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatalogoValor(){
		$this->objFunc=$this->create('MODCatalogoValor');	
		if($this->objParam->insertar('id_catalogo_valor')){
			$this->res=$this->objFunc->insertarCatalogoValor($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatalogoValor($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatalogoValor(){
			$this->objFunc=$this->create('MODCatalogoValor');	
		$this->res=$this->objFunc->eliminarCatalogoValor($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>