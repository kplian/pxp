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
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODEspecialidadNivel','listarEspecialidadNivel');
		} else{
			$this->objFunc=$this->create('MODEspecialidadNivel');	
			$this->res=$this->objFunc->listarEspecialidadNivel();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEspecialidadNivel(){
		$this->objFunc=$this->create('MODEspecialidadNivel');	
		if($this->objParam->insertar('id_especialidad_nivel')){
			$this->res=$this->objFunc->insertarEspecialidadNivel();			
		} else{			
			$this->res=$this->objFunc->modificarEspecialidadNivel();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEspecialidadNivel(){
		$this->objFunc=$this->create('MODEspecialidadNivel');	
		$this->res=$this->objFunc->eliminarEspecialidadNivel();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>