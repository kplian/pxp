<?php
/**
*@package pXP
*@file gen-ACTInstitucion.php
*@author  (gvelasquez)
*@date 21-09-2011 10:50:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInstitucion extends ACTbase{    
			
	function listarInstitucion(){
		$this->objParam->defecto('ordenacion','id_institucion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_institucion')!=''){
            $this->objParam->addFiltro("instit.id_institucion = " . $this->objParam->getParametro('id_institucion'));    
        }
        
        if($this->objParam->getParametro('es_banco')!=''){
            $this->objParam->addFiltro("instit.es_banco = ''".$this->objParam->getParametro('es_banco')."''");    
        }
		
		if($this->objParam->getParametro('no_es_proveedor')!=''){
            $this->objParam->addFiltro("instit.id_institucion not in (select id_institucion 
            															from param.tproveedor 
            															where id_institucion = instit.id_institucion)");    
        }
        
        
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODInstitucion','listarInstitucion');
		} else{
			$this->objFunc=$this->create('MODInstitucion');
			$this->res=$this->objFunc->listarInstitucion();
		}
			$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
				
	function insertarInstitucion(){
		$this->objFunc=$this->create('MODInstitucion');
		if($this->objParam->insertar('id_institucion')){
			$this->res=$this->objFunc->insertarInstitucion();			
		} else{			
			$this->res=$this->objFunc->modificarInstitucion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstitucion(){
		$this->objFunc=$this->create('MODInstitucion');
		$this->res=$this->objFunc->eliminarInstitucion();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>