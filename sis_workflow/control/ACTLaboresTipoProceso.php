<?php
/**
*@package pXP
*@file gen-ACTLaboresTipoProceso.php
*@author  (admin)
*@date 15-03-2013 16:08:41
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLaboresTipoProceso extends ACTbase{    
			
	function listarLaboresTipoProceso(){
		$this->objParam->defecto('ordenacion','id_labores_tipo_proceso');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODLaboresTipoProceso','listarLaboresTipoProceso');
		} else{
			$this->objFunc=$this->create('MODLaboresTipoProceso');
			
			$this->res=$this->objFunc->listarLaboresTipoProceso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLaboresTipoProceso(){
		$this->objFunc=$this->create('MODLaboresTipoProceso');	
		if($this->objParam->insertar('id_labores_tipo_proceso')){
			$this->res=$this->objFunc->insertarLaboresTipoProceso($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLaboresTipoProceso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLaboresTipoProceso(){
			$this->objFunc=$this->create('MODLaboresTipoProceso');	
		$this->res=$this->objFunc->eliminarLaboresTipoProceso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>