<?php
/**
*@package pXP
*@file gen-ACTBranches.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:12								CREACION

*/

class ACTBranches extends ACTbase{    
			
	function listarBranches(){
		$this->objParam->defecto('ordenacion','id_branches');
		$this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_subsistema') != '') {
            $this->objParam->addFiltro("bas.id_subsistema = " . $this->objParam->getParametro('id_subsistema'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODBranches','listarBranches');
		} else{
			$this->objFunc=$this->create('MODBranches');
			
			$this->res=$this->objFunc->listarBranches($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>