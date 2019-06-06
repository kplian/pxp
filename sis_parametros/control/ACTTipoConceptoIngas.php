<?php
/**
*@package pXP
*@file gen-ACTTipoConceptoIngas.php
*@author  (egutierrez)
*@date 29-04-2019 13:28:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoConceptoIngas extends ACTbase{    
			
	function listarTipoConceptoIngas(){
		$this->objParam->defecto('ordenacion','id_tipo_concepto_ingas');

		if($this->objParam->getParametro('id_concepto_ingas')!=''){
			$this->objParam->addFiltro("ticoing.id_concepto_ingas = ".$this->objParam->getParametro('id_concepto_ingas'));	
		}
		if($this->objParam->getParametro('id_tipo_concepto_ingas')!=''){
			$this->objParam->addFiltro("ticoing.id_tipo_concepto_ingas = ".$this->objParam->getParametro('id_tipo_concepto_ingas'));	
		}

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoConceptoIngas','listarTipoConceptoIngas');
		} else{
			$this->objFunc=$this->create('MODTipoConceptoIngas');
			
			$this->res=$this->objFunc->listarTipoConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoConceptoIngas(){
		$this->objFunc=$this->create('MODTipoConceptoIngas');	
		if($this->objParam->insertar('id_tipo_concepto_ingas')){
			$this->res=$this->objFunc->insertarTipoConceptoIngas($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoConceptoIngas($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoConceptoIngas(){
			$this->objFunc=$this->create('MODTipoConceptoIngas');	
		$this->res=$this->objFunc->eliminarTipoConceptoIngas($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function listarTipoConceptoIngasCombo(){
		$this->objParam->defecto('ordenacion','id_tipo_concepto_ingas');
		if($this->objParam->getParametro('id_concepto_ingas')!=''){
			$this->objParam->addFiltro("ticoing.id_concepto_ingas = ".$this->objParam->getParametro('id_concepto_ingas'));	
		}

		$this->objParam->defecto('dir_ordenacion','asc');

		$this->objFunc=$this->create('MODTipoConceptoIngas');
			
		$this->res=$this->objFunc->listarTipoConceptoIngasCombo($this->objParam);
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		
			
}

?>