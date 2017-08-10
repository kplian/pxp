<?php
/**
*@package pXP
*@file gen-ACTTipoArchivoCampo.php
*@author  (favio.figueroa)
*@date 09-08-2017 19:39:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoArchivoCampo extends ACTbase{    
			
	function listarTipoArchivoCampo(){
		$this->objParam->defecto('ordenacion','id_tipo_archivo_campo');

		$this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('id_tipo_archivo') != ''){
            $this->objParam->addFiltro("tipcam.id_tipo_archivo = ''".$this->objParam->getParametro('id_tipo_archivo')."''");
        }

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoArchivoCampo','listarTipoArchivoCampo');
		} else{
			$this->objFunc=$this->create('MODTipoArchivoCampo');
			
			$this->res=$this->objFunc->listarTipoArchivoCampo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoArchivoCampo(){
		$this->objFunc=$this->create('MODTipoArchivoCampo');	
		if($this->objParam->insertar('id_tipo_archivo_campo')){
			$this->res=$this->objFunc->insertarTipoArchivoCampo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoArchivoCampo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoArchivoCampo(){
			$this->objFunc=$this->create('MODTipoArchivoCampo');	
		$this->res=$this->objFunc->eliminarTipoArchivoCampo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>