<?php
/**
 *@package pXP
 *@file gen-ACTPeriodoSubsistema.php
 *@author  Ariel Ayaviri Omonte
 *@date 19-03-2013 13:58:30
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTPeriodoSubsistema extends ACTbase {

    function listarPeriodoSubsistema() {
        $this->objParam->defecto('ordenacion', 'gest.gestion desc, peri.periodo desc');
		
		if($this->objParam->getParametro('id_periodo')!=''){
			$this->objParam->addFiltro("pesu.id_periodo = ".$this->objParam->getParametro('id_periodo'));	
		}
		
		if($this->objParam->getParametro('id_gestion')!=''){
			$this->objParam->addFiltro("peri.id_gestion = ".$this->objParam->getParametro('id_gestion'));	
		}
		
		if($this->objParam->getParametro('codSist')!=''){
			$this->objParam->addFiltro("sis.codigo = ''".$this->objParam->getParametro('codSist')."''");	
		}
		
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODPeriodoSubsistema', 'listarPeriodoSubsistema');
        } else {
            $this->objFunc = $this->create('MODPeriodoSubsistema');

            $this->res = $this->objFunc->listarPeriodoSubsistema($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarPeriodoSubsistema() {
        $this->objFunc = $this->create('MODPeriodoSubsistema');
        if ($this->objParam->insertar('id_periodo_subsistema')) {
            $this->res = $this->objFunc->insertarPeriodoSubsistema($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarPeriodoSubsistema($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarPeriodoSubsistema() {
        $this->objFunc = $this->create('MODPeriodoSubsistema');
        $this->res = $this->objFunc->eliminarPeriodoSubsistema($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function generarPeriodoSubsistema() {
        $this->objFunc = $this->create('MODPeriodoSubsistema');
        $this->res = $this->objFunc->generarPeriodoSubsistema($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function switchEstadoPeriodo() {
        $this->objFunc = $this->create('MODPeriodoSubsistema');
        $this->res = $this->objFunc->switchEstadoPeriodo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}
?>