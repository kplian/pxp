<?php
/**
*@package pXP
*@file gen-ACTUniConsMantPredef.php
*@author  (admin)
*@date 02-11-2012 15:07:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsMantPredef extends ACTbase{    
			
	function listarUniConsMantPredef(){
		$this->objParam->defecto('ordenacion','id_uni_cons_mant_predef');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniConsMantPredef');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniConsMantPredef($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsMantPredef(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_uni_cons_mant_predef')){
			$this->res=$this->objFunc->insertarUniConsMantPredef($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniConsMantPredef($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsMantPredef(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniConsMantPredef($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>