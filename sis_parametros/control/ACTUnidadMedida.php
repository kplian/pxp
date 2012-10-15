<?php
/**
*@package pXP
*@file gen-ACTUnidadMedida.php
*@author  (admin)
*@date 08-08-2012 22:49:22
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUnidadMedida extends ACTbase{    
			
	function listarUnidadMedida(){
		$this->objParam->defecto('ordenacion','id_unidad_medida');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesParametros','listarUnidadMedida');
		} else{
			$this->objFunc=new FuncionesParametros();	
			$this->res=$this->objFunc->listarUnidadMedida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUnidadMedida(){
		$this->objFunc=new FuncionesParametros();	
		if($this->objParam->insertar('id_unidad_medida')){
			$this->res=$this->objFunc->insertarUnidadMedida($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUnidadMedida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUnidadMedida(){
		$this->objFunc=new FuncionesParametros();	
		$this->res=$this->objFunc->eliminarUnidadMedida($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>