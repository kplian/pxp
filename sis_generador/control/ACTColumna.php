<?php
class ACTColumna extends ACTbase{    

	function listarColumna(){		
		$this->objParam->defecto('ordenacion','id_columna');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tabla')!=''){
			$this->objParam->addFiltro("id_tabla=".$this->objParam->getParametro('id_tabla'));
		}
		
		$this->objFunc=$this->create('MODColumna');	
		$this->res=$this->objFunc->listarColumna();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarColumna(){
		$this->objFunc=$this->create('MODColumna');
		if($this->objParam->insertar('id_columna')){
			$this->res=$this->objFunc->insertarColumna();			
		}
		else{			
			$this->res=$this->objFunc->modificarColumna();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function eliminarColumna(){
		$this->objFunc=$this->create('MODColumna');	
		$this->res=$this->objFunc->eliminarColumna();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarDatosColumna(){		
		$this->objParam->defecto('ordenacion','attnum');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		$this->objFunc=$this->create('MODColumna');	
		$this->res=$this->objFunc->listarDatosColumna();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>