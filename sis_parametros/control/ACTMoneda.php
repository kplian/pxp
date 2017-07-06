<?php
/**
*@package pXP
*@file gen-ACTMoneda.php
*@author  (admin)
*@date 05-02-2013 18:17:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMoneda extends ACTbase{    
			
	function listarMoneda(){
		$this->objParam->defecto('ordenacion','id_moneda');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_moneda')!=''){
              $this->objParam->addFiltro("id_moneda =".$this->objParam->getParametro('id_moneda'));    
         }
		
		if($this->objParam->getParametro('id_moneda_defecto')!='' && $this->objParam->getParametro('id_moneda_defecto') != 0){
              $this->objParam->addFiltro("id_moneda =".$this->objParam->getParametro('id_moneda_defecto'));    
         }
		
		if($this->objParam->getParametro('filtrar') == 'si' ){
              $this->objParam->addFiltro("show_combo = ''si''");    
        }
		
		if($this->objParam->getParametro('filtrar_base') == 'si' ){
              $this->objParam->addFiltro("tipo_moneda = ''base''");    
        }
         
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMoneda','listarMoneda');
		} else{
			$this->objFunc=$this->create('MODMoneda');
			
			$this->res=$this->objFunc->listarMoneda($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMoneda(){
		$this->objFunc=$this->create('MODMoneda');	
		if($this->objParam->insertar('id_moneda')){
			$this->res=$this->objFunc->insertarMoneda($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMoneda($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMoneda(){
		$this->objFunc=$this->create('MODMoneda');	
		$this->res=$this->objFunc->eliminarMoneda($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function getMonedaBase(){
		$this->objFunc=$this->create('MODMoneda');	
		$this->res=$this->objFunc->getMonedaBase($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>