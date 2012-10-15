<?php
/**
*@package pXP
*@file gen-ACTUniCons.php
*@author  (rac)
*@date 09-08-2012 00:42:57
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniCons extends ACTbase{    
			
	function listarUniCons(){
		$this->objParam->defecto('ordenacion','id_uni_cons');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniCons');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniCons($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniCons(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_uni_cons')){
			$this->res=$this->objFunc->insertarUniCons($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniCons($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniCons(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniCons($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>