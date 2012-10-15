<?php
class ACTTabla extends ACTbase{
	
	


	function listarTabla(){		
		$this->objParam->defecto('ordenacion','id_tabla');
		$this->objParam->defecto('dir_ordenacion','asc');
		
			if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesGenerador','listarTabla');
		}
		else {
			$this->objFunc=new FuncionesGenerador();	
		    $this->res=$this->objFunc->listarTabla($this->objParam);
		}
	
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarTablaCombo(){		
				
		$this->objFunc=new FuncionesGenerador();	
		if($this->objParam->getParametro('esquema')!=''){
			$this->objParam->addFiltro("n.nspname=''".strtolower($this->objParam->getParametro('esquema'))."''");
		}
		
		$this->res=$this->objFunc->listarTablaCombo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarTabla(){
		$this->objFunc=new FuncionesGenerador();
		if($this->objParam->insertar('id_tabla')){
			$this->res=$this->objFunc->insertarTabla($this->objParam);			
		}
		else{			
			$this->res=$this->objFunc->modificarTabla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function eliminarTabla(){
		$this->objFunc=new FuncionesGenerador();	
		$this->res=$this->objFunc->eliminarTabla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>