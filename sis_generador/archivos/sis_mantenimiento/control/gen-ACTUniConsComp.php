<?php
/**
*@package pXP
*@file gen-ACTUniConsComp.php
*@author  (rac)
*@date 09-08-2012 01:38:28
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsComp extends ACTbase{    
			
	function listarUniConsComp(){
		$this->objParam->defecto('ordenacion','id_comp_equipo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniConsComp');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniConsComp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsComp(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_comp_equipo')){
			$this->res=$this->objFunc->insertarUniConsComp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniConsComp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsComp(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniConsComp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>