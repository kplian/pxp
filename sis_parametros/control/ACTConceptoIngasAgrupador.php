<?php
/**
 *@package pXP
 *@file gen-ACTConceptoIngasAgrupador.php
 *@author  (egutierrez)
 *@date 02-09-2019 21:07:26
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTConceptoIngasAgrupador extends ACTbase{

    function listarConceptoIngasAgrupador(){
        $this->objParam->defecto('ordenacion','id_concepto_ingas_agrupador');
        if($this->objParam->getParametro('tipo_agrupador')!=''){
            $this->objParam->addFiltro("coinagr.tipo_agrupador =''".$this->objParam->getParametro('tipo_agrupador')."''");
        }
        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODConceptoIngasAgrupador','listarConceptoIngasAgrupador');
        } else{
            $this->objFunc=$this->create('MODConceptoIngasAgrupador');

            $this->res=$this->objFunc->listarConceptoIngasAgrupador($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarConceptoIngasAgrupador(){
        $this->objFunc=$this->create('MODConceptoIngasAgrupador');
        if($this->objParam->insertar('id_concepto_ingas_agrupador')){
            $this->res=$this->objFunc->insertarConceptoIngasAgrupador($this->objParam);
        } else{
            $this->res=$this->objFunc->modificarConceptoIngasAgrupador($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarConceptoIngasAgrupador(){
        $this->objFunc=$this->create('MODConceptoIngasAgrupador');
        $this->res=$this->objFunc->eliminarConceptoIngasAgrupador($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function insertarAgrupador(){
        $this->objFunc=$this->create('MODConceptoIngasAgrupador');
        $this->res=$this->objFunc->insertarAgrupador($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function insertObraCivil(){
        $this->objFunc=$this->create('MODConceptoIngasAgrupador');
        $this->res=$this->objFunc->insertObraCivil($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>