<?php
/**
 *@package pXP
 *@file gen-ACTFieldValorArchivo.php
 *@author  (admin)
 *@date 19-10-2017 15:00:59
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTFieldValorArchivo extends ACTbase{

    function listarFieldValorArchivo(){
        $this->objParam->defecto('ordenacion','id_field_valor_archivo');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODFieldValorArchivo','listarFieldValorArchivo');
        } else{
            $this->objFunc=$this->create('MODFieldValorArchivo');

            $this->res=$this->objFunc->listarFieldValorArchivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarFieldValorArchivo(){
        $this->objFunc=$this->create('MODFieldValorArchivo');
        if($this->objParam->insertar('id_field_valor_archivo')){
            $this->res=$this->objFunc->insertarFieldValorArchivo($this->objParam);
        } else{
            $this->res=$this->objFunc->modificarFieldValorArchivo($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarFieldValorArchivo(){
        $this->objFunc=$this->create('MODFieldValorArchivo');
        $this->res=$this->objFunc->eliminarFieldValorArchivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function insertarFieldValorArchivoJson(){
        $this->objFunc=$this->create('MODFieldValorArchivo');
        $this->res=$this->objFunc->insertarFieldValorArchivoJson($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>