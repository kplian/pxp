<?php
/**
*@package pXP
*@file gen-ACTLibreta.php
*@author  (rac)
*@date 18-06-2012 16:21:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLibreta extends ACTbase{    
			
	function listarLibreta(){
		$this->objParam->defecto('ordenacion','id_libreta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesSeguridad','listarLibreta');
		} else{
			$this->objFunc=new FuncionesSeguridad();	
			$this->res=$this->objFunc->listarLibreta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLibreta(){
		$this->objFunc=new FuncionesSeguridad();	
		if($this->objParam->insertar('id_libreta')){
			$this->res=$this->objFunc->insertarLibreta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLibreta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLibreta(){
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->eliminarLibreta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>