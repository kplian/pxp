<?php
/**
*@package pXP
*@file gen-ACTEp.php
*@author  (w)
*@date 18-10-2011 02:09:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEp extends ACTbase{    
			
	function listarEp(){
		$this->objParam->defecto('ordenacion','id_ep');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=$this->create('MODEp');	
		$this->res=$this->objFunc->listarEp();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEp(){
		$this->objFunc=$this->create('MODEp');	
		if($this->objParam->insertar('id_ep')){
			$this->res=$this->objFunc->insertarEp();			
		} else{			
			$this->res=$this->objFunc->modificarEp();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEp(){
		$this->objFunc=$this->create('MODEp');	
		$this->res=$this->objFunc->eliminarEp();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>