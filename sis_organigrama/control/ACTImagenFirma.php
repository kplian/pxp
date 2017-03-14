<?php
/**
 *@package pXP
 *@file gen-ACTArchivo.php
 *@author  (admin)
 *@date 05-12-2016 15:04:48
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTImagenFirma extends ACTbase{


    function descargarImagenFirmaBoa(){
        $this->objFunc=$this->create('MODImagenFirma');
        $this->res=$this->objFunc->descargarImagenFirmaBoa($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>