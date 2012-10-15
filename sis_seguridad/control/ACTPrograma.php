<?php
/**
*@package pXP
*@file gen-ACTPrograma.php
*@author  (w)
*@date 13-08-2011 16:32:52
*@description Clase que recibe los parámetros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPrograma extends ACTbase{    
			
	function listarPrograma(){
		$this->objParam->defecto('ordenacion','id_programa');

		$this->objParam->defecto('dir_ordenacion','asc');
					
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->listarPrograma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPrograma(){
		$this->objFunc=new FuncionesSeguridad();	
		if($this->objParam->insertar('id_programa')){
			$this->res=$this->objFunc->insertarPrograma($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPrograma($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPrograma(){
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->eliminarPrograma($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>