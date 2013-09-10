<?php
/**
*@package pXP
*@file gen-ACTGestion.php
*@author  (admin)
*@date 05-02-2013 09:56:59
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGestion extends ACTbase{    
			
	function listarGestion(){
		$this->objParam->defecto('ordenacion','id_gestion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGestion','listarGestion');
		} else{
			$this->objFunc=$this->create('MODGestion');
			
			$this->res=$this->objFunc->listarGestion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGestion(){
		$this->objFunc=$this->create('MODGestion');	
		if($this->objParam->insertar('id_gestion')){
			$this->res=$this->objFunc->insertarGestion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGestion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGestion(){
		$this->objFunc=$this->create('MODGestion');	
		$this->res=$this->objFunc->eliminarGestion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function obtenerGestionByFecha(){
            $this->objFunc=$this->create('MODGestion'); 
        $this->res=$this->objFunc->obtenerGestionByFecha($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	
	//RCM 03/09/2013: Genera los periodos de los subsistema faltantes
	function sincronizarPeriodoSubsis(){
		$this->objFunc=$this->create('MODGestion');	
		$this->res=$this->objFunc->sincronizarPeriodoSubsis($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
			
}

?>