<?php
class ACTTabla extends ACTbase{    

	function listarEsquema(){		
		
		$this->objFunc=$this->create('MODEsquema');	
		$this->res=$this->objFunc->listarEsquema();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	

}

?>