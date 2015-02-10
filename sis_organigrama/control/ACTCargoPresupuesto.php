<?php
/**
*@package pXP
*@file gen-ACTCargoPresupuesto.php
*@author  (admin)
*@date 15-01-2014 13:05:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCargoPresupuesto extends ACTbase{    
			
	function listarCargoPresupuesto(){
		$this->objParam->defecto('ordenacion','id_cargo_presupuesto');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_cargo') != '') {
			$this->objParam->addFiltro("carpre.id_cargo = ". $this->objParam->getParametro('id_cargo'));
		}
		
		if ($this->objParam->getParametro('id_gestion') != '') {
			$this->objParam->addFiltro("carpre.id_gestion = ". $this->objParam->getParametro('id_gestion'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCargoPresupuesto','listarCargoPresupuesto');
		} else{
			$this->objFunc=$this->create('MODCargoPresupuesto');
			
			$this->res=$this->objFunc->listarCargoPresupuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCargoPresupuesto(){
		$this->objFunc=$this->create('MODCargoPresupuesto');	
		if($this->objParam->insertar('id_cargo_presupuesto')){
			$this->res=$this->objFunc->insertarCargoPresupuesto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCargoPresupuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCargoPresupuesto(){
			$this->objFunc=$this->create('MODCargoPresupuesto');	
		$this->res=$this->objFunc->eliminarCargoPresupuesto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>