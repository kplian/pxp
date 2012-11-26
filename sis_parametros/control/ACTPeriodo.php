<?php
class ACTPeriodo extends ACTbase{    

	function listarPeriodo(){

		// parametros de ordenacion por defecto
		$this->objParam->defecto('ordenacion','periodo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam, $this);
			$this->res=$this->objReporte->generarReporteListado('MODPeriodo','listarPeriodo');
		}
		else {
			$this->objFunSeguridad=$this->create('MODPeriodo');
			//ejecuta el metodo de lista personas a travez de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->listarPeriodo();
			
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
	
	function guardarPeriodo(){
	
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODPeriodo');
		
		//preguntamos si se debe insertar o modificar 
		if($this->objParam->insertar('id_periodo')){

			//ejecuta el metodo de insertar de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->insertarPeriodo();			
		}
		else{	
			//ejecuta el metodo de modificar persona de la clase MODPersona a travez 
			//de la intefaz objetoFunSeguridad 
			$this->res=$this->objFunSeguridad->modificarPeriodo();
		}
		
		//imprime respuesta en formato JSON
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
			
	function eliminarPeriodo(){
		
		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		$this->objFunSeguridad=$this->create('MODPeriodo');	
		$this->res=$this->objFunSeguridad->eliminarPeriodo();
		$this->res->imprimirRespuesta($this->res->generarJson());

	}
	
	

}

?>