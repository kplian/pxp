<?php
/**
*@package pXP
*@file gen-ACTProyecto.php
*@author  (w)
*@date 17-10-2011 06:35:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProyecto extends ACTbase{    
			
	function listarProyecto(){
		$this->objParam->defecto('ordenacion','id_proyecto');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=$this->create('MODProyecto');	
		$this->res=$this->objFunc->listarProyecto();
		$this->res->imprimirRespuesta($this->res->generarJson());
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