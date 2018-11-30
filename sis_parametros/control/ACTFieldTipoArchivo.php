<?php
/**
 *@package pXP
 *@file gen-ACTFieldTipoArchivo.php
 *@author  (admin)
 *@date 18-10-2017 14:28:34
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTFieldTipoArchivo extends ACTbase{

    function listarFieldTipoArchivo(){
        $this->objParam->defecto('ordenacion','id_field_tipo_archivo');

        $this->objParam->defecto('dir_ordenacion','asc');

        if($this->objParam->getParametro('id_tipo_archivo') != ''){
            $this->objParam->addFiltro("fitiar.id_tipo_archivo = ''".$this->objParam->getParametro('id_tipo_archivo')."''");
        }

        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODFieldTipoArchivo','listarFieldTipoArchivo');
        } else{
            $this->objFunc=$this->create('MODFieldTipoArchivo');

            $this->res=$this->objFunc->listarFieldTipoArchivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarFieldTipoArchivo(){
        $this->objFunc=$this->create('MODFieldTipoArchivo');
        if($this->objParam->insertar('id_field_tipo_archivo')){
            $this->res=$this->objFunc->insertarFieldTipoArchivo($this->objParam);
        } else{
            $this->res=$this->objFunc->modificarFieldTipoArchivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarFieldTipoArchivo(){
        $this->objFunc=$this->create('MODFieldTipoArchivo');
        $this->res=$this->objFunc->eliminarFieldTipoArchivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function listarFieldTipoArchivoValor(){
        $this->objFunc=$this->create('MODFieldTipoArchivo');
        $this->res=$this->objFunc->listarFieldTipoArchivoValor($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>