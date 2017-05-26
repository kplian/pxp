<?php
/**
*@package pXP
*@file gen-ACTTipoArchivo.php
*@author  (admin)
*@date 05-12-2016 15:03:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoArchivo extends ACTbase{    
			
	function listarTipoArchivo(){
		$this->objParam->defecto('ordenacion','id_tipo_archivo');

		$this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('tabla')!=''){
            $this->objParam->addFiltro("tipar.tabla = ''".$this->objParam->getParametro('tabla')."''");
        }
        if($this->objParam->getParametro('multiple')!=''){
            $this->objParam->addFiltro("tipar.multiple = ''".$this->objParam->getParametro('multiple')."''");
        }

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoArchivo','listarTipoArchivo');
		} else{
			$this->objFunc=$this->create('MODTipoArchivo');
			
			$this->res=$this->objFunc->listarTipoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoArchivo(){
		$this->objFunc=$this->create('MODTipoArchivo');	
		if($this->objParam->insertar('id_tipo_archivo')){
			$this->res=$this->objFunc->insertarTipoArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoArchivo(){
			$this->objFunc=$this->create('MODTipoArchivo');	
		$this->res=$this->objFunc->eliminarTipoArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>