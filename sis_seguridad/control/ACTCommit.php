<?php
/**
*@package pXP
*@file gen-ACTCommit.php
*@author  (miguel.mamani)
*@date 09-01-2020 21:26:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:18								CREACION

*/

class ACTCommit extends ACTbase{    
			
	function listarCommit(){
		$this->objParam->defecto('ordenacion','id_commit');
		$this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('id_branches') != '') {
            $this->objParam->addFiltro("com.id_branches = " . $this->objParam->getParametro('id_branches'));
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCommit','listarCommit');
		} else{
			$this->objFunc=$this->create('MODCommit');
			
			$this->res=$this->objFunc->listarCommit($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>