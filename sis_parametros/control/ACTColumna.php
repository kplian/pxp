<?php
/**
*@package pXP
*@file gen-ACTColumna.php
*@author  (egutierrez)
*@date 07-08-2019 15:43:48
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
ISSUE       FECHA           AUTHOR          DESCRIPCION
#48         14/08/2019      EGS             CREACION
 */

class ACTColumna extends ACTbase{    
			
	function listarColumna(){
		$this->objParam->defecto('ordenacion','id_columna');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODColumna','listarColumna');
		} else{
			$this->objFunc=$this->create('MODColumna');
			
			$this->res=$this->objFunc->listarColumna($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarColumna(){
		$this->objFunc=$this->create('MODColumna');	
		if($this->objParam->insertar('id_columna')){
			$this->res=$this->objFunc->insertarColumna($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarColumna($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarColumna(){
			$this->objFunc=$this->create('MODColumna');	
		$this->res=$this->objFunc->eliminarColumna($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>