<?php
/**
*@package pXP
*@file gen-ACTTipoProcesoOrigen.php
*@author  (admin)
*@date 09-06-2014 17:03:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoProcesoOrigen extends ACTbase{    
			
	function listarTipoProcesoOrigen(){
		$this->objParam->defecto('ordenacion','id_tipo_proceso_origin');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_tipo_proceso')!=''){
            $this->objParam->addFiltro("tpo.id_tipo_proceso = ".$this->objParam->getParametro('id_tipo_proceso'));    
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoProcesoOrigen','listarTipoProcesoOrigen');
		} else{
			$this->objFunc=$this->create('MODTipoProcesoOrigen');
			
			$this->res=$this->objFunc->listarTipoProcesoOrigen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoProcesoOrigen(){
		$this->objFunc=$this->create('MODTipoProcesoOrigen');	
		if($this->objParam->insertar('id_tipo_proceso_origin')){
			$this->res=$this->objFunc->insertarTipoProcesoOrigen($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoProcesoOrigen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoProcesoOrigen(){
			$this->objFunc=$this->create('MODTipoProcesoOrigen');	
		$this->res=$this->objFunc->eliminarTipoProcesoOrigen($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>