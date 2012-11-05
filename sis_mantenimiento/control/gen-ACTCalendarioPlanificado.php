<?php
/**
*@package pXP
*@file gen-ACTCalendarioPlanificado.php
*@author  (admin)
*@date 02-11-2012 15:11:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCalendarioPlanificado extends ACTbase{    
			
	function listarCalendarioPlanificado(){
		$this->objParam->defecto('ordenacion','id_calendario_planificado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarCalendarioPlanificado');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarCalendarioPlanificado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCalendarioPlanificado(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_calendario_planificado')){
			$this->res=$this->objFunc->insertarCalendarioPlanificado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCalendarioPlanificado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCalendarioPlanificado(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarCalendarioPlanificado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>