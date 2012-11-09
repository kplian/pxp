<?php
/**
*@package pXP
*@file gen-ACTUniConsDet.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsDet extends ACTbase{    
			
	function listarUniConsDet(){
		$this->objParam->defecto('ordenacion','id_uni_cons_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniConsDet');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniConsDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsDet(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_uni_cons_det')){
			$this->res=$this->objFunc->insertarUniConsDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniConsDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsDet(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniConsDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>