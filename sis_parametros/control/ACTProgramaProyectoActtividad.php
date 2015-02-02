<?php
/**
*@package pXP
*@file ACTProgramaProyectoActtividad.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 16:04:45
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProgramaProyectoActtividad extends ACTbase{    
			
	function listarProgramaProyectoActtividad(){
		$this->objParam->defecto('ordenacion','id_prog_pory_acti');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProgramaProyectoActtividad','listarProgramaProyectoActtividad');
		} else{
			$this->objFunc=$this->create('MODProgramaProyectoActtividad');
			
			$this->res=$this->objFunc->listarProgramaProyectoActtividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProgramaProyectoActtividad(){
		$this->objFunc=$this->create('MODProgramaProyectoActtividad');	
		if($this->objParam->insertar('id_prog_pory_acti')){
			$this->res=$this->objFunc->insertarProgramaProyectoActtividad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProgramaProyectoActtividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProgramaProyectoActtividad(){
			$this->objFunc=$this->create('MODProgramaProyectoActtividad');	
		$this->res=$this->objFunc->eliminarProgramaProyectoActtividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>