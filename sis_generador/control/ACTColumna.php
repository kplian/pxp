<?php
class ACTColumna extends ACTbase{    

	function listarColumna(){		
		$this->objParam->defecto('ordenacion','id_columna');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tabla')!=''){
			$this->objParam->addFiltro("id_tabla=".$this->objParam->getParametro('id_tabla'));
		}
		
		$this->objFunc=new FuncionesGenerador();	
		$this->res=$this->objFunc->listarColumna($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarColumna(){
		$this->objFunc=new FuncionesGenerador();
		if($this->objParam->insertar('id_columna')){
			$this->res=$this->objFunc->insertarColumna($this->objParam);			
		}
		else{			
			$this->res=$this->objFunc->modificarColumna($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function eliminarColumna(){
		$this->objFunc=new FuncionesGenerador();	
		$this->res=$this->objFunc->eliminarColumna($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarDatosColumna(){		
		$this->objParam->defecto('ordenacion','attnum');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		$this->objFunc=new FuncionesGenerador();	
		$this->res=$this->objFunc->listarDatosColumna($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>