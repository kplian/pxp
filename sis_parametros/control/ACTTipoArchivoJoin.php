<?php
/**
*@package pXP
*@file gen-ACTTipoArchivoJoin.php
*@author  (favio.figueroa)
*@date 09-08-2017 20:03:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoArchivoJoin extends ACTbase{    
			
	function listarTipoArchivoJoin(){
		$this->objParam->defecto('ordenacion','id_tipo_archivo_join');

		$this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('id_tipo_archivo') != ''){
            $this->objParam->addFiltro("tajoin.id_tipo_archivo = ''".$this->objParam->getParametro('id_tipo_archivo')."''");
        }

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoArchivoJoin','listarTipoArchivoJoin');
		} else{
			$this->objFunc=$this->create('MODTipoArchivoJoin');
			
			$this->res=$this->objFunc->listarTipoArchivoJoin($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoArchivoJoin(){
		$this->objFunc=$this->create('MODTipoArchivoJoin');	
		if($this->objParam->insertar('id_tipo_archivo_join')){
			$this->res=$this->objFunc->insertarTipoArchivoJoin($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoArchivoJoin($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoArchivoJoin(){
			$this->objFunc=$this->create('MODTipoArchivoJoin');	
		$this->res=$this->objFunc->eliminarTipoArchivoJoin($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>