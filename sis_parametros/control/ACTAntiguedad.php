<?php
/**
*@package pXP
*@file gen-ACTAntiguedad.php
*@author  (szambrana)
*@date 17-10-2019 14:41:21
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				17-10-2019 14:41:21								CREACION

*/

class ACTAntiguedad extends ACTbase{    
			
	function listarAntiguedad(){
		$this->objParam->defecto('ordenacion','id_antiguedad');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_gestion') != ''){
			$this->objParam->addFiltro("antig.id_gestion = ".$this->objParam->getParametro('id_gestion'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAntiguedad','listarAntiguedad');
		} else{
			$this->objFunc=$this->create('MODAntiguedad');
			
			$this->res=$this->objFunc->listarAntiguedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAntiguedad(){
		$this->objFunc=$this->create('MODAntiguedad');	
		if($this->objParam->insertar('id_antiguedad')){
			$this->res=$this->objFunc->insertarAntiguedad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAntiguedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAntiguedad(){
			$this->objFunc=$this->create('MODAntiguedad');	
		$this->res=$this->objFunc->eliminarAntiguedad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>