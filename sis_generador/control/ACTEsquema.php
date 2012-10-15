<?php
class ACTTabla extends ACTbase{    

	function listarEsquema(){		
		
		$this->objFunc=new FuncionesGenerador();	
		$this->res=$this->objFunc->listarEsquema($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	

}

?>