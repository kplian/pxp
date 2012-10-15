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
					
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->listarProyecto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProyecto(){
		$this->objFunc=new FuncionesSeguridad();	
		if($this->objParam->insertar('id_proyecto')){
			$this->res=$this->objFunc->insertarProyecto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProyecto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProyecto(){
		$this->objFunc=new FuncionesSeguridad();	
		$this->res=$this->objFunc->eliminarProyecto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>