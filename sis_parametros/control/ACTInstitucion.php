<?php
/**
*@package pXP
*@file gen-ACTInstitucion.php
*@author  (gvelasquez)
*@date 21-09-2011 10:50:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInstitucion extends ACTbase{    
			
	function listarInstitucion(){
		$this->objParam->defecto('ordenacion','id_institucion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarInstitucion');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarInstitucion($this->objParam);
		}
			$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
				
	function insertarInstitucion(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_institucion')){
			$this->res=$this->objFunc->insertarInstitucion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInstitucion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstitucion(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarInstitucion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>