<?php
/***
 Nombre: ACTRegional.php
 Proposito: Clase de Control para recibir los parametros enviados por los archivos
 de la Vista para envio y ejecucion de los metodos del Modelo referidas a la tabla tregional 
 Autor:	Kplian
 Fecha:	01/07/2010
 */
class ACTRegional extends ACTbase{    

	function listarRegional(){		
		$this->objParam->defecto('ordenacion','denominacion');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte=new Reporte($this->objParam);
			$this->res=$this->objReporte->generarReporteListado('FuncionesSeguridad','listarRegional');
		}
		else {
			$this->objFunSeguridad=new FuncionesSeguridad();
			$this->res=$this->objFunSeguridad->listarRegional($this->objParam);
		}
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function guardarRegional(){
		$this->objFunSeguridad=new FuncionesSeguridad();
		if($this->objParam->insertar('id_regional')){
			$this->res=$this->objFunSeguridad->insertarRegional($this->objParam);			
		}
		else{			
			$this->res=$this->objFunSeguridad->modificarRegional($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
	function eliminarRegional(){
		$this->objFunSeguridad=new FuncionesSeguridad();	
		$this->res=$this->objFunSeguridad->eliminarRegional($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}

?>