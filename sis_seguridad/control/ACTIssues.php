<?php
/**
*@package pXP
*@file gen-ACTIssues.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:15
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:15								CREACION

*/

class ACTIssues extends ACTbase{    
			
	function listarIssues(){
		$this->objParam->defecto('ordenacion','id_issues');
		$this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_subsistema') != '') {
            $this->objParam->addFiltro("iss.id_subsistema = " . $this->objParam->getParametro('id_subsistema'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODIssues','listarIssues');
		} else{
			$this->objFunc=$this->create('MODIssues');
			
			$this->res=$this->objFunc->listarIssues($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>