<?php
/**
*@package pXP
*@file gen-ACTEspecialidadNivel.php
*@author  (admin)
*@date 26-08-2012 00:05:28
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEspecialidadNivel extends ACTbase{    
			
	function listarEspecialidadNivel(){
		$this->objParam->defecto('ordenacion','id_especialidad_nivel');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesRecursosHumanos','listarEspecialidadNivel');
		} else{
			$this->objFunc=new FuncionesRecursosHumanos();	
			$this->res=$this->objFunc->listarEspecialidadNivel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEspecialidadNivel(){
		$this->objFunc=new FuncionesRecursosHumanos();	
		if($this->objParam->insertar('id_especialidad_nivel')){
			$this->res=$this->objFunc->insertarEspecialidadNivel($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEspecialidadNivel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEspecialidadNivel(){
		$this->objFunc=new FuncionesRecursosHumanos();	
		$this->res=$this->objFunc->eliminarEspecialidadNivel($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>