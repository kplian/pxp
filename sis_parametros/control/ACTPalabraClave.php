<?php
/****************************************************************************************
*@package pXP
*@file gen-ACTPalabraClave.php
*@author  (RAC)
*@date 21-04-2020 02:54:58
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo

 HISTORIAL DE MODIFICACIONES:
 #ISSUE                FECHA                AUTOR                DESCRIPCION
  #0                21-04-2020 02:54:58    RAC             Creacion    
  #
*****************************************************************************************/

class ACTPalabraClave extends ACTbase{    
            
    function listarPalabraClave(){
		$this->objParam->defecto('ordenacion','id_palabra_clave');

        $this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODPalabraClave','listarPalabraClave');
        } else{
        	$this->objFunc=$this->create('MODPalabraClave');
            
        	$this->res=$this->objFunc->listarPalabraClave($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarPalabraClave(){
        $this->objFunc=$this->create('MODPalabraClave');    
        if($this->objParam->insertar('id_palabra_clave')){
            $this->res=$this->objFunc->insertarPalabraClave($this->objParam);            
        } else{            
            $this->res=$this->objFunc->modificarPalabraClave($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarPalabraClave(){
        	$this->objFunc=$this->create('MODPalabraClave');    
        $this->res=$this->objFunc->eliminarPalabraClave($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>