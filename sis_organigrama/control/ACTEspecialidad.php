<?php
/**
*@package pXP
*@file gen-ACTEspecialidad.php
*@author  (admin)
*@date 17-08-2012 17:29:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEspecialidad extends ACTbase{    
			
	function listarEspecialidad(){
		$this->objParam->defecto('ordenacion','id_especialidad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesRecursosHumanos','listarEspecialidad');
		} else{
			$this->objFunc=new FuncionesRecursosHumanos();	
			$this->res=$this->objFunc->listarEspecialidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEspecialidad(){
		$this->objFunc=new FuncionesRecursosHumanos();	
		if($this->objParam->insertar('id_especialidad')){
			$this->res=$this->objFunc->insertarEspecialidad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEspecialidad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEspecialidad(){
		$this->objFunc=new FuncionesRecursosHumanos();	
		$this->res=$this->objFunc->eliminarEspecialidad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>