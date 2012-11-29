<?php
/**
*@package pXP
*@file gen-ACTActividad.php
*@author  (w)
*@date 17-10-2011 06:48:53
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTActividad extends ACTbase{    
			
	function listarActividad(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=$this->create('MODActividad');	
		$this->res=$this->objFunc->listarActividad();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarActividad(){
		$this->objFunc=$this->create('MODActividad');	
		if($this->objParam->insertar('id_actividad')){
			$this->res=$this->objFunc->insertarActividad();			
		} else{			
			$this->res=$this->objFunc->modificarActividad();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarActividad(){
		$this->objFunc=$this->create('MODActividad');	
		$this->res=$this->objFunc->eliminarActividad();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>