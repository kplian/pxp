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

		if ($this->objParam->getParametro('id_especialidad_nivel') != '') {
			$this->objParam->addFiltro("espcia.id_especialidad_nivel = ". $this->objParam->getParametro('id_especialidad_nivel'));
		}	

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODEspecialidad','listarEspecialidad');
		} else{
			$this->objFunc=$this->create('MODEspecialidad');	
			$this->res=$this->objFunc->listarEspecialidad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEspecialidad(){
		$this->objFunc=$this->create('MODEspecialidad');	
		if($this->objParam->insertar('id_especialidad')){
			$this->res=$this->objFunc->insertarEspecialidad();			
		} else{			
			$this->res=$this->objFunc->modificarEspecialidad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEspecialidad(){
		$this->objFunc=$this->create('MODEspecialidad');	
		$this->res=$this->objFunc->eliminarEspecialidad();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>