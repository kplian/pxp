<?php
/**
*@package pXP
*@file gen-ACTInstitucionPersona.php
*@author fprudencio
*@date 03-12-2017 10:50:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInstitucionPersona extends ACTbase{    
			
	function listarInstitucionPersona(){
		$this->objParam->defecto('ordenacion','id_institucion_persona');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_institucion')!=''){
            $this->objParam->addFiltro("instiper.id_institucion = " . $this->objParam->getParametro('id_institucion'));    
        }
        
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODInstitucionPersona','listarInstitucionPersona');
		} else{
			$this->objFunc=$this->create('MODInstitucionPersona');
			$this->res=$this->objFunc->listarInstitucionPersona();
		}
			$this->res->imprimirRespuesta($this->res->generarJson());
		
	}
				
	function insertarInstitucionPersona(){
		$this->objFunc=$this->create('MODInstitucionPersona');
		if($this->objParam->insertar('id_institucion_persona')){
			$this->res=$this->objFunc->insertarInstitucionPersona();			
		} else{			
			$this->res=$this->objFunc->modificarInstitucionPersona();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstitucionPersona(){
		$this->objFunc=$this->create('MODInstitucionPersona');
		$this->res=$this->objFunc->eliminarInstitucionPersona();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>