<?php
/**
*@package pXP
*@file ACTProyecto.php
*@author  Gonzalo Sarmiento Sejas
*@date 06-02-2013 17:04:17
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTProyecto extends ACTbase{    
			
	function listarProyecto(){
		$this->objParam->defecto('ordenacion','id_proyecto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODProyecto','listarProyecto');
		} else{
			$this->objFunc=$this->create('MODProyecto');
			
			$this->res=$this->objFunc->listarProyecto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarProyecto(){
		$this->objFunc=$this->create('MODProyecto');	
		if($this->objParam->insertar('id_proyecto')){
			$this->res=$this->objFunc->insertarProyecto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarProyecto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarProyecto(){
			$this->objFunc=$this->create('MODProyecto');	
		$this->res=$this->objFunc->eliminarProyecto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>