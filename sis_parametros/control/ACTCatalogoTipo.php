<?php
/**
*@package pXP
*@file gen-ACTCatalogoTipo.php
*@author  (admin)
*@date 27-11-2012 23:32:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCatalogoTipo extends ACTbase{    
			
	function listarCatalogoTipo(){
		$this->objParam->defecto('ordenacion','id_catalogo_tipo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_subsistema')!=''){
			$this->objParam->addFiltro("pacati.id_subsistema = ".$this->objParam->getParametro('id_subsistema'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarCatalogoTipo');
		} else{
			$this->objFunc=$this->create('MODCatalogoTipo');	
			$this->res=$this->objFunc->listarCatalogoTipo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCatalogoTipo(){
		$this->objFunc=$this->create('MODCatalogoTipo');	
		if($this->objParam->insertar('id_catalogo_tipo')){
			$this->res=$this->objFunc->insertarCatalogoTipo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCatalogoTipo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCatalogoTipo(){
		$this->objFunc=$this->create('MODCatalogoTipo');	
		$this->res=$this->objFunc->eliminarCatalogoTipo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>