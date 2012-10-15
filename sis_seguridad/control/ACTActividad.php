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
					
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->listarActividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarActividad(){
		$this->objFunc=new FuncionesSeguridad();	
		if($this->objParam->insertar('id_actividad')){
			$this->res=$this->objFunc->insertarActividad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarActividad(){
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->eliminarActividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>