<?php
/**
*@package pXP
*@file gen-ACTTipoCompTipoProp.php
*@author  (admin)
*@date 15-05-2014 20:53:23
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoCompTipoProp extends ACTbase{    
			
	function listarTipoCompTipoProp(){
		$this->objParam->defecto('ordenacion','id_tipo_comp_tipo_prop');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tipo_componente')!=''){
			$this->objParam->addFiltro("tcotpr.id_tipo_componente = ".$this->objParam->getParametro('id_tipo_componente'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoCompTipoProp','listarTipoCompTipoProp');
		} else{
			$this->objFunc=$this->create('MODTipoCompTipoProp');
			
			$this->res=$this->objFunc->listarTipoCompTipoProp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoCompTipoProp(){
		$this->objFunc=$this->create('MODTipoCompTipoProp');	
		if($this->objParam->insertar('id_tipo_comp_tipo_prop')){
			$this->res=$this->objFunc->insertarTipoCompTipoProp($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoCompTipoProp($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoCompTipoProp(){
			$this->objFunc=$this->create('MODTipoCompTipoProp');	
		$this->res=$this->objFunc->eliminarTipoCompTipoProp($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>