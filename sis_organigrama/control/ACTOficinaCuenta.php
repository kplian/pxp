<?php
/**
*@package pXP
*@file gen-ACTOficinaCuenta.php
*@author  (jrivera)
*@date 31-07-2014 22:57:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTOficinaCuenta extends ACTbase{    
			
	function listarOficinaCuenta(){
		$this->objParam->defecto('ordenacion','id_oficina_cuenta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_oficina') != '') {
			$this->objParam->addFiltro("ofcu.id_oficina = ". $this->objParam->getParametro('id_oficina'));
		}	
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODOficinaCuenta','listarOficinaCuenta');
		} else{
			$this->objFunc=$this->create('MODOficinaCuenta');
			
			$this->res=$this->objFunc->listarOficinaCuenta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOficinaCuenta(){
		$this->objFunc=$this->create('MODOficinaCuenta');	
		if($this->objParam->insertar('id_oficina_cuenta')){
			$this->res=$this->objFunc->insertarOficinaCuenta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarOficinaCuenta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOficinaCuenta(){
			$this->objFunc=$this->create('MODOficinaCuenta');	
		$this->res=$this->objFunc->eliminarOficinaCuenta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>