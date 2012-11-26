<?php
/**
*@package pXP
*@file gen-ACTProyecto.php
*@author  (rac)
*@date 26-10-2011 11:40:13
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProyecto extends ACTbase{    
			
	function listarProyecto(){
		$this->objParam->defecto('ordenacion','id_proyecto');
		
		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODProyecto','listarProyecto');
		} else{
			
			$this->objFunc=$this->create('MODProyecto');	
			$this->res=$this->objFunc->listarProyecto();
			//si la variable todos este habilitada agregamos este registro a la respuesta
			if($this->objParam->getParametro('todos')=='si'){
	
				//crar registro y lo pone en la primera posicion de la respuesta
				$arr = array("id_proyecto" => "TODOS", 'nombre_proyecto' => "TODOS");
				$this->res->addRecDatos($arr);
				
				
			}
			
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
		
	}
				
	function insertarProyecto(){
		$this->objFunc=$this->create('MODProyecto');
		if($this->objParam->insertar('id_proyecto')){
			$this->res=$this->objFunc->insertarProyecto();			
		} else{			
			$this->res=$this->objFunc->modificarProyecto();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProyecto(){
		$this->objFunc=$this->create('MODProyecto');	
		$this->res=$this->objFunc->eliminarProyecto();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>