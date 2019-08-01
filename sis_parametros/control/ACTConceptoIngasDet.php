<?php
/**
*@package pXP
*@file gen-ACTConceptoIngasDet.php
*@author  (admin)
*@date 22-07-2019 14:37:28
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
  ISSUE			AUTHOR			FECHA				DESCRIPCION
 * #39 ETR		EGS				31/07/2019			Creacion
 */

class ACTConceptoIngasDet extends ACTbase{    
			
	function listarConceptoIngasDet(){
		$this->objParam->defecto('ordenacion','id_concepto_ingas_det');
        if($this->objParam->getParametro('id_concepto_ingas')!='' ){
            $this->objParam->addFiltro("coind.id_concepto_ingas = ".$this->objParam->getParametro('id_concepto_ingas'));
        }
        if($this->objParam->getParametro('agrupador') !='' ){
            $this->objParam->addFiltro("coind.agrupador = ''".$this->objParam->getParametro('agrupador')."''");
        }
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODConceptoIngasDet','listarConceptoIngasDet');
		} else{
			$this->objFunc=$this->create('MODConceptoIngasDet');
			
			$this->res=$this->objFunc->listarConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConceptoIngasDet(){
		$this->objFunc=$this->create('MODConceptoIngasDet');	
		if($this->objParam->insertar('id_concepto_ingas_det')){
			$this->res=$this->objFunc->insertarConceptoIngasDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarConceptoIngasDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConceptoIngasDet(){
			$this->objFunc=$this->create('MODConceptoIngasDet');	
		$this->res=$this->objFunc->eliminarConceptoIngasDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
			
}

?>