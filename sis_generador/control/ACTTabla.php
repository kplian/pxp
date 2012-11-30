<?php
class ACTTabla extends ACTbase{
	
	


	function listarTabla(){		
		$this->objParam->defecto('ordenacion','id_tabla');
		$this->objParam->defecto('dir_ordenacion','asc');
		
			if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODTabla','listarTabla');
		}
		else {
			$this->objFunc=$this->create('MODTabla');	
		    $this->res=$this->objFunc->listarTabla();
		}
	
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarTablaCombo(){		
		if($this->objParam->getParametro('esquema')!=''){
			$this->objParam->addFiltro("n.nspname=''".strtolower($this->objParam->getParametro('esquema'))."''");
		}
		$this->objFunc=$this->create('MODTabla');		
		$this->res=$this->objFunc->listarTablaCombo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarTabla(){
		$this->objFunc=$this->create('MODTabla');
		if($this->objParam->insertar('id_tabla')){
			$this->res=$this->objFunc->insertarTabla();			
		}
		else{			
			$this->res=$this->objFunc->modificarTabla();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function eliminarTabla(){
		$this->objFunc=$this->create('MODTabla');	
		$this->res=$this->objFunc->eliminarTabla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>