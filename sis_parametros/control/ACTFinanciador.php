<?php
/**
*@package pXP
*@file ACTFinanciador.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-02-2013 22:30:22
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFinanciador extends ACTbase{    
			
	function listarFinanciador(){
		$this->objParam->defecto('ordenacion','id_financiador');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODFinanciador','listarFinanciador');
		} else{
			$this->objFunc=$this->create('MODFinanciador');
			
			$this->res=$this->objFunc->listarFinanciador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFinanciador(){
		$this->objFunc=$this->create('MODFinanciador');	
		if($this->objParam->insertar('id_financiador')){
			$this->res=$this->objFunc->insertarFinanciador($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFinanciador($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFinanciador(){
			$this->objFunc=$this->create('MODFinanciador');	
		$this->res=$this->objFunc->eliminarFinanciador($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>