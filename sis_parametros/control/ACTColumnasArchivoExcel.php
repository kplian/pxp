<?php
/**
*@package pXP
*@file gen-ACTColumnasArchivoExcel.php
*@author  (gsarmiento)
*@date 15-12-2016 20:46:43
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTColumnasArchivoExcel extends ACTbase{    
			
	function listarColumnasArchivoExcel(){
		$this->objParam->defecto('ordenacion','id_columna_archivo_excel');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODColumnasArchivoExcel','listarColumnasArchivoExcel');
		} else{
			$this->objFunc=$this->create('MODColumnasArchivoExcel');
			
			$this->res=$this->objFunc->listarColumnasArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarColumnasArchivoExcelporCodigoArchivo($codigo){
		$this->objParam->defecto('ordenacion','id_columna_archivo_excel');
		$this->objParam->defecto('dir_ordenacion','asc');
		$this->objParam->addParametro('codigo',$codigo);
		$this->objFunc=$this->create('MODColumnasArchivoExcel');
		$this->res=$this->objFunc->listarColumnasArchivoExcelporCodigoArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarColumnasArchivoExcel(){
		$this->objFunc=$this->create('MODColumnasArchivoExcel');	
		if($this->objParam->insertar('id_columna_archivo_excel')){
			$this->res=$this->objFunc->insertarColumnasArchivoExcel($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarColumnasArchivoExcel($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarColumnasArchivoExcel(){
			$this->objFunc=$this->create('MODColumnasArchivoExcel');	
		$this->res=$this->objFunc->eliminarColumnasArchivoExcel($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>