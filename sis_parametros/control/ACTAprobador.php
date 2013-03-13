<?php
/**
*@package pXP
*@file gen-ACTAprobador.php
*@author  (admin)
*@date 09-01-2013 21:58:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAprobador extends ACTbase{    
			
	function listarAprobador(){
		$this->objParam->defecto('ordenacion','id_aprobador');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAprobador','listarAprobador');
		} else{
			$this->objFunc=$this->create('MODAprobador');
			
			$this->res=$this->objFunc->listarAprobador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	 function listarAprobadorFiltrado(){
        $this->objParam->defecto('ordenacion','prioridad');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objFunc=$this->create('MODAprobador');
        $this->res=$this->objFunc->listarAprobadorFiltrado($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarAprobador(){
		$this->objFunc=$this->create('MODAprobador');	
		if($this->objParam->insertar('id_aprobador')){
			$this->res=$this->objFunc->insertarAprobador($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAprobador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAprobador(){
			$this->objFunc=$this->create('MODAprobador');	
		$this->res=$this->objFunc->eliminarAprobador($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>